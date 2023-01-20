#ifndef TP1_DLL_IGEOLISTINTERFACE_H
#define TP1_DLL_IGEOLISTINTERFACE_H

#include <cstddef>
#include "IGeoInterface.h"

namespace geo {
    class IGeoListInterface : public geo::IGeoInterface {
    public:
        /** Count
         * кол-во дочерних элементов
         */
        virtual int Count() = 0;

        /** Load
         * загрузить значения списка
         */
        virtual HRESULT Load() = 0;

        /** ItemGroup - группа элемента списка */
        virtual std::byte ItemGroup(int ind) = 0;

        /** ItemID - идентификатор элемента списка */
        virtual GUID ItemID(int ind) = 0;

        /** ItemByID - элемент списка по идентификатору */
        virtual geo::IGeoInterface ItemByID(GUID AID) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOLISTINTERFACE_H
