unit eMVC.ClassModelCreator;

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
  Windows, SysUtils,
  eMVC.ViewCreator,
  eMVC.FileCreator,
  ToolsApi,
  eMVC.OTAUtilities,
  eMVC.BaseCreator;

const
{$I .\inc\ClassModelCode.inc}
{$I .\inc\ClassViewModelCode.inc}
type

  TClassModelCreator = class(TBaseCreator)
  private
    FisInterf: boolean;
    FisViewModel: boolean;
    FisController: boolean;
    FUnitIdent:string;
    procedure SetisInterf(const Value: boolean);
    procedure SetisViewModel(const Value: boolean);
    function ModelBase: String;
    procedure SetisController(const Value: boolean);
  public
    constructor Create(const APath: string = ''; ABaseName: string = '';
      AUnNamed: boolean = true); override;
    function GetImplFileName: string; override;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string)
      : IOTAFile; override;
    property isInterf: boolean read FisInterf write SetisInterf;
    property isViewModel: boolean read FisViewModel write SetisViewModel;
    property isController: boolean read FisController write SetisController;
  end;

implementation

{ TModelCreator }

constructor TClassModelCreator.Create(const APath: string = '';
  ABaseName: string = ''; AUnNamed: boolean = true);
begin
  inherited Create(APath, ABaseName, AUnNamed);
  self.SetAncestorName('model');
end;

function TClassModelCreator.ModelBase: String;
begin
  if isViewModel then
    result := '.ViewModel'
  else if isController then
    result := '.Controller'
  else
    result := '.Model';
end;

function TClassModelCreator.GetImplFileName: string;
begin


  FUnitIdent := getBaseName + ModelBase ;
  if isInterf then
    FUnitIdent := getBaseName + ModelBase + '.Interf';

  result := self.getpath + FUnitIdent + '.pas';

  if isViewModel then
    SetAncestorName('ViewModel')
  else if isController then
    SetAncestorName('Controller')
  else
    SetAncestorName('Model');

end;

function TClassModelCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  fc: TFileCreator;
begin

  debug('TClassModelCreator.NewImplSource: ');
  if isInterf then
  begin
    fc := TFileCreator.Create(ModuleIdent, FormIdent, AncestorIdent,
      cModelInterf);
    fc.FFuncSource := function: string
      begin
        result := ClassModelInterf;
        if isViewModel then
          result := classViewModelInterf
        else
          if isController then
            result := ClassControllerInterf;
      end;
  end
  else
  begin
    fc := TFileCreator.Create(ModuleIdent, FormIdent, AncestorIdent, cMODEL);
    fc.FFuncSource := function: string
      begin
        result := ClassModelCode;
        if isViewModel then
          result := classViewModelCode
        else if isController then
          result := classControllerCode;
      end;
  end;
  fc.Templates.assign(Templates);
  fc.Templates.Values['%MdlInterf'] := getBaseName + ModelBase + '.Interf';
  fc.Templates.Values['%UnitIdent'] := FUnitIdent;
  result := fc;
end;

procedure TClassModelCreator.SetisController(const Value: boolean);
begin
  FisController := Value;
end;

procedure TClassModelCreator.SetisInterf(const Value: boolean);
begin
  FisInterf := Value;
end;

procedure TClassModelCreator.SetisViewModel(const Value: boolean);
begin
  FisViewModel := Value;
end;

end.
