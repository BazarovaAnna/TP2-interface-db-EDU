#ifndef TP1_DLL_IGEOINTERFACE_H
#define TP1_DLL_IGEOINTERFACE_H

#include <string>
#include <windows.h>

namespace geo {
    class IGeoInterface {
    public:
        /* Примечание
         * методы ID и ColID — разные
         * ID — уникальный идетификатор БД объекта (проект, таблица, колонка)
         * — есть у всех объектов которые сохраняются в БД
         *
         * ColID — значение колонки ID, уникальный идентификатор строки таблицы БД
         * — есть у типизированых таблиц
         *
         * ID     — вызывать у проекта, таблицы, колонки (TGeoID)
         * ColID  — вызывать у строки (Integer)
        */

        /** ID
         * идентификатор/номер БД
         * @returns -1 — нет привязки к БД
         */
        virtual GUID ID() = 0;

        /** Name
         * название списка/объекта
         */
        virtual std::string Name() = 0;

        /** Group
         * группа (тип)
         * задаётся константами в коде
         */
        virtual std::byte Group() = 0;

        /** ProjectID идентификатор проекта */
        virtual GUID ProjectID() = 0;

        /**
         * родитель
         * @returns AOwner
         */
        virtual HRESULT Owner() = 0; //не вызывается?

    };

} // geo

#endif //TP1_DLL_IGEOINTERFACE_H
