//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOCOMPONENTS_H
#define TP1_DLL_IGEOCOMPONENTS_H

#include "IGeoListInterface.h"
#include "IGeoColumn.h"

namespace geo {
    class IGeoComponents : public geo::IGeoListInterface {
    public:
        /** Component
         * компонент
         * @param ind - индекс
         */
        virtual geo::IGeoColumn Component(int ind) = 0;

    };

} // geo

#endif //TP1_DLL_IGEOCOMPONENTS_H
