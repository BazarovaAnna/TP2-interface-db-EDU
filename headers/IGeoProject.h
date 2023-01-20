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
        // virtual HRESULT GetComponents(geo::IGeoComponents*&) = 0;

        /** GetColums
         * получить список колонок проекта
         * @returns AColumns
         */ /* не берем */
        //function GetColums(out AColumns: IGeoColumns): HResult; stdcall;
        // virtual HRESULT GetColums(geo::IGeoColumns*&) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOPROJECT_H
