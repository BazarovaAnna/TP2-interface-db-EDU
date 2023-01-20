//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOTABLE_H
#define TP1_DLL_IGEOTABLE_H

#include "IGeoColumns.h"
#include "IGeoTables.h"

namespace geo {
    class IGeoTable : public geo::IGeoColumns {
    public:
        /** DBName - название таблицы БД*/
        virtual std::string DBName() = 0;

        /** PrimaryKey
         * индекс колонки, которая является первичным ключом
         */
        virtual int PrimaryKey() = 0;

        /** ForeignKey
         * индекс колонки, которая является внешним ключом
         * @returns -1 — если внешней связи по ключам нет
         */
        virtual int ForeignKey() = 0;

        /*
            Примечание **********************

            DBRowCount   — выполняется SQL запрос к БД.
                    Опирация «тяжелая» по времени, но дает представление сколько
            строк данных. Вернёт только цифру (кол-во строк БД).
            Желательно выполнять перед загрузкой данных из БД.

                    RowCount     — выполняется в памяти по загруженным данным.

                    RowCount = DBRowCount если выбирать все данные из БД.
                    RowCount < DBRowCount если был наложен фильтр при выборке.
                    RowCount = 0          если данные не были загруженны, или действительно
            нет записей в таблице.
        */

        /** RowCount - кол-во загруженных строк */
        virtual int RowCount() = 0;

        /** DBRowCount - кол-во строк БД (без загрузки самих данных) */
        virtual int DBRowCount() = 0;

        /** DBSelect - загрузить данные из БД */
        virtual HRESULT DBSelect() = 0;

        /** GetChildTables
         * список дочерних таблиц
         * @returns S_OK — таблицы существуют (их больше нуля)
         */
        virtual HRESULT GetChildTables(geo::IGeoTables *ATables) = 0;
        /*
            примечание 1
            «Таблица» это список всех колонок,
            GetUserColumn — фильтр колонки созданные пользователем (если такие имеются)
            и компонентов в частности

            примечание 2
                       - IGeoTable (Таблица) это список колонок (IGeoColumn), является
            объектом с дополнительными полями и методами.
                                                - некоторые методы вернут IGeoColumns (список колонок(IGeoColumn)) — не является таблицей.
                    Является простым списком колонок
        */
        /**
         * получить список пользовательских колонок
         * @returns S_OK — есть хотябы одна пользовательская колонка
         */
        virtual HRESULT GetUserColumns(geo::IGeoColumns AColumns) = 0;

        /**
         * фильтр текущей таблицы по PrimaryKey родительской
         * @returns S_OK — фильтр сформирован (даже если нет результата)
         * @returns S_FALSE — не выполнено, (или нет родителя) (или нет связки
         * ключей)
         */
        virtual HRESULT FilterByForeignKey() = 0;

    };

} // geo

#endif //TP1_DLL_IGEOTABLE_H
