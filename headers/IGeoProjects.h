#ifndef TP1_DLL_IGEOPROJECTS_H
#define TP1_DLL_IGEOPROJECTS_H

#include "IGeoProject.h"
#include "IGeoListInterface.h"

namespace geo {
    class IGeoProjects : public geo::IGeoListInterface {
    public:
        /** Project
         * Проект (по номеру в списке)
         */
        virtual geo::IGeoProject Project(int ind) = 0;
    };

} // geo

#endif //TP1_DLL_IGEOPROJECTS_H
