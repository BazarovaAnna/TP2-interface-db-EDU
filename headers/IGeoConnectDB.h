#ifndef TP1_DLL_IGEOCONNECTDB_H
#define TP1_DLL_IGEOCONNECTDB_H

#include <string>
#include <windows.h>
#include "IGeoProjects.h"
#include "IGeoProject.h"
#include "IGeoTable.h"

namespace geo {
    class IGeoConnectDB {
    public:
        /** ConnectDB
         * Установить соединение с БД
         * @param AConnector - тип БД подключения
         * @param UserName - пользователь
         * @param UserPassword - пароль
         * @param ServerName - адрес
         * @param BaseName - название базы
         * @returns AError - строка ошибки
         */
        /*function ConnectDB(const AConnector: byte;
        const UserName, UserPassword, ServerName, BaseName: WideString;
        out AError: WideString): HResult; stdcall;*/
        virtual HRESULT ConnectDB(std::byte AConnector,
                                  std::string UserName,
                                  std::string UserPassword,
                                  std::string ServerName,
                                  std::string BaseName,
                                  std::string &) = 0;

        /** GetVersionDB
         *  Получить версию БД
         */
        /*function GetVersionDB(out AVersion: integer;
        out AType: WideString): HRESULT; stdcall;*/
        virtual HRESULT GetVersionDB(int&, std::string &) = 0;

        virtual void Disconnect() = 0;

        /** GetProjects
         * Спиок проектов в БД
         */
        //function GetProjects(out AProjects: IGeoProjects): HResult; stdcall;
        virtual HRESULT GetProjects(geo::IGeoProjects*&) = 0;

        /** GetProjectByID
         * Получить проект
         */
        /*function GetProjectByID(const AID: TGeoID;
        out AProject: IGeoProject): HResult; stdcall;*/
        virtual HRESULT GetProjectByID(GUID AID, geo::IGeoProject*&) = 0;

        /** NewProject
         * Создать проект
         */
        /*function NewProject(const AName: WideString;
        out AProject: IGeoProject): HResult; stdcall;*/
        virtual HRESULT NewProject(std::string AName, geo::IGeoProject*&) = 0;

        /** GetTableByID
         * получить таблицу
         * @param AID - id БД
         * @returns ATable
         */ /* не берем?? */
        //function GetTableByID(const AID: TGeoID; out ATable: IGeoTable): HResult; stdcall;
        virtual HRESULT GetTableByID(GUID AID, geo::IGeoTable*&) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOCONNECTDB_H
