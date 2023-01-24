#pragma execution_character_set("utf-8")
#include <Windows.h>
#include <iostream>
#include "combaseapi.h"
#include "../headers/IGeoConnectDB.h"

int main() {
    // Дескрипторы DLL-библиотек
    HMODULE hGeodataDll;

    // Загружаем динамически подключаемые библиотеки
    hGeodataDll = LoadLibrary(TEXT("geodata_x86_64.dll"));
    if(!hGeodataDll)
    {
        std::cout << "geodata_x86_64.dll не загружена" << std::endl;
        return (int)GetLastError();
    }

    /* Implementation pas
     * function GetModuleObject(ObjectID: TGuid; InterfaceID: TGuid; out ppvObj): HRESULT;
     * external NameGeoDataDll Name 'GetModuleObject';
     * function GeoTestConnect: integer;
     * external NameGeoDataDll Name 'TestConnect';
     */
    // Указатели на функции
    int (*TestConnect) ();
    //HRESULT (*GetModuleObject) (GUID ObjectID, GUID InterfaceID, geo::IGeoConnectDB*&) ;
    typedef HRESULT(__stdcall* TGetDll)(GUID ObjectID, GUID InterfaceID, geo::IGeoConnectDB*&);
    TGetDll GetModuleObject;    // Function pointer

    // Настраиваем адреса функций
    TestConnect = (int (*)())GetProcAddress(hGeodataDll, "TestConnect");
    if(!TestConnect)
    {
        std::cout << "Ошибка получения адреса функции TestConnect" << std::endl;
        return (int)GetLastError();
    }
    //GetModuleObject = (HRESULT (*)(GUID ObjectID, GUID InterfaceID, geo::IGeoConnectDB*&))GetProcAddress(hGeodataDll, "GetModuleObject");
    GetModuleObject = (TGetDll)::GetProcAddress(hGeodataDll, "GetModuleObject");
    if(!GetModuleObject)
    {
        std::cout << "Ошибка получения адреса функции GetModuleObject" << std::endl;
        return (int)GetLastError();
    }

    // Вызываем функции из библиотек
    std::cout << TestConnect() << std::endl;

    BSTR dbServerName = SysAllocString(L"localhost:3050");
    BSTR dbBaseName = SysAllocString(L"D:\\Projects\\CLionProjects\\TP2-interface-db\\techgeosystem40.gdb");
    BSTR dbUser = SysAllocString(L"SYSDBA");
    BSTR dbPas = SysAllocString(L"masterkey");
    BSTR err;
    bool gdbOk = FALSE;

    geo::IGeoConnectDB* gdb = NULL;

    auto GeoConnectorFB21 = std::byte{1};
    GUID OBJID_GeoConnectDB;
    CLSIDFromString(L"{9F62C480-6D59-4AE9-8086-6B858B9452B1}", &OBJID_GeoConnectDB );
    GUID IntID; //?? not sure
    CLSIDFromString(L"{1245DEE9-22FA-4040-BF25-4F52B4BB348F}", &IntID );

    /* TODO - Call pas
     * gdb: IGeoConnectDB;
     * if GetModuleObject(OBJID_GeoConnectDB, IGeoConnectDB, gdb) = S_OK then
     * gdbOk := gdb.ConnectDB(GeoConnectorFB21, dbUser, dbPas, dbServerName,
     * dbBaseName, err) = S_OK;
     */
    /*if(GetModuleObject(OBJID_GeoConnectDB, IntID, *&gdb) == S_OK){
        gdbOk = gdb->ConnectDB(GeoConnectorFB21, dbUser, dbPas, dbServerName, dbBaseName,
                              err) == S_OK;
    }*/
    //std::cout << GetModuleObject(OBJID_GeoConnectDB, IntID, gdb) << std::endl;

    if (GetModuleObject(OBJID_GeoConnectDB, IntID, gdb) == S_OK){ //segmentation fault b4
        gdbOk = gdb->ConnectDB(GeoConnectorFB21,dbUser,dbPas, dbServerName,dbBaseName, err) == S_OK;//segmentation fault
    }
    std::cout << gdbOk << std::endl;
    gdb->Disconnect();

    SysFreeString(dbServerName);
    SysFreeString(dbBaseName);
    SysFreeString(dbUser);
    SysFreeString(dbPas);
    SysFreeString(err);

    // Отключаем библиотеки
    if(!FreeLibrary(hGeodataDll))
    {
        std::cout << "Ошибка выгрузки geodata_x86_64.dll из памяти" << std::endl;
        return (int)GetLastError();
    }
    return 0;
}
