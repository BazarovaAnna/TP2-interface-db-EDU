//
// Created by AnnaB on 01/19/23.
//

#ifndef TP1_DLL_IGEOCOLUMN_H
#define TP1_DLL_IGEOCOLUMN_H

#include "IGeoInterface.h"
#include <array>

namespace geo {
    class IGeoColumn: public geo::IGeoInterface{
    public:
        /*
            Примечание

            Интерфейсы колонки специально разведены на два:
            IGeoColumn        — чтение метаданных колонки
            IGeoColumnEditor  — изменение метаданных колонки
            Ограничение на их использование нет. в большенстве случаев
            нужно читать информацию о колонке.
                    Методы изменения вынесены в отдельный интерфейс.
        */

        /** DBName - название колонки в БД */
        virtual std::string DBName() = 0;

        /** Count
         * кол-во элементов массива (если данные загруженны)
         */
        virtual int Count() = 0;

        /** GetPArray
         * указатель на массив данных
         */
        //virtual std::array::pointer GetPArray() = 0; // TODO - указатель на массив данных

        /** TypeArray
         * тип данных (строка/число/флаг/дата)
         * задаётся константами в коде
         */
        //virtual geo::TGeoTypeData TypeArray() = 0;

        /// <summary>
        ///   колонку создал пользователь
        /// </summary>
        /// <returns>
        ///   TRUE — пользовательская
        ///   FALSE — системная
        /// </returns>
        function IsUserColumn: boolean; stdcall;

        /// <summary>
        ///   является ли компонентом (флаг)
        /// </summary>
        /// <returns>
        ///   TRUE — является компонентом
        /// </returns>
        function IsComponent: boolean; stdcall;
        /// <summary>
        ///   значение по умолчанию
        /// </summary>
        function GetColDefault: WideString; stdcall;
        /// <summary>
        ///   данные типа колонки[]
        /// </summary>
        function GetColData: WideString; stdcall;
        /// <param name="AMin">
        ///   минимальное
        /// </param>
        /// <param name="AMax">
        ///   максимальное
        /// </param>
        procedure GetColMinMax(out AMin, AMax: double); stdcall;
        /// <summary>
        ///   единица измерения
        /// </summary>
        function GetColMeasure: TGeoTypeMeasure; stdcall;
        end;

    };

} // geo

#endif //TP1_DLL_IGEOCOLUMN_H
