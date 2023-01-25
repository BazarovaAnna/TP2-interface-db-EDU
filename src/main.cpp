#pragma execution_character_set("utf-8")
#include <Windows.h>
#include <iostream>
#include "combaseapi.h"
#include "../headers/IGeoConnectDB.h"

int main() {
    SetConsoleOutputCP(CP_UTF8);
    // Дескрипторы DLL-библиотек
    HMODULE hGeodataDll;

    // Загружаем динамически подключаемые библиотеки
    hGeodataDll = LoadLibrary(TEXT("geodata_x86_64.dll"));
    if(!hGeodataDll)
    {
        std::cout << "geodata_x86_64.dll не загружена" << std::endl;
        return (int)GetLastError();
    }

    /** Implementation pas
     * function GetGeoConnect(out ppvObj): HRESULT; stdcall;
     * external NameGeoDataDll Name 'GetGeoConnect';
     * ///function GetModuleObject(ObjectID: TGuid; InterfaceID: TGuid; out ppvObj): HRESULT;
     * ///external NameGeoDataDll Name 'GetModuleObject';
     * function GeoTestConnect: integer;
     * external NameGeoDataDll Name 'TestConnect';
     */
    // Указатели на функции
    int (*TestConnect) ();
    typedef HRESULT(__stdcall* TGetGeoConnectDLL)(geo::IGeoConnectDB*&);
    TGetGeoConnectDLL GetGeoConnect;    // Function pointer

    // Настраиваем адреса функций
    TestConnect = (int (*)())GetProcAddress(hGeodataDll, "TestConnect");
    if(!TestConnect)
    {
        std::cout << "Ошибка получения адреса функции TestConnect" << std::endl;
        return (int)GetLastError();
    }
    GetGeoConnect = (TGetGeoConnectDLL)::GetProcAddress(hGeodataDll, "GetGeoConnect");
    if(!GetGeoConnect)
    {
        std::cout << "Ошибка получения адреса функции GetGeoConnect" << std::endl;
        return (int)GetLastError();
    }

    // Вызываем функции из библиотек
    std::cout << TestConnect() << std::endl;

    std::string dbServerName = "localhost:3050";
    ///поменять на свой путь!
    std::string dbBaseName = R"(D:\Projects\CLionProjects\TP2-interface-db\techgeosystem40.gdb)";
    std::string dbUser = "SYSDBA";
    std::string dbPas = "masterkey";
    std::string err;
    bool gdbOk = FALSE;

    geo::IGeoConnectDB* gdb = nullptr;
    auto GeoConnectorFB21 = std::byte{1};

    /** Call pas
     * gdb: IGeoConnectDB;
     * if GetModuleObject(OBJID_GeoConnectDB, IGeoConnectDB, gdb) = S_OK then
     * gdbOk := gdb.ConnectDB(GeoConnectorFB21, dbUser, dbPas, dbServerName,
     * dbBaseName, err) = S_OK;
     */

    if (GetGeoConnect(gdb) == S_OK){ //segmentation fault b4
        gdbOk = gdb->ConnectDB(GeoConnectorFB21,dbUser,dbPas, dbServerName,dbBaseName, err) == S_OK;//segmentation fault
    }
    std::cout << gdbOk << std::endl;
    gdb->Disconnect();

    // Отключаем библиотеки
    if(!FreeLibrary(hGeodataDll))
    {
        std::cout << "Ошибка выгрузки geodata_x86_64.dll из памяти" << std::endl;
        return (int)GetLastError();
    }
    return 0;
}
