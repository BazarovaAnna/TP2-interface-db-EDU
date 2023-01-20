//
// Created by AnnaB on 01/20/23.
//

#ifndef TP1_DLL_IGEOTABLES_H
#define TP1_DLL_IGEOTABLES_H

#include "IGeoListInterface.h"
#include "IGeoTable.h"

namespace geo {

    class IGeoTables : public geo::IGeoListInterface {
    public:
        /** Table
         * таблица
         * @param ind - порядковый индекс
         */
        virtual geo::IGeoTable Table(int ind) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOTABLES_H
