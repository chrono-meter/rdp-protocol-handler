#define MyAppTitle "RDP protocol handler"
#define MyAppName "rdp-protocol-handler"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "chrono-meter@gmx.net"
#define MyAppURL "https://github.com/chrono-meter/rdp-protocol-handler"

[Setup]
AppId={{8CF91C0E-652F-421C-9DCC-8C87702D2CCE}
AppName={#MyAppTitle}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
;AppPublisherURL={#MyAppURL}
;AppSupportURL={#MyAppURL}
;AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\Programs\rdp-protocol-handler
PrivilegesRequired=lowest
OutputBaseFilename=setup-{#MyAppName}-{#MyAppVersion}
Compression=lzma
SolidCompression=yes

[Languages]
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[Files]
Source: "rdp-protocol-handler.ps1"; DestDir: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\rdp"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\rdp"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKCU; Subkey: "Software\Classes\rdp\DefaultIcon"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\rdp\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{sys}\mstsc.exe,0"
Root: HKCU; Subkey: "Software\Classes\rdp\shell"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\rdp\shell"; ValueType: string; ValueName: ""; ValueData: "open"
Root: HKCU; Subkey: "Software\Classes\rdp\shell\open"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\rdp\shell\open\command"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\rdp\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{sys}\WindowsPowerShell\v1.0\powershell.exe"" -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\rdp-protocol-handler.ps1"" ""%1"""
