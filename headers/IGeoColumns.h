//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOCOLUMNS_H
#define TP1_DLL_IGEOCOLUMNS_H

#include "IGeoListInterface.h"
#include "IGeoColumn.h"

namespace geo {
    class IGeoColumns : public geo::IGeoListInterface {
    public:
        /** Column
         * колонка
         * @param ind - индекс
         */
        virtual geo::IGeoColumn Column(int ind) = 0;

        /**
         * колонка по названию столбца БД
         * @param AColName — название колонки БД
         * @returns HResult  — S_OK есть колонка с таким названием
         */
        virtual HRESULT ColumnByDBName(std::string AColName, geo::IGeoColumn *AColumn) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOCOLUMNS_H
