{

 Mineframe System
 Geo System

 методы GeoData.DLL

 Create date: 10.10.2022
 Developer:  Yakubovich RV

}
unit DLLImport;

{$mode ObjFPC}{$H+}

interface

uses GeoDataInterfaces;

var
  // интерфейс соединения
  gdb: IGeoConnectDB;
  gdbOk: boolean;

const

  // для соединение с сетевой БД

  dbServerName = '192.168.1.171';
  dbBaseName = 'v9_install_tech_geosystem_40';
  dbUser = 'SYSDBA';
  dbPas = 'masterkey';

function GetModuleObject(ObjectID: TGuid; InterfaceID: TGuid; out ppvObj): HRESULT;
  external NameGeoDataDll Name 'GetModuleObject';
function GeoTestConnect: integer; external NameGeoDataDll Name 'TestConnect';


implementation

var
  //r: HRESULT;
  err: widestring;

initialization
  gdbOk := False;

  if GetModuleObject(OBJID_GeoConnectDB, IGeoConnectDB, gdb) = S_OK then
    gdbOk := gdb.ConnectDB(GeoConnectorFB21, dbUser, dbPas, dbServerName,
      dbBaseName, err) = S_OK;

finalization

  gdb.Disconnect;
  gdb := nil;

end.
