//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOPROJECT_H
#define TP1_DLL_IGEOPROJECT_H

#include <windows.h>
#include "IGeoTables.h"
#include "IGeoColumns.h"
#include "IGeoComponents.h"

namespace geo {
    class IGeoProject : public geo::IGeoTables {
    public:
        /** GetComponents
         * получить список компонентов проекта
         * @returns Acomps
         */
        virtual HRESULT GetComponents(geo::IGeoComponents *Acomps) = 0;

        /** GetColums
         * получить список колонок проекта
         * @returns AColumns
         */
        virtual HRESULT GetColums(geo::IGeoColumns *AColumns) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOPROJECT_H
