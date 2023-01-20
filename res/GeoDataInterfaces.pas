{

 Mineframe System
 Geo System

 Интерфейсы геологических данных, таблиц GeoData.DLL

 Create date: 23.09.2022
 Developer:  Yakubovich RV

 Важно!--------------------------
 В текущем файле, есть две ветки наследования интерфейсов.
 Ветка чтения: простое понятное прямое наследование интерфейсов.

 Ветка записи/изменения: интерфейсы заканчиваются на «*Editor»
 Специально вынесеное и разделено, чтобы избежать сучайного изменения данных
 структцры проекта/таблиц/колонок. Для изменения и сохранения, нужно
 постараться вызвать правильный метод в иерархии наследования.
 ---------------------------------

}
unit GeoDataInterfaces;

interface

const


  NameGeoDataDll = 'geodata_x86_64.dll';


  // БазаДанных FireBird 2.1
  GeoConnectorFB21 = $1;

  // !!!
  // БазаДаннах PostgreSQL
  // Не использовать (временно)
  // !!!
  GeoConnectorPG = $2;

  // версия интерфейса
  VERSION_GeoConnectDB: integer = 20230113;

  // версия схемы базы данных
  VERSION_GeoSchemaDB: word = 40;

  // тип подключённой БД
  VERSION_GeoTypeDB = 'tech';

  /// <summary>
  ///   Индентификатор соедиения с БД
  /// </summary>
  OBJID_GeoConnectDB: TGuid = '{9F62C480-6D59-4AE9-8086-6B858B9452B1}';


{*****************************
  константы групп
}
  /// <summary>
  ///   список проектов
  /// </summary>
  cnstGeoProjects = 1;
  /// <summary>
  ///   проект
  /// </summary>
  cnstGeoProject = 2;
  /// <summary>
  ///   список таблиц
  /// </summary>
  cnstGeoTables = 10;
  /// <summary>
  ///   таблица
  /// </summary>
  cnstGeoTable = 11;
  /// <summary>
  ///   таблица скважин
  /// </summary>
  cnstGeoTableBorehole = 20;
  /// <summary>
  ///   инклиметроии скважин
  /// </summary>
  cnstGeoTableBoreholeInclin = 21;
  /// <summary>
  ///   пробы скважины
  /// </summary>
  cnstGeoTableBoreholeSample = 22;

  /// <summary>
  ///   таблица выработок
  /// </summary>
  cnstGeoTableWorking = 30;
  /// <summary>
  ///   пробы выработки
  /// </summary>
  cnstGeoTableWorkingSample = 31;

  /// <summary>
  ///   таблица траншей
  /// </summary>
  cnstGeoTableTrench = 40;
  /// <summary>
  ///   пикеты траншеи
  /// </summary>
  cnstGeoTableTrenchPicet = 41;

  /// <summary>
  ///   список колонок
  /// </summary>
  cnstGeoColumns = 100;
  /// <summary>
  ///   колонка
  /// </summary>
  cnstGeoColumn = 101;
  /// <summary>
  //  идентификатор PK
  /// </summary>
  cnstGeoColID = 102;
  /// <summary>
  //  идентификатор FK
  /// </summary>
  cnstGeoColPID = 103;
  /// <summary>
  ///   значение
  /// </summary>
  cnstGeoColValue = 110;
  /// <summary>
  ///   списковая характеристика
  /// </summary>
  cnstGeoColListCharacter = 120;
  /// <summary>
  ///   Кондиция
  /// </summary>
  cnstGeoColCondition = 130;
  /// <summary>
  ///   формула
  /// </summary>
  cnstGeoColFormula = 140;

type

  ///   тип данных колонки
  TGeoTypeData = (
    gtdInteger = 0,
    gtdDouble = 1,
    gtdBool = 2,
    gtdString = 3,
    gtdDatetime = 4
    );

  // массивы размером «ноль»
  // нужны дла передачи указателя на перный элемент массива
  TGeoNullInteger = array [0..0] of integer;
  TGeoNullDouble = array [0..0] of double;
  TGeoNullBoolean = array [0..0] of boolean;
  TGeoNullWidestring = array [0..0] of WideString;
  TGeoNullDatetime = array [0..0] of TDateTime;

  // типизированные указатели
  PGeoArrayInteger = ^TGeoNullInteger;
  PGeoArrayDouble = ^TGeoNullDouble;
  PGeoArrayBoolean = ^TGeoNullBoolean;
  PGeoArrayWidestring = ^TGeoNullWidestring;
  PGeoArrayDatetime = ^TGeoNullDatetime;

  // еденицы измерения
  TGeoTypeMeasure = (
    gtmNone = 0,
    gtmProcent = 1,
    gtmGramm = 2
    );

  // тип уникального идентификатора
  TGeoID = TGUID;

  // интерфейсы общего назначения
  IGeoInterface = interface;
  IGeoListInterface = interface;
  IGeoListEditor = interface;
  IGeoObjectTable = interface;

  // интерфейсы структуры/связи
  IGeoProjects = interface;
  IGeoProject = interface;
  IGeoProjectEditor = interface;
  IGeoTables = interface;
  IGeoTable = interface;
  IGeoTableEditor = interface;
  IGeoColumns = interface;
  IGeoComponents = interface;
  IGeoColumn = interface;
  IGeoColumnEditor = interface;

  // интерфейсы типизированных данных
  // наследники от IGeoObjectTable
  IBorehole = interface;
  IBoreholeInclin = interface;
  IBoreholeSample = interface;

  IWorking = interface;
  IWorkingSample = interface;

  ITrench = interface;
  ITrenchPicet = interface;


  {***************************************************}


  /// <summary>
  ///   Интерфейс соединения с БД
  /// </summary>
  IGeoConnectDB = interface(IInterface)
    ['{1245DEE9-22FA-4040-BF25-4F52B4BB348F}']
    /// <summary>
    ///   установить соединени с БД
    /// </summary>     
    /// <param name="AConnector">
    ///   тип БД подключения
    /// </param>
    /// <param name="UserName">
    ///   пользователь
    /// </param>
    /// <param name="UserPassword">
    ///   пароль
    /// </param>
    /// <param name="ServerName">
    ///   адрес
    /// </param>
    /// <param name="BaseName">
    ///   название базы
    /// </param>
    /// <param name="AError">
    ///   строка ошибки
    /// </param>
    function ConnectDB(const AConnector: byte;
      const UserName, UserPassword, ServerName, BaseName: WideString;
      out AError: WideString): HResult; stdcall;
    function GetVersionDB(out AVersion: integer;
      out AType: WideString): HRESULT; stdcall;
    procedure Disconnect;
    /// <summary>
    ///   Спиок проектов в БД
    /// </summary>
    function GetProjects(out AProjects: IGeoProjects): HResult; stdcall;
    /// <summary>
    ///   получить проект
    /// </summary>
    /// <param name="ID">
    ///   id БД
    /// </param>
    /// <returns>
    ///   S_OK — такой проект есть
    /// </returns>
    function GetProjectByID(const AID: TGeoID;
      out AProject: IGeoProject): HResult; stdcall;
    /// <summary>
    ///   Создать проект
    /// </summary>
    /// <param name="AName">
    ///   название
    /// </param>
    /// <param name="AProject">
    ///   созданный проект
    /// </param>
    /// <returns>
    ///   S_OK — проект создан
    /// </returns>
    function NewProject(const AName: WideString;
      out AProject: IGeoProject): HResult; stdcall;

    /// <summary>
    ///   получить таблицу
    /// </summary>
    /// <param name="ID">
    ///   id БД
    /// </param>
    /// <returns>
    ///   S_OK — таблица существует
    /// </returns>
    function GetTableByID(const AID: TGeoID; out ATable: IGeoTable): HResult; stdcall;

  end;

{**************************************************
  интерфейсы общего назначения
  для формирования частных интерфейсов
}
  /// <summary>
  ///   минимальный геологический интерфейс
  /// </summary>
  IGeoInterface = interface(IInterface)
    ['{7F3E25CB-05B8-45E9-9488-B79CA826301B}']
{
  Примечание
  методы ID и ColID — разные
  ID — уникальный идетификатор БД объекта (проект, таблица, колонка)
     — есть у всех объектов которые сохраняются в БД

  ColID — значение колонки ID, уникальный идентификатор строки таблицы БД
        — есть у типизированых таблиц

  ID     — вызывать у проекта, таблицы, колонки (TGeoID)
  ColID  — вызывать у строки (Integer)
}
    /// <summary>
    ///   идентификатор/номер БД
    /// </summary>
    /// <returns>
    ///   -1 — нет привязки к БД
    /// </returns>
    function ID: TGeoID; stdcall;
    /// <summary>
    ///   название списка/объекта
    /// </summary>
    function Name: WideString; stdcall;
    /// <summary>
    ///   группа (тип)
    /// </summary>
    /// <remarks>
    ///   задаётся константами в коде
    /// </remarks>
    function Group: byte; stdcall;
    // идентификатор проекта
    function ProjectID: TGeoID; stdcall;
    /// <summary>
    ///   родитель
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — родитель есть
    ///   </para>
    ///   <para>
    ///     S_FALSE — ошибка (или корневой IGeoProjects)
    ///   </para>
    /// </returns>
    function Owner(out AOwner: IGeoInterface): HResult; stdcall;
  end;

  /// <summary>
  ///   списковый промежуточный интерфейс,
  ///   Не использовать на прямую (желательно)
  /// </summary>
  IGeoListInterface = interface(IGeoInterface)
    ['{78F7F6B8-12E3-4EF3-84F7-27BF31D28011}']
    /// <summary>
    ///   кол-во дочерних элементов
    /// </summary>
    function Count: integer; stdcall;
    /// <summary>
    ///   загрузить значения списка
    /// </summary>
    function Load: HRESULT; stdcall;
    // группа элемента списка
    function ItemGroup(const ind: integer): byte; stdcall;
    // идентификатор элемента спсика
    function ItemID(const ind: integer): TGeoID; stdcall;
    // элемент списка по идентификатору
    function ItemByID(const AID: TGeoID): IGeoInterface; stdcall;
  end;

  IGeoListEditor = interface(IGeoListInterface)
    ['{3148FB6A-6650-4451-88BF-6F4125504733}']
    /// <summary>
    ///   удалить объект списка по индексу
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function Delete(const ind: integer): HResult; stdcall;

    /// <summary>
    ///   удалить объект списка по ID БД
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function DeleteByID(const AID: TGeoID): HResult; stdcall;
  end;

{**********************************************
  интерфесы структуры данных, таблиц, колонок
}

  /// <summary>
  ///   Список проектов (IGeoProject)
  /// </summary>
  IGeoProjects = interface(IGeoListInterface)
    ['{D46A44BA-A32F-4449-A5ED-9054BE6A4F1C}']
    /// <summary>
    ///   Проект (по номеру в списке)
    /// </summary>
    function Project(const ind: integer): IGeoProject; stdcall;
  end;

  /// <summary>
  ///   список таблиц (IGeoTable)
  /// </summary>
  IGeoTables = interface(IGeoListInterface)
    ['{AC3B7A4D-4553-4A6A-A15D-02B0F79F5597}']
    /// <summary>
    ///   таблица
    /// </summary>
    /// <param name="ind">
    ///   порядковый индекс
    /// </param>
    function Table(const ind: integer): IGeoTable; stdcall;
  end;

  IGeoTablesEditor = interface(IGeoTables)
    ['{DEF0BBF1-F361-4C5A-ABF8-70744C923FBC}']
    /// <summary>
    ///   удалить объект списка по ID БД
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function DeleteByID(const AID: TGeoID): HResult; stdcall;
    /// <summary>
    ///   удалить объект списка по индексу
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function Delete(const ind: integer): HResult; stdcall;
  end;

  /// <summary>
  ///   проект (список таблиц IGeoTable)
  /// </summary>
  IGeoProject = interface(IGeoTables)
    ['{2E3AC16D-E141-4BF5-9578-B751978F63A0}']
    /// <summary>
    ///   получить список компонентов проекта
    /// </summary>
    function GetComponents(out Acomps: IGeoComponents): HResult; stdcall;
    /// <summary>
    ///   получить список колонок проекта
    /// </summary>
    function GetColums(out AColumns: IGeoColumns): HResult; stdcall;
  end;

  IGeoProjectEditor = interface(IGeoProject)
    ['{810F7B3B-1FC9-4259-AA2A-62086EDD26D4}']
    procedure SetName(const AName: WideString); stdcall;
    function WriteDB(out msg: WideString): HResult; stdcall;
    /// <summary>
    ///   новая таблица
    /// </summary>
    /// <param name="AName">
    ///   название таблицы
    /// </param>
    /// <param name="AGroup">
    ///   тип таблицы
    /// </param>
    function New(const AName: WideString; const AGroup: byte;
      out t: IGeoTableEditor): HResult; stdcall;
    /// <summary>
    ///   новая колонка (или компонент) проекта
    /// </summary>
    /// <param name="AName">
    ///   название колонки (компонента)
    /// </param>
    function NewColumn(const AName, AColName: WideString;
      const ATypeData: TGeoTypeData; const ATypeColumn: byte;
      out c: IGeoColumnEditor): HResult; stdcall;
    /// <summary>
    ///   удалить объект списка по ID БД
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function DeleteByID(const AID: TGeoID): HResult; stdcall;
  end;

  /// <summary>
  ///   Список колонок (IGeoColumn)
  /// </summary>
  IGeoColumns = interface(IGeoListInterface)
    ['{8980C0AE-7CA9-4BF3-B770-FE964A9AB1B9}']
    /// <summary>
    ///   колонка
    /// </summary>
    /// <param name="">
    ///   индекс
    /// </param>
    function Column(const ind: integer): IGeoColumn; stdcall;

    // колонка по названию столбца БД
    // AColName — название колонки БД
    // HResult  — S_OK есть колонка с таким названием
    function ColumnByDBName(const AColName: WideString;
      out AColumn: IGeoColumn): HResult; stdcall;
  end;

  /// <summary>
  ///   таблица (список колонок IGeoColumn)
  /// </summary>
  ///
  IGeoTable = interface(IGeoColumns)
    ['{2A4B1D48-7D2B-47A4-91FD-0C74685E511F}']
    // название таблицы БД
    function DBName: WideString; stdcall;
    /// <summary>
    ///   индекс колонки, которая является первичным ключем
    /// </summary>
    function PrimaryKey: integer; stdcall;
    /// <summary>
    ///   индекс колонки, которая является внешним лючем
    /// </summary>
    /// <returns>
    ///   -1 — если внешней связи по ключам нет
    /// </returns>
    function ForeignKey: integer; stdcall;

{
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
}
    //  кол-во загруженных строк
    function RowCount: integer; stdcall;

    ///   кол-во строк БД (без загрузки самих данных)
    function DBRowCount: integer; stdcall;

    // загрузить данные из БД
    function DBSelect: Hresult; stdcall;

    /// <summary>
    ///   список дочерних таблиц
    /// </summary>
    /// <returns>
    ///   S_OK — таблицы существуют (их больше нуля)
    /// </returns>
    function GetChildTables(out ATables: IGeoTables): HResult; stdcall;
{
  примечание 1
  «Таблица» это список всех колонок,
  GetUserColumn — фильтр колонки созданные пользователем (если такие имеются)
                  и компонентов в частности

  примечание 2
  - IGeoTable (Таблица) это список колонок (IGeoColumn), является
    объектом с дополнительными полями и методами.
  - некоторые методы вернут IGeoColumns (список колонок(IGeoColumn)) — не является таблицей.
    Является простым списком колонок
}
    /// <summary>
    ///   получить список компонентов таблицы
    /// </summary>
    /// <returns>
    ///   S_OK - есть хотябы один компонент
    /// </returns>

    /// <summary>
    ///   получить список пользовательских колонок
    /// </summary>
    /// <returns>
    ///   S_OK — есть хотябы одна пользовательская колонка
    /// </returns>
    function GetUserColumns(out AColumns: IGeoColumns): HResult; stdcall;
    /// <summary>
    ///   фильтр текущей таблицы по PrimaryKey родительской
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — фильтр сформирован (даже если нет результата)
    ///   </para>
    ///   <para>
    ///     S_FALSE — не выполнено, (или нет родителя) (или нет связки
    ///     ключей)
    ///   </para>
    /// </returns>
    function FilterByForeignKey: HResult; stdcall;
  end;

  /// <summary>
  ///  изменение таблицы
  /// </summary>
  IGeoTableEditor = interface(IGeoTable)
    ['{41817825-A6DA-4CFA-9B71-FDAD3CB5C316}']
    procedure SetName(const AName: WideString); stdcall;
    function WriteDB(out msg: WideString): HResult; stdcall;
    /// <summary>
    ///   создать колонку в БД
    /// </summary>
    function New(const AName, AColName: WideString; const ATypeData: TGeoTypeData;
      const ATypeColumn: byte; out c: IGeoColumnEditor): HResult; stdcall;
    /// <summary>
    ///   создать дочернюю таблицу
    /// </summary>
    /// <param name="AName">
    ///   название таблицы
    /// </param>
    /// <param name="AType">
    ///   тип таблицы
    /// </param>
    /// <returns>
    ///   S_OK — таблица создана
    /// </returns>
    function NewChildTable(const AName: WideString; const AGroup: byte;
      out t: IGeoTableEditor): HResult; stdcall;
    /// <summary>
    ///   удалить объект списка по ID БД
    /// </summary>
    /// <returns>
    ///   S_OK — удалён
    /// </returns>
    function DeleteByID(const AID: TGeoID): HResult; stdcall;
  end;


  /// <summary>
  ///   Колонка таблицы
  /// </summary>
  IGeoColumn = interface(IGeoInterface)
{
    Применчание

    Интерфейсы колонки специально разведены на два:
      IGeoColumn        — чтение метаданных колонки
      IGeoColumnEditor  — изменение метаданных колонки
    Ограничение на их использование нет. в большенстве случаев
    нужно читать информацию о колонке.
    Методы изменения вынесены в отдельный интерфейс.
}
    ['{E1E0578B-C280-472C-8461-2A15A7E4CAB2}']
    // название колонки в БД
    function DBName: WideString; stdcall;

    /// <summary>
    ///   кол-во элементов массива (если данные загруженны)
    /// </summary>
    function Count: integer; stdcall;
    /// <summary>
    ///   указатель на массив данных
    /// </summary>
    function GetPArray: Pointer; stdcall;
    /// <summary>
    ///   тип данных (строка/число/флаг/дата)
    /// </summary>
    /// <remarks>
    ///   задаётся константами в коде
    /// </remarks>
    function TypeArray: TGeoTypeData; stdcall;

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

  /// <summary>
  ///   Изменение метаданных колонки
  /// </summary>
  IGeoColumnEditor = interface(IGeoColumn)
    ['{1D60666E-C240-432E-8A21-4073867F2DE0}']
    procedure SetName(const AName: WideString); stdcall;
    function WriteDB(out msg: WideString): HResult; stdcall;
    procedure SetIsComponent(c: boolean); stdcall;
    procedure SetDefault(AValue: WideString); stdcall;
    procedure SetData(AData: WideString); stdcall;
    procedure SetMinMax(AMin, AMax: double); stdcall;
    procedure SetMeasure(AMeasure: TGeoTypeMeasure); stdcall;
  end;

  /// <summary>
  ///   Список компонентов (IGeoColumn)
  /// </summary>
  IGeoComponents = interface(IGeoListInterface)
    ['{66C81717-AEA3-4187-B5F8-757EECDD1989}']
    /// <summary>
    ///   компонент
    /// </summary>
    /// <param name="ind">
    ///   индекс
    /// </param>
    function Component(const ind: integer): IGeoColumn; stdcall;
  end;

{***********************************************
    Типизированные таблицы
***********************************************}

{
  примечание по работе с типизированными таблицами.
  Это таблицы (IGeoTable) с изместными столбцами, для каждого столбца
  типизированной таблицы свой метод (Col*).

  Для перебора всех «строк» таблицы необходимо:
  - IGeoObjectTable.RowCount - количество строк
  - IGeoObjectTable.ItemIndex — текущая строка
  - методы получения данных столбцов (ColID, ColNum и тд) будут выдавать
    значение по ItemIndex
  Этот способ простой, т.к. некоторые колонки известны заранее

  Так же возможен и другой вариант — перебор всех колонок через базовые методы:
  - IGeoTable.Count - кол-во колонок
  - IGeoTable.Column(ind) - колонка по индексу
  - IGeoColumn.GetPArray - данные колонки
  Этот способ универсальный
}

  /// <summary>
  ///   общий интерфейс типизированой таблицы
  /// </summary>
  IGeoObjectTable = interface(IGeoTable)
    ['{111BCE68-5A5D-4C34-9706-450D01284FBD}']
    /// <summary>
    ///   индекс текущий строки
    /// </summary>
    function ItemIndex: integer; stdcall;
    /// <summary>
    ///   установить индекс строки
    /// </summary>
    procedure SetItemIndex(const AInd: integer); stdcall;

    /// <summary>
    ///   ID базы данных
    /// </summary>
    /// <remarks>
    ///   PrimaryKey (обычно)
    /// </remarks>
    function ColID: integer; stdcall;
  end;

  /// <summary>
  ///   скважины
  /// </summary>
  IBorehole = interface(IGeoObjectTable)
    ['{BC14A001-D7CD-410C-A3C5-307103CE56DB}']
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   координаты
    /// </summary>
    procedure ColXYZ(out x, y, z: double); stdcall;
    /// <summary>
    ///   первая таблица инклинометрии
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — есть первая таблица
    ///   </para>
    ///   <para>
    ///     S_FALSE — дочерних таблиц нет
    ///   </para>
    /// </returns>
    function GetFirstInclin(out ATable: IBoreholeInclin): HResult; stdcall;
    /// <summary>
    ///   первая таблица проб
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — есть первая таблица
    ///   </para>
    ///   <para>
    ///     S_FALSE — дочерних таблиц нет
    ///   </para>
    /// </returns>
    function GetFirstSample(out ATable: IBoreholeSample): HResult; stdcall;
  end;

  /// <summary>
  ///   инклинометрия скважин
  /// </summary>
  IBoreholeInclin = interface(IGeoObjectTable)
    ['{C6D3A6E4-A643-4FF9-8F1C-92C32841D06F}']
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   ID скважины
    /// </summary>
    /// <remarks>
    ///   ForeignKey (обычно)
    /// </remarks>
    function ColPID: integer; stdcall;
    /// <summary>
    ///   угол
    /// </summary>
    function ColAngel: double; stdcall;
    /// <summary>
    ///   азимут
    /// </summary>
    function ColAz: double; stdcall;
    /// <summary>
    ///   глубина
    /// </summary>
    function ColDepth: double; stdcall;
  end;

  /// <summary>
  ///   пробы скважин
  /// </summary>
  IBoreholeSample = interface(IGeoObjectTable)
    ['{D151967F-7F34-42EC-992B-B7803CB00308}']
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   ID скважины
    /// </summary>
    /// <remarks>
    ///   ForeignKey (обычно)
    /// </remarks>
    function ColPID: integer; stdcall;
    /// <summary>
    ///   начало и конец
    /// </summary>
    procedure ColBeginEnd(out ABegin, AEnd: double); stdcall;
  end;

  /// <summary>
  ///   таблица выработки
  /// </summary>
  IWorking = interface(IGeoObjectTable)
    ['{7A24148A-C932-4C32-9EDF-255FE3075DFD}']
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   первая таблица проб
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — есть первая таблица
    ///   </para>
    ///   <para>
    ///     S_FALSE — дочерних таблиц нет
    ///   </para>
    /// </returns>
    function GetFirstSample(out ATable: IWorkingSample): HResult; stdcall;
  end;

  /// <summary>
  ///   пробы выработки
  /// </summary>
  IWorkingSample = interface(IGeoObjectTable)
    ['{3B115526-3C13-4789-8858-F39CB8A9899A}']
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   ID выработки
    /// </summary>
    /// <remarks>
    ///   ForeignKey (обычно)
    /// </remarks>
    function ColPID: integer; stdcall;
    procedure ColX(out ABeginX, AEndX: double);
    procedure ColY(out ABeginY, AEndY: double);
    procedure ColZ(out ABeginZ, AEndZ: double);
  end;

  /// <summary>
  ///   траншея
  /// </summary>
  ITrench = interface(IGeoObjectTable)
    ['{1456EF75-B5DF-483E-A2CB-8547344D4E44}']
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   координаты
    /// </summary>
    procedure ColXYZ(out x, y, z: double); stdcall;
    /// <summary>
    ///   первая таблица пикетов
    /// </summary>
    /// <returns>
    ///   <para>
    ///     S_OK — есть первая таблица
    ///   </para>
    ///   <para>
    ///     S_FALSE — дочерних таблиц нет
    ///   </para>
    /// </returns>
    function GetFirstPicet(out ATable: ITrenchPicet): HResult; stdcall;
  end;

  /// <summary>
  ///   Пикеты траншеи
  /// </summary>
  ITrenchPicet = interface(IGeoObjectTable)
    ['{C7EF5624-8439-4A4B-BC05-B3A1A272D481}']
    /// <summary>
    ///   название
    /// </summary>
    function ColName: WideString; stdcall;
    /// <summary>
    ///   номер
    /// </summary>
    function ColNum: WideString; stdcall;
    /// <summary>
    ///   ID траншеи
    /// </summary>
    /// <remarks>
    ///   ForeignKey (обычно)
    /// </remarks>
    function ColPID: integer; stdcall;
    /// <summary>
    ///   координаты
    /// </summary>
    procedure ColXYZ(out x, y, z: double); stdcall;
  end;

implementation

end.
