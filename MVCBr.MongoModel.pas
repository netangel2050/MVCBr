unit MVCBr.MongoModel;
{ *************************************************************************** }
{ }
{ MVCBr � o resultado de esfor�os de um grupo }
{ }
{ Copyright (C) 2017 MVCBr }
{ }
{ amarildo lacerda }
{ http://www.tireideletra.com.br }
{ }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }

interface

uses
  System.classes, System.SysUtils,
  MVCBr.Interf, MVCBr.Model,
  MongoWire, MongoAuth3, JsonDoc,
  bsonDoc, bsonUtils, MVCBr.Patterns.Adapter;

type
  TMongoModelFactory = class;

  IJSONDocument = JsonDoc.IJSONDocument;
  IJSONDocArray = JsonDoc.IJSONDocArray;

  TJSONDocument = class(JsonDoc.TJSONDocument)
  public
    class Function New: IJSONDocument; overload;
    class function New(const x: array of Variant): IJSONDocument; overload;
  end;

  TJSONDocArray = Class(JsonDoc.TJSONDocArray)
  public
    class function New: IJSONDocArray;
  end;

  IMongoModel = interface(IModel)
    ['{0A93DBFF-13C6-46A7-9A5D-C59551F32CB9}']
    function This: TMongoModelFactory;
    procedure SetDatabase(const Value: string);
    procedure SetHost(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: integer);
    procedure SetUserName(const Value: string);
    function GetDatabase: string;
    function GetHost: string;
    function GetPassword: string;
    function GetPort: integer;
    function GetUserName: string;
    function Database(ADatabase: string): IMongoModel;
    function Host(AHost: String): IMongoModel;
    function Port(APort: integer): IMongoModel;
    function Password(APass: string): IMongoModel;
    function UserName(AUser: string): IMongoModel;
    function SetConnection(AConn: TMongoWire = nil): IMongoModel;
    /// mongo
    function MongoConnection: TMongoWire;
    function NewQuery: IMVCBrAdapter<TMongoWireQuery>;
  end;

  TMongoExpression = record
  public
    class function like(AField: string; AText: string; AOptions: String = 'i')
      : IJSONDocument; static;
    class function contains(AField: string; AText: string;
      AOptions: String = 'i'): IJSONDocument; static;
    class function between(AField: string; AFrom, ATo: Variant)
      : IJSONDocument; static;
    class function gt(AField: string; AValue: Variant): IJSONDocument; static;
    class function gte(AField: string; AValue: Variant): IJSONDocument; static;
    class function lt(AField: string; AValue: Variant): IJSONDocument; static;
    class function lte(AField: string; AValue: Variant): IJSONDocument; static;
    class function eq(AField: string; AValue: Variant): IJSONDocument; static;
    class function ne(AField: string; AValue: Variant): IJSONDocument; static;
    class function search(AField: string; AString: string)
      : IJSONDocument; static;

  end;

  /// <summary>
  /// MongoModel
  /// </summary>
  TMongoModelFactory = class(TModelFactory, IMongoModel)
  private
    FPort: integer;
    FDatabase: string;
    FPassword: string;
    FHost: string;
    FUserName: string;
    FConnection: TMVCBrAdapter<TMongoWire>;
    FActive: Boolean;
    function SetConnection(AConn: TMongoWire = nil): IMongoModel;
    procedure SetActive(const Value: Boolean);
    function GetActive: Boolean;
    function GetSequence(FCollection,AMongoCampo: string): Int64;
  protected
    function OpenIfNeed: TMongoWire; virtual;
    procedure SetDatabase(const Value: string); virtual;
    procedure SetHost(const Value: string); virtual;
    procedure SetPassword(const Value: string); virtual;
    procedure SetPort(const Value: integer); virtual;
    procedure SetUserName(const Value: string); virtual;
    function GetDatabase: string; virtual;
    function GetHost: string; virtual;
    function GetPassword: string; virtual;
    function GetPort: integer; virtual;
    function GetUserName: string; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function New(AController: IController; ADatabase: string = '')
      : IMongoModel; overload; virtual;
    class function New(AController: IController; AConnection: TMongoWire)
      : IMongoModel; overload; virtual;
    function This: TMongoModelFactory; virtual;
    function MongoConnection: TMongoWire;
    procedure Open;
    procedure Close;
    function NewQuery: IMVCBrAdapter<TMongoWireQuery>;
    /// Base
{$REGION "Base connections"}
    [weak]
    function Database(ADatabase: string): IMongoModel; virtual;
    [weak]
    function Host(AHost: String): IMongoModel; virtual;
    [weak]
    function Port(APort: integer): IMongoModel; virtual;
    [weak]
    function Password(APass: string): IMongoModel; virtual;
    [weak]
    function UserName(AUser: string): IMongoModel; virtual;
{$ENDREGION}
    [weak]
    property Active: Boolean read GetActive write SetActive;

    /// Operations
{$REGION "Mongo Base Operations"}
    /// <summary>
    /// Get retrieve data with AWhere conditions
    /// </summary>
    function Get(const ACollection: String; const AWhere: IJSONDocument)
      : IJSONDocument; overload;
    function Get(const ACollection: String; const AJsonWhere: string)
      : IJSONDocument; overload;
    function Query(Const ACollection: String; const AWhere: IJSONDocument)
      : IJSONDocArray; overload;
    function Query(Const ACollection: String;
      const AArrayWhere: array of IJSONDocument): IJSONDocArray; overload;

    procedure Update(const ACollection: String;
      const AWhere, ADoc: IJSONDocument; AUpsert: Boolean = false;
      AMultiUpdate: Boolean = false);

    procedure Insert(const ACollection: WideString;
      const ADoc: IJSONDocument); overload;

    procedure Insert(const ACollection: WideString;
      const ADocs: array of IJSONDocument); overload;
    procedure Insert(const ACollection: WideString;
      const ADocs: IJSONDocArray); overload;
    procedure Delete(const ACollection: WideString; const AWhere: IJSONDocument;
      ASingleRemove: Boolean = true);
    function Ping: Boolean;
    procedure EnsureIndex(const ACollection: WideString;
      const AIndex: IJSONDocument; const AOptions: IJSONDocument = nil);

    function RunCommand(const ACmdObj: IJSONDocument): IJSONDocument;

    function Count(const ACollection: WideString): integer;
    function Distinct(const ACollection, AKey: WideString;
      const AQuery: IJSONDocument = nil): Variant;

    function Eval(const ACollection, AJSFn: WideString;
      const AArgs: array of Variant; ANoLock: Boolean = false): Variant;

{$ENDREGION}
{$REGION "Samples Extends commands"}
    function QueryRegEx(ACollection, AField, AText: String): IJSONDocArray;
{$ENDREGION}
  end;

implementation

uses System.JSON, System.JSON.Helper;

{ TMongoModelFactory }

procedure TMongoModelFactory.Close;
begin
  Active := false;
end;

function TMongoModelFactory.SetConnection(AConn: TMongoWire): IMongoModel;
begin
  result := self;
  if assigned(AConn) then
    FConnection.SetInstance(AConn, false { free on caller } );
end;

function TMongoModelFactory.Count(const ACollection: WideString): integer;
begin
  result := OpenIfNeed.Count(ACollection);
end;

constructor TMongoModelFactory.Create;
begin
  inherited;
  FDatabase := 'mvcbrDB';
  FHost := 'localhost';
  FPort := 27017;
  FConnection := TMVCBrAdapter<TMongoWire>.Create(nil);
  FConnection.DelegateTo(
    function: TMongoWire
    begin
      result := TMongoWire.Create(FDatabase);
    end)
end;

function TMongoModelFactory.Database(ADatabase: string): IMongoModel;
begin
  result := self;
  SetDatabase(ADatabase);
end;

procedure TMongoModelFactory.Delete(const ACollection: WideString;
const AWhere: IJSONDocument; ASingleRemove: Boolean);
begin
  OpenIfNeed.Delete(ACollection, AWhere, ASingleRemove);
end;

destructor TMongoModelFactory.Destroy;
begin
  if assigned(FConnection) then
    FConnection.DisposeOf;
  FConnection := nil;
  inherited;
end;

function TMongoModelFactory.Distinct(const ACollection, AKey: WideString;
const AQuery: IJSONDocument): Variant;
begin
  result := OpenIfNeed.Distinct(ACollection, AKey, AQuery);
end;

procedure TMongoModelFactory.EnsureIndex(const ACollection: WideString;
const AIndex, AOptions: IJSONDocument);
begin
  OpenIfNeed.EnsureIndex(ACollection, AIndex, AOptions);
end;

function TMongoModelFactory.Eval(const ACollection, AJSFn: WideString;
const AArgs: array of Variant; ANoLock: Boolean): Variant;
begin
  result := OpenIfNeed.Eval(ACollection, AJSFn, AArgs, ANoLock);
end;

function TMongoModelFactory.Get(const ACollection: String;
const AWhere: IJSONDocument): IJSONDocument;
begin
  result := OpenIfNeed.Get(ACollection, AWhere);
end;

function TMongoModelFactory.Get(const ACollection, AJsonWhere: string)
  : IJSONDocument;
begin
  result := Get(ACollection, JSON.Parse(AJsonWhere));
end;

function TMongoModelFactory.GetActive: Boolean;
begin
  result := FActive;
end;

function TMongoModelFactory.GetDatabase: string;
begin
  result := FDatabase;
end;

function TMongoModelFactory.GetHost: string;
begin
  result := FHost;
end;

function TMongoModelFactory.GetPassword: string;
begin
  result := FPassword;
end;

function TMongoModelFactory.GetPort: integer;
begin
  result := FPort;
end;

function TMongoModelFactory.GetUserName: string;
begin
  result := FUserName;
end;

function TMongoModelFactory.Host(AHost: String): IMongoModel;
begin
  result := self;
  SetHost(AHost);
end;

procedure TMongoModelFactory.Insert(const ACollection: WideString;
const ADocs: array of IJSONDocument);
begin
  OpenIfNeed.Insert(ACollection, ADocs);
end;

procedure TMongoModelFactory.Insert(const ACollection: WideString;
const ADoc: IJSONDocument);
begin
  OpenIfNeed.Insert(ACollection, ADoc);
end;

procedure TMongoModelFactory.Insert(const ACollection: WideString;
const ADocs: IJSONDocArray);
begin
  OpenIfNeed.Insert(ACollection, ADocs);
end;

function TMongoModelFactory.MongoConnection: TMongoWire;
begin
  result := FConnection.Adapter;
end;

class function TMongoModelFactory.New(AController: IController;
AConnection: TMongoWire): IMongoModel;
begin
  result := self.New(AController, '');
  with result.This do
  begin
    FConnection.SetInstance(AConnection, true);
  end;
end;

function TMongoModelFactory.NewQuery: IMVCBrAdapter<TMongoWireQuery>;
var
  r: TMVCBrAdapter<TMongoWireQuery>;
begin
  r := TMVCBrAdapter<TMongoWireQuery>.Create(nil);
  r.DelegateTo(
    function: TMongoWireQuery
    begin
      result := TMongoWireQuery.Create(FConnection.Adapter);
    end);
  result := r;
end;

procedure TMongoModelFactory.Open;
begin
  if not FActive then
    Active := true;
end;

function TMongoModelFactory.OpenIfNeed: TMongoWire;
begin
  result := MongoConnection;
  if not Active then
    Open;
end;

class function TMongoModelFactory.New(AController: IController;
ADatabase: string): IMongoModel;
begin
  result := TMongoModelFactory.Create;
  result.Controller(AController);
  if ADatabase <> '' then
    result.SetDatabase(ADatabase);
end;

function TMongoModelFactory.Password(APass: string): IMongoModel;
begin
  result := self;
  SetPassword(APass);
end;

function TMongoModelFactory.Ping: Boolean;
begin
  result := MongoConnection.Ping;
end;

function TMongoModelFactory.Port(APort: integer): IMongoModel;
begin
  result := self;
  SetPort(APort);
end;

function TMongoModelFactory.Query(const ACollection: String;
const AWhere: IJSONDocument): IJSONDocArray;
var
  d: IJSONDocument;
  i: integer;
  q: TMongoWireQuery;
  r: TJSONDocArray;
begin
  d := JSON;
  OpenIfNeed;
  q := TMongoWireQuery.Create(MongoConnection);
  try
    r := TJSONDocArray.Create;
    with q do
    begin
      Query(ACollection, AWhere);
    end;
    while q.Next(d) do
    begin
      r.Add(d);
    end;
  finally
    q.free;
  end;
  result := r;
end;

function TMongoModelFactory.RunCommand(const ACmdObj: IJSONDocument)
  : IJSONDocument;
begin
  result := OpenIfNeed.RunCommand(ACmdObj);
end;

procedure TMongoModelFactory.SetActive(const Value: Boolean);
begin
  if not Value then
  begin
    if FActive then
      FConnection.Adapter.Close;
    FActive := false;
    exit;
  end;

  if not FActive then
  begin
    with FConnection.Adapter do
    begin
      NameSpace := FDatabase;
      if (FUserName <> '') and (FPassword <> '') then
      begin
        MongoWireAuthenticate(FConnection.Adapter, FUserName, FPassword);
      end;
    end;
  end;
  FConnection.Adapter.Open(FHost, FPort);
  FActive := Value;
end;

procedure TMongoModelFactory.SetDatabase(const Value: string);
begin
  FDatabase := Value;
end;

procedure TMongoModelFactory.SetHost(const Value: string);
begin
  FHost := Value;
end;

procedure TMongoModelFactory.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TMongoModelFactory.SetPort(const Value: integer);
begin
  FPort := Value;
end;

procedure TMongoModelFactory.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TMongoModelFactory.This: TMongoModelFactory;
begin
  result := self;
end;

procedure TMongoModelFactory.Update(const ACollection: String;
const AWhere, ADoc: IJSONDocument; AUpsert, AMultiUpdate: Boolean);
begin
  OpenIfNeed.Update(ACollection, AWhere, ADoc, AUpsert, AMultiUpdate);
end;

function TMongoModelFactory.UserName(AUser: string): IMongoModel;
begin
  result := self;
  SetUserName(AUser);
end;

{ TJSONDocument }

class function TJSONDocument.New: IJSONDocument;
begin
  result := TJSONDocument.Create;
end;

class function TJSONDocument.New(const x: array of Variant): IJSONDocument;
begin
  result := JsonDoc.JSON(x);
end;

{ TJSONDocArray }

class function TJSONDocArray.New: IJSONDocArray;
begin
  result := TJSONDocArray.Create;
end;

// System.Json.Helper;
function TMongoModelFactory.Query(const ACollection: String;
const AArrayWhere: array of IJSONDocument): IJSONDocArray;
var
  j: TJsonObject;
  i: integer;
  v: TJsonObject;
  p: TJsonPair;
  s: string;
begin
  j := TJsonObject.Create;
  try
    for i := low(AArrayWhere) to high(AArrayWhere) do
    begin
      try
        s := AArrayWhere[i].ToString;
        v := TJsonObject.ParseJSONValue(s) as TJsonObject;
        for p in v do
          j.AddPair(p);
      finally
      end;
    end;
    result := Query(ACollection, JSON.Parse(j.ToJSON));
  finally
    j.free;
  end;
end;

function TMongoModelFactory.QueryRegEx(ACollection, AField, AText: String)
  : IJSONDocArray;
begin
  result := Query(ACollection, TMongoExpression.like(AField, AText));
end;

function TMongoModelFactory.GetSequence(FCollection,AMongoCampo: string): Int64;
Var
  d, dChave, e: IJSONDocument; // Obj BSON
  j: TJsonObject; // Obj JSON
  sField, sComand_Save, sComand_Modify: TStringBuilder;
  sCollectionSeq, sCollectionField: string;
  iRetorno: Int64;
begin
  // -- Gerando o Sequence para o AutoIncremento
  sField := TStringBuilder.Create;
  sComand_Save := TStringBuilder.Create;
  sComand_Modify := TStringBuilder.Create;
  j := TJsonObject.Create;
  try
    sComand_Save.clear;
    sComand_Modify.clear;
    sField.clear;
    sField.Append('_id_').Append(AnsiLowerCase(AMongoCampo));

    sCollectionSeq := '_sequence';
    sCollectionField := '_id';

    sComand_Save.Append('{ findAndModify: "').Append(sCollectionSeq)
      .Append('", query: { ').Append(sCollectionField).Append(': "')
      .Append(FCollection).Append('" }, update: {').Append(sCollectionField)
      .Append(': "').Append(FCollection).Append('", ').Append(sField.ToString)
      .Append(': 0 }, upsert:true }');

    sComand_Modify.Append('{ findAndModify: "').Append(sCollectionSeq)
      .Append('", query: { ').Append(sCollectionField).Append(': "')
      .Append(FCollection).Append('" }, update: { $inc: { ')
      .Append(sField.ToString).Append(': 1 } }, new:true }');

    j.AddPair(sCollectionField, TJSONString.Create(FCollection));
    dChave := JSON.Parse(j.ToJSON);

    try
      d :=  Get(sCollectionSeq, dChave);
      iRetorno := StrToInt64(d[sField.ToString]);
    except
      d := JSON.Parse(sComand_Save.ToString);
      e := RunCommand(d);
    end;
    try
      d := JSON.Parse(sComand_Modify.ToString);
      e := RunCommand(d);

      //result := StrToInt(VarToStr(BSON(e['value'])[sField.ToString]));
      result := StrToInt(sField.ToString);

    except
      result := -1;
      raise EMongoException.Create
        ('Mongo: n�o foi poss�vel gerar o AutoIncremento.');
    end;
  finally
    sField.free;
    sComand_Save.free;
    sComand_Modify.free;
    j.free;
  end;
end;

{ TMongoExpression }

class function TMongoExpression.between(AField: string; AFrom, ATo: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$gte', AFrom, '$lte', ATo])]);
end;

class function TMongoExpression.contains(AField, AText: string;
AOptions: String = 'i'): IJSONDocument;
begin
  result := JSON([AField, JSON(['$regex', bsonRegExPrefix + '/' + AText,
    '$options', AOptions])])
end;

class function TMongoExpression.eq(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$eq', AValue])]);
end;

class function TMongoExpression.gt(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$gt', AValue])]);
end;

class function TMongoExpression.gte(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$gte', AValue])]);

end;

class function TMongoExpression.lt(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$lt', AValue])]);
end;

class function TMongoExpression.lte(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$lte', AValue])]);
end;

class function TMongoExpression.ne(AField: string; AValue: Variant)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$ne', AValue])]);

end;

class function TMongoExpression.search(AField: string; AString: string)
  : IJSONDocument;
begin
  result := JSON([AField, JSON(['$search', AString])]);
end;

class function TMongoExpression.like(AField, AText: string;
AOptions: String = 'i'): IJSONDocument;
begin
  result := JSON([AField, JSON(['$regex', bsonRegExPrefix + '/^' + AText,
    '$options', AOptions])])
end;

end.
