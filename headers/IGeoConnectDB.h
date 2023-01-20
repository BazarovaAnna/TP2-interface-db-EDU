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
        virtual HRESULT ConnectDB(std::byte AConnector,
                                  std::string UserName,
                                  std::string UserPassword,
                                  std::string ServerName,
                                  std::string BaseName,
                                  std::string *AError) = 0;

        /** GetVersionDB
         *  Получить версию БД
         */
        virtual HRESULT GetVersionDB(int *AVersion, std::string *AType) = 0;

        virtual void Disconnect() = 0;

        /** GetProjects
         * Спиок проектов в БД
         */
        //function GetProjects(out AProjects: IGeoProjects): HResult; stdcall;
        virtual HRESULT GetProjects(geo::IGeoProjects *AProjects) = 0;

        /** GetProjectByID
         * Получить проект
         */
        virtual HRESULT GetProjectByID(GUID AID, geo::IGeoProject *AProject) = 0;

        /** NewProject
         * Создать проект
         */
        virtual HRESULT NewProject(std::string AName, geo::IGeoProject *AProject) = 0;

        /** GetTableByID
         * получить таблицу
         * @param AID - id БД
         * @returns ATable
         */
        virtual HRESULT GetTableByID(GUID AID, geo::IGeoTable *ATable) = 0;

    };

} // geo

#endif //TP1_DLL_IGEOCONNECTDB_H
