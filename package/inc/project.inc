ProjectCode = 'program %ModuleIdent;                         ' + #13#10 +
  '                                                          ' + #13#10 +
  '// C�digo gerado pelo Assistente MVCBr OTA                ' + #13#10 +
  '// www.tireideletra.com.br                                ' + #13#10 +
  '// Amarildo Lacerda & Grupo MVCBr-2017                    ' + #13#10 +
  'uses                                                      ' + #13#10 +
  '  Forms, MVCBr.ApplicationController, MVCBr.Controller;   ' + #13#10 +
  '                                                          ' + #13#10 +
  '{$R *.res}                                                ' + #13#10 +
  'function CheckApplicationAuth: boolean;                   ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  // retornar True se o applicatio pode ser carregado ' + #13#10 +
  '  //          False se n�o foi autorizado inicializa��o' + #13#10 +
  '  result := true;                                         ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '/// Inicializa o Controller e Roda o MainForm       ' + #13#10 +
  'if CheckApplicationAuth then       ' +#13#10+
  '  ApplicationController.Run(T%ModuleIdentController.New);' + #13#10 +
  'end.                                                      ' + #13#10;

ProjectCodeFMX = 'program %ModuleIdent;                         ' + #13#10 +
  '                                                          ' + #13#10 +
  '// C�digo gerado pelo Assistente MVCBr OTA                ' + #13#10 +
  '// www.tireideletra.com.br                                ' + #13#10 +
  '// Amarildo Lacerda & Grupo MVCBr-2017                    ' + #13#10 +
  'uses                                                      ' + #13#10 +
  '  System.StartUpCopy,                                     ' + #13#10 +
  '  FMX.Forms, MVCBr.ApplicationController, MVCBr.Controller;' + #13#10 +
  '                                                          ' + #13#10 +
  '{$R *.res}                                                ' + #13#10 +
  'function CheckApplicationAuth: boolean;                   ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  // retornar True se o applicatio pode ser carregado ' + #13#10 +
  '  //          False se n�o foi autorizado inicializa��o' + #13#10 +
  '  result := true;                                         ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'begin                                                     ' + #13#10 +
  'if CheckApplicationAuth then '+#13#10+
  '  ApplicationController.Run(T%ModuleIdentController.New);' + #13#10 +
  'end.                                                      ' + #13#10;

promptProject = 'program %ModuleIdent;                       ' + #13#10 +
  '                                                          ' + #13#10 +
  '// C�digo gerado pelo Assistente MVCBr OTA                ' + #13#10 +
  '// www.tireideletra.com.br                                ' + #13#10 +
  '// Amarildo Lacerda & Grupo MVCBr-2017                    ' + #13#10 + ' ' +
  #13#10 + '{$APPTYPE CONSOLE} ' + #13#10 +
  '                                                          ' + #13#10 +
  '{$R *.res}                                         ' + #13#10 +
  'uses                                                      ' + #13#10 +
  '  System.SysUtils,MVCBr.ApplicationController,            ' + #13#10 +
  '  MVCBr.Controller;                                       ' + #13#10 +
  '                                                          ' + #13#10 +
  'function CheckApplicationAuth: boolean;                   ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  // retornar True se o applicatio pode ser carregado ' + #13#10 +
  '  //          False se n�o foi autorizado inicializa��o' + #13#10 +
  '  result := true;                                         ' + #13#10 +
  'end;                                                      ' + #13#10 +
  '                                                          ' + #13#10 +
  'begin                                                     ' + #13#10 +
  '  /// Inicializa o Controller                             ' + #13#10 +
  'if CheckApplicationAuth then '+#13#10+
  '  ApplicationController.Run(T%ModuleIdentController.New);  ' + #13#10 +
  '                                                          ' + #13#10 +
  'end.             ';
