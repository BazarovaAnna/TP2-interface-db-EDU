#include <Windows.h>
#include <iostream>
#include "../headers/IGeoConnectDB.h"

int main() {
    // Дескрипторы DLL-библиотек
    HMODULE hGeodataDll, hFbclientDll;

    // Загружаем динамически подключаемые библиотеки
    hGeodataDll = LoadLibrary("geodata_x86_64.dll");
    if(!hGeodataDll)
    {
        std::cout << "geodata_x86_64.dll не загружена" << std::endl;
        return (int)GetLastError();
    }
    hFbclientDll = LoadLibrary("fbclient.dll");
    if(!hFbclientDll)
    {
        std::cout << "fbclient.dll не загружена" << std::endl;
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
    HRESULT (*GetModuleObject) ;

    // Настраиваем адреса функций
    TestConnect = (int (*)())GetProcAddress(hGeodataDll, "TestConnect");
    if(!TestConnect)
    {
        std::cout << "Ошибка получения адреса функции TestConnect" << std::endl;
        return (int)GetLastError();
    }
    GetModuleObject = (HRESULT (*))GetProcAddress(hFbclientDll, "GetModuleObject");
    if(!GetModuleObject)
    {
        std::cout << "Ошибка получения адреса функции GetModuleObject" << std::endl;
        return (int)GetLastError();
    }

    // Вызываем функции из библиотек
    std::cout << TestConnect() << std::endl;

    BSTR dbServerName = SysAllocString(L"192.168.1.171");
    BSTR dbBaseName = SysAllocString(L"v9_install_tech_geosystem_40");
    BSTR dbUser = SysAllocString(L"SYSDBA");
    BSTR dbPas = SysAllocString(L"masterkey");
    BSTR err;
    bool gdbOk = FALSE;

    /* TODO - Call pas
     * if GetModuleObject(OBJID_GeoConnectDB, IGeoConnectDB, gdb) = S_OK then
     * gdbOk := gdb.ConnectDB(GeoConnectorFB21, dbUser, dbPas, dbServerName,
     * dbBaseName, err) = S_OK;
     */
    /* TODO - Finalization pas
     * gdb.Disconnect;
     * gdb := nil;
     */



    // Отключаем библиотеки
    if(!FreeLibrary(hGeodataDll))
    {
        std::cout << "Ошибка выгрузки geodata_x86_64.dll из памяти" << std::endl;
        return (int)GetLastError();
    }
    if(!FreeLibrary(hFbclientDll))
    {
        std::cout << "Ошибка выгрузки fbclient.dll из памяти" << std::endl;
        return (int)GetLastError();
    }
    return 0;
}
