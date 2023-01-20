//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOPROJECT_H
#define TP1_DLL_IGEOPROJECT_H

#include <windows.h>
#include "IGeoTables.h"

namespace geo {
    class IGeoProject : public geo::IGeoTables {
    public:
        /** GetComponents
         * получить список компонентов проекта
         * @returns Acomps
         */ /* не берем */
        //function GetComponents(out Acomps: IGeoComponents): HResult; stdcall;
        // virtual HRESULT GetComponents(geo::IGeoComponents *Acomps) = 0; //TODO - out

        /** GetColums
         * получить список колонок проекта
         * @returns AColumns
         */ /* не берем */
        //function GetColums(out AColumns: IGeoColumns): HResult; stdcall;
        // virtual HRESULT GetColums(geo::IGeoColumns *AColumns) = 0; // TODO - out
    };

} // geo

#endif //TP1_DLL_IGEOPROJECT_H
