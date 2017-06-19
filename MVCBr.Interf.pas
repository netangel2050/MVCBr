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
{ Cr�ditos: }
{ Kleberson Toro }
{ Regys Silveira }
{ Ivan Cesar }
{ D�cio Morais }
{ Carlos Eduardo (Morfik) }
{ *************************************************************************** }

{
  Como organizar:
  - Um aplicativo s� pode ter um ApplicationController
  - Um Controler pode estar ligando a 0 ou 1 view... e pode conter uma lista de Models;
  - Todo Controller dever� se auto registrar no ApplicationController
  - Cada Controller � um Observable
  - Cada Model � um Observer
  - O controller pode enviar Update para os Models e para o View
  - O View pode receber Update do Controller e Enviar UpdateByView para o Controller
  - O Model pode receber Update do Controller e Enviar UpdateByModel para o Controller
  - Toda View conhece seu Controller
  - Todo Model conhece seu Controller
  - Um view pode ter somente um controller

  Agenda:
  - One Aplicattion have only one ApplicationController
  - One Controller contains View and Models (Zero or 1 View)  ( Zero or more Models  )
  - every Controller need self register on ApplicationControler

  - With Controller is an Observable - may dispach events for  any  Models
  - with Model is an Observer - may receive events from Controller (Observable)
  - with Model Know what is his controller (perhaps only one)
  - with Model can send event update for his controller that can send update for controller's view
  - with view have only one controller and can send update for his controller

  - ApplicationController have a list of controllers
}

unit MVCBr.Interf;

/// ---------------------------------------------------------------------------
/// <summary>
/// MVCBr.Interf  declara as interfaces bases para o MVCBr
/// O uso de interface objetivo minimizar o acoplamento das UNITs
/// o que ir� permitir reutiliza��o das mesmas interfaces
/// para um numero grande de UNIT;
/// </summary>
/// ---------------------------------------------------------------------------

interface

uses System.Classes, System.SysUtils, System.Generics.Collections,
  System.JSON, {$IFDEF LINUX}  {$ELSE}{$IFDEF FMX} FMX.layouts, FMX.Forms,
{$ELSE} VCL.Forms, {$ENDIF}{$ENDIF}
  MVCBr.Patterns.Factory, MVCBr.Patterns.Adapter,
  System.TypInfo, System.RTTI;

type

  IMVCBrObserver = interface;
  IMVCBrObservable = interface;

  ///
  /// MVCBr Utils
  /// Record para implementas utilidades de RTTI e outras Class Functions
  ///
  TMVCBr = record
    class function GetQualifiedName(AII: TGuid): string; static;
    /// compare two GUIDs
    class function IsSame(I1, I2: TGuid): boolean; static;
    /// compare two interfaces
    class function Equals(I1, I2: IInterface): boolean; static;
    /// check if it is an interface IOC service
    class function IsService<TInterface: IInterface>(Const Obj: TObject)
      : boolean; static;
    /// Get GUID from an anonimous Interface
    class function GetGuid<TInterface: IInterface>: TGuid; overload; static;
    /// convert GUID to string
    class function GetGuidString(IID: TGuid): string; static;
    /// Get guid from an interface
    class function GetGuid(const AInterface: IInterface): TGuid;
      overload; static;
    /// <summary>
    /// IOC routes
    /// </summary>
    class function InvokeCreate<TInterface: IInterface>(const AClass: TClass)
      : TInterface; overload; static;
    class function InvokeCreate(Const AGuid: TGuid; AClass: TClass): IInterface;
      overload; static;
    class function InvokeCreate<T: class>(const Args: TArray<TValue>): T;
      overload; static;
    class function InvokeMethod<T>(AInstance: TObject; AMethod: string;
      const Args: TArray<TValue>): T; static;
    class procedure SetProperty(AInstance: TObject; APropertyNome: string;
      AValue: TValue); static;
    class function GetProperty(AInstance: TObject; APropertyNome: string)
      : TValue; static;

    class procedure RegisterInterfaced<TInterface: IInterface>
      (const ANome: string; IID: TGuid; AClass: TInterfacedClass;
      bSingleton: boolean = true); overload; Static;
    class procedure RegisterType<TInterface: IInterface; TImplements: Class>
      (const ANome: string; bSingleton: boolean = true); overload; static;
    // class function Register<TClass:Class>:TMVCBrIOC;
    class function ResolveInterfaced<TInterface: IInterface>
      (const ANome: string): TInterface; static;
    /// <summary>
    /// Observers procedures
    /// </summary>
    class procedure RegisterObserver(AName: string; AObserver: IMVCBrObserver);
      overload; static;
    class procedure RegisterObserver(AObserver: IMVCBrObserver);
      overload; static;
    class procedure UnRegisterObserver(AObserver: IMVCBrObserver);
      overload; static;
    class procedure UnRegisterObserver(AName: string;
      AObserver: IMVCBrObserver); overload; static;
    class procedure UnRegisterObserver(const AName: string); overload; static;
    Class Procedure UpdateObserver(const AName: string; AJson: TJsonValue);
      overload; static;
    Class Procedure UpdateObserver(AJson: TJsonValue); overload; static;
    class function Observable: IMVCBrObservable; static;
  end;

  TMVCRegister = TMVCBr;
  /// compatibilidade


  IApplicationController = interface;

  /// IMVCBrBase publica assinatura de base para as classes Factories Base
  IMVCBrBase = interface
    ['{6027634D-6A9E-4FC2-A1CE-71B2194ACCDF}']
    function ApplicationControllerInternal: IApplicationController;
    function GetPropertyValue(ANome: string): TValue;
    procedure SetPropertyValue(ANome: string; const Value: TValue);
    property PropertyValue[ANome: string]: TValue read GetPropertyValue
      write SetPropertyValue;
    function GetGuid(AII: IInterface): TGuid;
  end;

  /// <summary>
  /// who want be an observer item
  /// </summary>
  IMVCBrObserver = interface
    ['{B5187999-9E7B-45CF-901B-DC0C14FF9105}']
    procedure Update(AJsonValue: TJsonValue; var AHandled: boolean); overload;
  end;

  TMVCBrObserverProc = TProc<TJsonValue>;

  IMVCBrObserverItem = interface
    ['{DE40A5D5-4492-4C3D-8369-378985ED0714}']
    procedure SetTopic(const Value: string);
    function GetTopic: string;
    function GetSubscribeProc: TMVCBrObserverProc;
    procedure SetSubscribeProc(const Value: TMVCBrObserverProc);
    procedure SetObserver(const Value: IMVCBrObserver);
  end;

  /// <summary>
  /// Abstract wrapper for TMVCBrObserverItem
  /// </summary>
  TMVCBrObserverItemAbstract = class(TMVCBrFactory, IMVCBrObserverItem)
  public
    procedure SetTopic(const Value: string); virtual; abstract;
    function GetTopic: string; virtual; abstract;
    function GetSubscribeProc: TMVCBrObserverProc; virtual; abstract;
    procedure SetSubscribeProc(const Value: TMVCBrObserverProc);
      virtual; abstract;
    procedure SetObserver(const Value: IMVCBrObserver); virtual; abstract;
    function GetObserver: IMVCBrObserver; virtual; abstract;
    procedure Send(AJsonValue: TJsonValue; var AHandled: boolean);
      virtual; abstract;
    property Observer: IMVCBrObserver read GetObserver write SetObserver;
    property Topic: string read GetTopic write SetTopic;
    property SubscribeProc: TMVCBrObserverProc read GetSubscribeProc
      write SetSubscribeProc;

  end;

  /// <summary>
  /// List of observers itens.
  /// </summary>
  IMVCBrObservable = interface
    ['{F9FEB955-A18E-484F-9F67-1AC97DFF7028}']
    function GetItems(idx: integer): TMVCBrObserverItemAbstract;
    procedure SetItems(idx: integer; const Value: TMVCBrObserverItemAbstract);
    function This: TObject;
    procedure Lock;
    procedure UnLock;
    function Count: integer;
    property Items[idx: integer]: TMVCBrObserverItemAbstract read GetItems
      write SetItems;
    function Subscribe(AProc: TMVCBrObserverProc): IMVCBrObserverItem; overload;
    procedure UnSubscribe(AProc: TMVCBrObserverProc); overload;
    procedure Send(AJson: TJsonValue); overload;
    procedure Send(const AName: string; AJson: TJsonValue); overload;
    procedure Register(const AName: string; AObserver: IMVCBrObserver);
  end;

  /// Classe Factory Base para incorporar RTTI e outros funcionalidades comuns
  /// a todos as classes Factories
  TMVCFactoryAbstract = class(TMVCBrFactory, IMVCBrBase, IMVCBrObserver)
  private
    FID: string;
    function GetPropertyValue(ANome: string): TValue;
    procedure SetPropertyValue(ANome: string; const Value: TValue);
  protected
    procedure SetID(const AID: string); virtual;

  public
    Function Lock: TMVCFactoryAbstract;virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    function ApplicationControllerInternal: IApplicationController; virtual;
    function GetID: string; virtual;
    class function New<TInterface: IInterface>(AClass: TClass)
      : TInterface; overload;
    function InvokeMethod<T>(AMethod: string; const Args: TArray<TValue>)
      : T; overload;
    property PropertyValue[ANome: string]: TValue read GetPropertyValue
      write SetPropertyValue;
    function AsType<TInterface: IInterface>: TInterface; overload;
    function GetGuid(AII: IInterface): TGuid; overload; virtual;
    /// <summary>
    /// Observer Methods
    /// </summary>
    procedure RegisterObserver(const AName: String; AObserver: IMVCBrObserver);
      overload; virtual;
    procedure RegisterObserver(const AName: string); overload; virtual;
    procedure RegisterObserver(AObserver: IMVCBrObserver); overload; virtual;
    procedure UnRegisterObserver(const AName: String); overload; virtual;
    procedure UnRegisterObserver(const AName: string;
      AObserver: IMVCBrObserver); overload; virtual;
    procedure UnRegisterObserver(AObserver: IMVCBrObserver); overload; virtual;
    procedure UpdateObserver(const AName: string; AJsonValue: TJsonValue);
      overload; virtual;
    procedure Update(AJsonValue: TJsonValue; var AHandled: boolean); virtual;

  end;

  IMVCOwnedInterfacedObject = interface
    ['{4076B6AF-FDD1-4E7D-B243-802C83AA56E8}']
    function GetOwner: TComponent;
    procedure SetOwner(const cmp: TComponent);
  end;

  TMVCOwnedInterfacedObject = Class(TMVCFactoryAbstract)
  private
    [unsafe]
    FOwner: TComponent;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetOwner: TComponent; virtual;
    procedure SetOwner(const AOwner: TComponent); virtual;
  end;

  IInterfaceAdapter = interface(IMVCBrAdapter)
    ['{EF8A7B2A-F5EC-4675-8E36-A6091820AB0A}']
  end;

  TInterfaceAdapter = class(TMVCBrAdapter,IInterfaceAdapter)
  private
    FClass: TClass;
    FGuid: TGuid;
  public
    class function New(const AGuid: TGuid; const AClass: TClass)
      : IInterfaceAdapter;
  end;

  TMVCFactoryAbstractClass = class of TMVCFactoryAbstract;

  TMVCInterfacedList<TInterface> = class(TInterfaceList)
  public
    procedure ForEach(AGuid: TGuid; AProc: TProc<TInterface>);
  end;

  IController = interface;

  /// uses IThis in base Classes
  /// Function This espera retornoar um TObject.
  ///
  IThis<T: class> = interface
    ['{D6AB571A-3644-43CF-809A-34E1CFD96A78}']
    function This: T;
  end;

  // uses IThisAs in higher Classes
  IThisAs<T: class> = interface
    ['{F4D37AD4-3F22-464B-B407-7958F425AD1C}']
    function ThisAs: T;
  end;

  ILayout = interface
    ['{1A24C293-9D1F-417D-924D-8DB033EFC701}']
    function GetLayout: TObject;
  end;

  // uses IModel to implement Bussines rules
  TModelType = (mtCommon, mtViewModel, mtModule, mtValidate, mtPersistent,
    mtNavigate, mtOrmModel, mtComponent);

  // IModel Interfaces
  IModel = interface;

  // Base para implementar IModel
  IModelBase = interface
    ['{E1622D13-701C-4AD8-8AD4-A1B64B8D251F}']
    function This: TObject;

    function GetID: string;
    function ID(const AID: String): IModel;
    function Update: IModel; overload;
    procedure Update(AJsonValue: TJsonValue; var AHandled: boolean); overload;

  end;

  // IModel representa a interface onde implementa as regras de neg�cio
  TModelTypes = set of TModelType;

  IModel = interface(IModelBase)
    ['{FC5669F0-546C-4F0D-B33F-5FB2BA125DBC}']
    function Controller(const AController: IController): IModel;
    function ApplicationControllerInternal: IApplicationController;
    function GetModelTypes: TModelTypes;
    function GetController: IController;
    procedure SetModelTypes(const AModelType: TModelTypes);
    property ModelTypes: TModelTypes read GetModelTypes write SetModelTypes;
    procedure AfterInit;
  end;

  TModelFactoryAbstract = class(TMVCOwnedInterfacedObject)

  end;

  TModelFactoryAbstractClass = class of TModelFactoryAbstract;

  IModelAs<TInterface: IInterface> = interface
    ['{2272BBD1-26B9-4F75-A820-E66AB4A16E86}']
    function ModelAs: TInterface;
  end;

  // IView will be implements in TForm...
  IView = interface;

  IViewBase = interface(IMVCBrBase)
    ['{B3302253-353A-4890-B7B1-B45FC41247F6}']
    function This: TObject;
    function ShowView(const AProc: TProc<IView>): integer; overload;
    function ShowView(): IView; overload;
    function UpdateView: IView;
    procedure Update(AJsonValue: TJsonValue; var AHandled: boolean); overload;

  end;

  IViewModel = interface;

  // IView � uma representa��o para FORM
  IView = interface(IViewBase)
    ['{A1E53BAC-BFCE-4D90-A54F-F8463D597E43}']
    function ViewEvent(AMessage: string; var AHandled: boolean): IView;
      overload;
    function ViewEvent(AMessage: TJsonValue; var AHandled: boolean)
      : IView; overload;
    function Controller(const AController: IController): IView;
    function GetController: IController;
    procedure SetController(const AController: IController);
    function GetModel(AII: TGuid): IModel;
    function GetViewModel: IViewModel;
    procedure SetViewModel(const AViewModel: IViewModel);
    function GetID: string;
    function GetTitle: String;
    procedure SetTitle(Const AText: String);
    property Title: string read GetTitle write SetTitle;
    Procedure DoCommand(ACommand: string; const AArgs: array of TValue);
    function ShowView(const AProcBeforeShow: TProc<IView>): integer; overload;
    function ShowView(const AProcBeforeShow: TProc<IView>; AShowModal: boolean)
      : IView; overload;
    function ShowView(const AProcBeforeShow: TProc<IView>;
      const AProcOnClose: TProc<IView>): IView; overload;
    procedure UpdateObserver(AJson: TJsonValue); overload;
    procedure UpdateObserver(AName: string; AJson: TJsonValue); overload;
    procedure Init;
  end;

  /// IViewAs a ser utilizado para fazer cast nas classes factories publicando
  /// a interface do factory superior
  IViewAs<TInterface: IInterface> = interface
    ['{F6831540-5311-4910-B25C-70AB21F3EF29}']
    function ViewAs: TInterface;
  end;

  /// Main Controller for all Application  - Have a list os Controllers
  IApplicationController = interface
    ['{207C0D66-6586-4123-8817-F84AC0AF29F3}']
    function ViewEvent(AMessage: string; var AHandled: boolean): IView;
      overload;
    function ViewEvent(AView: TGuid; AMessage: String; var AHandled: boolean)
      : IView; overload;
    function ViewEvent(AMessage: TJsonValue; var AHandled: boolean)
      : IView; overload;
    function MainView: IView;
    procedure SetMainView(AView: IView);
    function FindController(AGuid: TGuid): IController;
    function ResolveController(AGuid: TGuid): IController;
    procedure RevokeController(AGuid: TGuid);
    procedure Run(AClass: TComponentClass; AController: IController;
      AModel: IModel; AFunc: TFunc < boolean >= nil); overload;
    procedure Run(AController: IController;
      AFunc: TFunc < boolean >= nil); overload;
    function This: TObject;
    function Count: integer;
    function Add(const AController: IController): integer;
    procedure Delete(const idx: integer);
    procedure Remove(const AController: IController);
    procedure ForEach(AProc: TProc<IController>); overload;
    function ForEach(AProc: TFunc<IController, boolean>): boolean; overload;
    procedure UpdateAll;
    procedure Update(const AIID: TGuid);
    procedure Inited;
  end;

  TControllerAbstract = class;

  // Controller for an Unit
  IControllerBase = interface
    ['{5891921D-93C8-4B0A-8465-F7F0156AC228}']
    procedure Init;
    procedure BeforeInit;
    procedure AfterInit;
    function IndexOfModelType(const AModelType: TModelType): integer;
    function GetModelByType(const AModelType: TModelType): IModel;
    function UpdateByModel(AModel: IModel): IController;
    function UpdateAll: IController;
    function Add(const AModel: IModel): integer;
    function IndexOf(const AModel: IModel): integer;
    procedure Delete(const Index: integer);
    function Count: integer;
    function GetModel(const idx: integer): IModel;
    Procedure DoCommand(ACommand: string; const AArgs: array of TValue);
    function This: TControllerAbstract;
  end;

  IControllerAs<TInterface: IInterface> = interface
    ['{F190C15D-91EA-4CD4-AA5D-59ADB6D5AECB}']
    function ControllerAs: TInterface;
  end;

  TControllerAbstract = class(TMVCFactoryAbstract)
  protected
    [unsafe]
    FModels: TMVCInterfacedList<IModel>;
  public
    constructor Create; override;
    function This: TControllerAbstract;
    function ResolveMainForm(const AIID: TGuid; out ref): boolean; virtual;
    function GetModel(const IID: TGuid; out intf): IModel; overload; virtual;
    function GetModel(const IID: TGuid): IModel; overload; virtual;
    function GetModel<TModelInterface>(): TModelInterface; overload;
    procedure ResolveController(const AIID: TGuid; out ref)overload;
    function ResolveController(const AIID: TGuid): IController; overload;
    Function ResolveController(const ANome: string): IController; overload;
    Function ResolveController<TInterface>: TInterface; overload;
    class procedure RevokeInstance(const AII: IInterface); overload; virtual;
    function AttachModel(const AModel:IModel):integer;virtual;
  end;

  TControllerClass = class of TControllerAbstract;

  // IController manter associa��o entre o IView e IModel
  IController = interface(IControllerBase)
    ['{A7758E82-3AA1-44CA-8160-2DF77EC8D203}']
{$IFDEF FMX}
    procedure Embedded(AControl: TLayout);
{$ENDIF}
    function ViewEvent(AMessage: string; var AHandled: boolean): IView;
    function IsView(AII: TGuid): boolean;
    function IsController(AGuid: TGuid): boolean;
    function IsModel(AIModel: TGuid): boolean;
    function ApplicationControllerInternal: IApplicationController;
    function GetView: IView; overload;
    procedure SetView(AView:IView);
    function ShowView: IView; overload;
    function ShowView(const AProcBeforeShow: TProc<IView>;
      Const AProcOnClose: TProc<IView>): IView; overload;

    function View(const AView: IView): IController; overload;
    function UpdateByView(AView: IView): IController;
    procedure ForEach(AProc: TProc<IModel>);
    function ResolveController(const AName: string): IController; overload;
    function ResolveController(const AIID: TGuid): IController; overload;
    // procedure RevokeInstance;
    function GetModel(const IID: TGuid; out intf): IModel; overload;
    function GetModel(const IID: TGuid): IModel; overload;
    function This: TControllerAbstract;
    function Start: IController;
    function AttachModel(const AModel:IModel):integer;
  end;

  IViewModelAs<TInterface: IInterface> = interface
    ['{79D16DA9-EB18-4F17-A748-6A7E29A59992}']
    function ViewModelAs: TInterface;
  end;

  IViewModelBase = interface(IModel)
    ['{EB040A36-70EE-4DFB-9750-A0227D45D113}']
    function This: TObject;
    function View(const AView: IView = nil): IViewModel;
    function Model(const AModel: IModel = nil): IViewModel;
    function UpdateView(const AView: IView): IViewModel; overload;
    function Update(const AModel: IModel): IViewModel; overload;
  end;

  // IViewModel associa o FORM com o o seu MODEL
  IViewModel = interface(IViewModelBase)
    ['{9F943F5D-4367-4537-857F-1399DBF7133F}']
    function Controller(const AController: IController): IViewModel;
    procedure AfterInit;
  end;

  IPersistentModel = interface;

  IPersistentModelBase = interface(IModel)
    ['{0E0C626B-AE54-4050-9EA0-C8079FCA75BC}']
  end;

  IPersistentModel = interface(IPersistentModelBase)
    ['{BF5767E0-FF6E-4A60-9409-9163AE4EDA4D}']
    function Controller(const AController: IController): IPersistentModel;
  end;

  INavigatorModel = interface;

  INavigatorModelBase = interface(IModel)
    ['{0E0C626B-AE54-4050-9EA0-C8079FCA75BC}']
  end;

  INavigatorModel = interface(INavigatorModelBase)
    ['{BF5767E0-FF6E-4A60-9409-9163AE4EDA4D}']
    function Controller(const AController: IController): INavigatorModel;
  end;

  IValidateModel = interface(IModel)
    ['{01A80AFD-8674-4E05-BCC4-00514DE84D88}']
  end;

  IModuleModel = interface(IModel)
    ['{FF946C5D-1385-443B-873E-B1DA1C54FECA}']
  end;

  IOrmModel = Interface(IModel)
    ['{043D4745-9F20-4BFD-94AF-5727357A50B5}']
  End;



procedure RegisterInterfacedClass(const ANome: string; IID: TGuid;
  AClass: TInterfacedClass; bSingleton: boolean = true); overload;
procedure UnregisterInterfacedClass(const ANome: string);

// var
// FControllersClass: TObject;

implementation

uses {$IFNDEF BPL}
  MVCBr.InterfaceHelper,
{$ENDIF}
  MVCBr.ApplicationController, MVCBr.IoC,
  MVCBr.Observable;

procedure RegisterInterfacedClass(const ANome: string; IID: TGuid;
  AClass: TInterfacedClass; bSingleton: boolean = true);
begin
  TMVCBr.RegisterInterfaced<IController>(ANome, IID, AClass, bSingleton);
  // TMVCBr.Register<AClass>.implements(IID).Singleton := bSingleton;
end;

class procedure TMVCBr.RegisterType<TInterface; TImplements>
  (const ANome: string; bSingleton: boolean = true);
begin
  TMVCBrIoc.DefaultContainer.RegisterType<TInterface, TImplements>
    (bSingleton, ANome);
end;

class procedure TMVCBr.RegisterInterfaced<TInterface>(const ANome: string;
  IID: TGuid; AClass: TInterfacedClass; bSingleton: boolean = true);
begin
  {
   TMVCBrIoc.DefaultContainer.RegisterInterfaced<TInterface>(IID, AClass, ANome,
    bSingleton);
  }
  TMVCBrIoc.DefaultContainer.RegisterType<TInterface>(ANome).Guid(IID).ImplementClass(AClass)
    .Singleton(bSingleton);

end;

class procedure TMVCBr.RegisterObserver(AObserver: IMVCBrObserver);
begin
  TMVCBrObservable.DefaultContainer.Register(AObserver);
end;

class procedure TMVCBr.RegisterObserver(AName: string;
  AObserver: IMVCBrObserver);
begin
  TMVCBrObservable.DefaultContainer.Register(AName, AObserver);
end;

procedure UnregisterInterfacedClass(const ANome: string);
begin
  /// nao precisa fazer nada.
  /// avaliar se seria interessate retirar o registro da memoria ainda que nao seja necessario.
end;

{ TControllerAbstract }

function TControllerAbstract.AttachModel(const AModel: IModel): integer;
begin
  result := -1;
  FModels.Add(AModel);
  result := FModels.count -1;
end;

constructor TControllerAbstract.Create;
begin
  inherited;
end;

function TControllerAbstract.GetModel(const IID: TGuid; out intf): IModel;
var
  I: integer;
begin
  for I := 0 to FModels.Count - 1 do
    if supports((FModels.Items[I] as IModel).This, IID, intf) then
    begin
      result := FModels.Items[I] as IModel;
      supports(result.This, IID, intf);
      exit;
    end;
end;

function TControllerAbstract.GetModel(const IID: TGuid): IModel;
begin
  GetModel(IID, result)
end;

function TControllerAbstract.GetModel<TModelInterface>(): TModelInterface;
var
  I: integer;
  pInfo: PTypeInfo;
  IID: TGuid;
begin
  pInfo := TypeInfo(TModelInterface);
  IID := GetTypeData(pInfo).Guid;
  for I := 0 to FModels.Count - 1 do
    if supports((FModels.Items[I] as IModel).This, IID, result) then
    begin
      exit;
    end;
end;

function TControllerAbstract.ResolveController(const ANome: string)
  : IController;
var
  achei: boolean;
  IID: TGuid;
begin
  IID := TMVCBrIoc.DefaultContainer.GetGuid(ANome);
  achei := ResolveMainForm(IID, result);
  if not achei then
  begin
    result := TMVCBrIoc.DefaultContainer.Resolve<IController>(ANome);
    result.Init;
  end;
end;

function TControllerAbstract.ResolveController<TInterface>: TInterface;
var
  pInfo: PTypeInfo;
  IID: TGuid;
begin
  pInfo := TypeInfo(TInterface);
  IID := GetTypeData(pInfo).Guid;
  ResolveController(IID, result);
end;

function TControllerAbstract.ResolveMainForm(const AIID: TGuid;
  out ref): boolean;
var
  AView: IView;
  AController: IController;
begin
  result := false;
{$IFDEF LINUX}
{$ELSE}
  if assigned(Application.MainForm) then
  begin
    if supports(Application.MainForm, IView, AView) then
    begin
      AController := AView.GetController;
      result := supports(AController.This, AIID, ref);
    end;
  end;
{$ENDIF}
end;

class procedure TControllerAbstract.RevokeInstance(const AII: IInterface);
begin
  if assigned(AII) then
    TMVCBrIoc.DefaultContainer.RevokeInstance(AII);
end;

function TControllerAbstract.ResolveController(const AIID: TGuid): IController;
begin
  ResolveController(AIID, result);
end;

procedure TControllerAbstract.ResolveController(const AIID: TGuid; out ref);
var
  achei: string;
  ii: IController;
begin
  if not ResolveMainForm(AIID, ref) then
  begin
    achei := TMVCBrIoc.DefaultContainer.GetName(AIID);
    if achei = '' then
      exit;
    ii := ResolveController(achei);
    if ii <> nil then
      supports(ii.This, AIID, ref);
  end;
end;

function TControllerAbstract.This: TControllerAbstract;
begin
  result := self;
end;

{ TMVCBr }
class function TMVCBr.ResolveInterfaced<TInterface>(const ANome: string)
  : TInterface;
begin
  result := TMVCBrIoc.DefaultContainer.Resolve<TInterface>(ANome);
end;

class function TMVCBr.Equals(I1, I2: IInterface): boolean;
var
  g1, g2: TGuid;
begin
  g1 := GetGuid(I1);
  g2 := GetGuid(I2);
  result := TMVCBr.IsSame(g1, g2);
end;

class function TMVCBr.GetGuid(const AInterface: IInterface): TGuid;
begin
{$IFNDEF BPL}
  result := TInterfaceHelper.GetType(AInterface).Guid
{$ENDIF}
end;

class function TMVCBr.GetGuid<TInterface>: TGuid;
var
  pInfo: PTypeInfo;
  IID: TGuid;
begin
  pInfo := TypeInfo(TInterface);
  result := GetTypeData(pInfo).Guid;
end;

class function TMVCBr.GetGuidString(IID: TGuid): string;
begin
  result := GUIDToString(IID);
end;

class function TMVCBr.GetProperty(AInstance: TObject;
  APropertyNome: string): TValue;
var
  ctx: TRttiContext;
  prp: TRttiProperty;
begin
  ctx := TRttiContext.Create;
  try
    prp := ctx.GetType(AInstance.ClassType).GetProperty(APropertyNome);
    if assigned(prp) then
      result := prp.GetValue(AInstance);
  finally
    ctx.Free();
  end;
end;

class function TMVCBr.GetQualifiedName(AII: TGuid): string;
begin
{$IFNDEF BPL}
  result := TInterfaceHelper.GetQualifiedName(AII);
{$ENDIF}
end;

class function TMVCBr.InvokeCreate(const AGuid: TGuid; AClass: TClass)
  : IInterface;
var
  Obj: TObject;
begin
  Obj := AClass.Create;
  supports(Obj, AGuid, result);
  if not assigned(result) then
    Obj.DisposeOf;
end;

class function TMVCBr.InvokeCreate<T>(const Args: TArray<TValue>): T;
var
  ctx: TRttiContext;
begin
  ctx := TRttiContext.Create;
  try
    result := ctx.GetType(TClass(T)).GetMethod('create').Invoke(TClass(T), Args)
      .AsType<T>;
  finally
    ctx.Free();
  end;
end;

class function TMVCBr.InvokeCreate<TInterface>(const AClass: TClass)
  : TInterface;
var
  Obj: TObject;
begin
  Obj := AClass.Create;
  supports(Obj, GetGuid<TInterface>, result);
  if not assigned(result) then
    Obj.DisposeOf;
end;

class function TMVCBr.InvokeMethod<T>(AInstance: TObject; AMethod: string;
  const Args: TArray<TValue>): T;
var
  ctx: TRttiContext;
  mtd: TRttiMethod;
  Value: TValue;
begin
  ctx := TRttiContext.Create;
  try
    mtd := ctx.GetType(AInstance.ClassInfo).GetMethod(AMethod);
    Value := mtd.Invoke(AInstance, Args); // .AsType<T>;
    Value.TryAsType(result);
  finally
    ctx.Free();
  end;
end;

class function TMVCBr.IsSame(I1, I2: TGuid): boolean;
begin
  result := GUIDToString(I1) = GUIDToString(I2);
end;

class function TMVCBr.IsService<TInterface>(const Obj: TObject): boolean;
begin
  result := supports(Obj, GetGuid<TInterface>);
end;

class function TMVCBr.Observable: IMVCBrObservable;
begin
  result := TMVCBrObservable.DefaultContainer;
end;

class procedure TMVCBr.UpdateObserver(const AName: string; AJson: TJsonValue);
begin
  TMVCBrObservable.DefaultContainer.Send(AName, AJson);
end;

class procedure TMVCBr.UpdateObserver(AJson: TJsonValue);
begin
  TMVCBrObservable.DefaultContainer.Send(AJson);
end;

class procedure TMVCBr.SetProperty(AInstance: TObject; APropertyNome: string;
  AValue: TValue);
var
  ctx: TRttiContext;
  prp: TRttiProperty;
begin
  ctx := TRttiContext.Create;
  try
    prp := ctx.GetType(AInstance.ClassType).GetProperty(APropertyNome);
    if assigned(prp) then
      prp.SetValue(AInstance, AValue);
  finally
    ctx.Free();
  end;
end;

class procedure TMVCBr.UnRegisterObserver(const AName: string);
begin
  TMVCBrObservable.DefaultContainer.UnRegister(AName, nil);
end;

class procedure TMVCBr.UnRegisterObserver(AName: string;
  AObserver: IMVCBrObserver);
begin
  TMVCBrObservable.DefaultContainer.UnRegister(AName, AObserver);
end;

class procedure TMVCBr.UnRegisterObserver(AObserver: IMVCBrObserver);
begin
  TMVCBrObservable.DefaultContainer.UnRegister(AObserver);
end;

{ TMVCFactoryAbstract }

function TMVCFactoryAbstract.AsType<TInterface>: TInterface;
var
  pInfo: PTypeInfo;
  IID: TGuid;
begin
  pInfo := TypeInfo(TInterface);
  IID := GetTypeData(pInfo).Guid;
  supports(self, IID, result);
end;

var
  LFactoryCount: integer = 0;

constructor TMVCFactoryAbstract.Create;
begin
  inherited;
  inc(LFactoryCount);
  FID := ClassName + '_' + intToStr(LFactoryCount);
end;

destructor TMVCFactoryAbstract.Destroy;
begin
  inherited;
end;

function TMVCFactoryAbstract.GetGuid(AII: IInterface): TGuid;
begin
  result := TMVCBr.GetGuid(AII);
end;

function TMVCFactoryAbstract.GetID: string;
begin
  result := FID;
end;

function TMVCFactoryAbstract.GetPropertyValue(ANome: string): TValue;
begin
  result := TMVCBr.GetProperty(self, ANome);
end;

function TMVCFactoryAbstract.InvokeMethod<T>(AMethod: string;
  const Args: TArray<TValue>): T;
begin
  result := TMVCBr.InvokeMethod<T>(self, AMethod, Args);
end;

function TMVCFactoryAbstract.Lock: TMVCFactoryAbstract;
begin
  result := self;
  inherited Lock;
end;

function TMVCFactoryAbstract.ApplicationControllerInternal
  : IApplicationController;
begin
  result := MVCBr.ApplicationController.ApplicationController;
end;

class function TMVCFactoryAbstract.New<TInterface>(AClass: TClass): TInterface;
var
  IID: TGuid;
  Obj: TObject;
begin
  IID := TMVCBr.GetGuid<TInterface>();
  Obj := AClass.Create;
  if not supports(Obj, IID, result) then
    Obj.DisposeOf;
end;

procedure TMVCFactoryAbstract.RegisterObserver(const AName: string);
begin
  RegisterObserver(AName, self);
end;

procedure TMVCFactoryAbstract.RegisterObserver(const AName: String;
  AObserver: IMVCBrObserver);
begin
  TMVCBr.RegisterObserver(AName, AObserver);
end;

procedure TMVCFactoryAbstract.SetID(const AID: string);
begin
  FID := AID;
end;

procedure TMVCFactoryAbstract.SetPropertyValue(ANome: string;

  const Value: TValue);
begin
  TMVCBr.SetProperty(self, ANome, Value);
end;


procedure TMVCFactoryAbstract.UnRegisterObserver(AObserver: IMVCBrObserver);
begin
  TMVCBr.UnRegisterObserver(AObserver);
end;

procedure TMVCFactoryAbstract.UnRegisterObserver(const AName: String);
begin
  TMVCBr.UnRegisterObserver(AName);
end;

procedure TMVCFactoryAbstract.UnRegisterObserver(const AName: string;
  AObserver: IMVCBrObserver);
begin
  TMVCBr.UnRegisterObserver(AName, AObserver);
end;

procedure TMVCFactoryAbstract.Update(AJsonValue: TJsonValue;
  var AHandled: boolean);
begin

end;

procedure TMVCFactoryAbstract.UpdateObserver(const AName: string;
  AJsonValue: TJsonValue);
begin
  TMVCBr.UpdateObserver(AName, AJsonValue);
end;

{ TMVCInterfacedList<T> }

procedure TMVCInterfacedList<TInterface>.ForEach(AGuid: TGuid;
  AProc: TProc<TInterface>);
var
  I: integer;
  intf: TInterface;
begin
  if assigned(AProc) then
    for I := 0 to Count - 1 do
    begin
      supports(Items[I], AGuid, intf);
      AProc(intf);
    end;
end;

procedure TMVCFactoryAbstract.RegisterObserver(AObserver: IMVCBrObserver);
begin
  TMVCBr.RegisterObserver(AObserver);
end;

{ TInterfaceAdapter }

class function TInterfaceAdapter.New(const AGuid: TGuid; const AClass: TClass)
  : IInterfaceAdapter;
var
  Obj: TInterfaceAdapter;
begin
  Obj := TInterfaceAdapter.Create;
  Obj.FClass := AClass;
  Obj.FGuid := AGuid;
  result := Obj;
end;

{ TMVCInterfacedObject }

constructor TMVCOwnedInterfacedObject.Create;
begin
  inherited;
  FOwner := TComponent.Create(nil);
end;

destructor TMVCOwnedInterfacedObject.Destroy;
begin
  FOwner.DisposeOf;
  inherited;
end;

function TMVCOwnedInterfacedObject.GetOwner: TComponent;
begin
  result := FOwner;
end;

procedure TMVCOwnedInterfacedObject.SetOwner(const AOwner: TComponent);
begin
  FOwner := AOwner;
end;

initialization

// FControllersClass := TMVCBrIoc.create;

finalization

// FControllersClass.Free;

end.
