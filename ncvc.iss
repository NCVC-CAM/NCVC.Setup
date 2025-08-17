[Setup]
OutputBaseFilename=ncvc415b_install
AppName=NCVC
AppVerName=NCVC Version 4.15b
AppVersion=4.15b
VersionInfoVersion=4.1.5.2
VersionInfoDescription=NCVC setup program
AppCopyright=MNCT-S K.Magara
AppPublisher=MNCT-S
AppPublisherURL=http://k-magara.github.io/
AppSupportURL=http://k-magara.github.io/
AppUpdatesURL=http://k-magara.github.io/
DefaultDirName={pf}\NCVC
DefaultGroupName=NCVC
LicenseFile=license.txt
AllowNoIcons=yes
UninstallDisplayIcon={app}\NCVC.exe

[Components]
Name: "Main"; Description: "NCVC �ŏ��\��"; Types: full compact custom; Flags: fixed
Name: "Manual"; Description: "NCVC�����"; Types: full;
Name: "Samples"; Description: "�T���v���f�[�^"; Types: full;
Name: "Texture"; Description: "�e�N�X�`���p�摜�f�[�^"; Types: full;
Name: "ReadJW"; Description: "�A�h�C�� ReadJW"; Types: full;
Name: "ReadCSV"; Description: "�A�h�C�� ReadCSV"; Types: full;
Name: "SendNCD"; Description: "�A�h�C�� SendNCD"; Types: full;
Name: "SolveTSP"; Description: "�A�h�C�� SolveTSP"; Types: full;
Name: "Scriptorium"; Description: "�X�N���v�g���b�p�["; Types: full;
Name: "SampleScripts"; Description: "�T���v���X�N���v�g"; Types: full;

[Tasks]
Name: "desktopicon"; Description: "�f�X�N�g�b�v�ɃV���[�g�J�b�g�̍쐬"; GroupDescription: "�A�C�R���̒ǉ�:"; Flags: unchecked

[Files]
Source: "vc_redist.x86.exe"; Flags: dontcopy
Source: "ncvc\NCVC.exe"; DestDir: "{app}"; Components: Main; Flags: ignoreversion
Source: "ncvc\NCVC.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC2.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC3.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC4.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC5.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC6.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\NCVC7.pdf"; DestDir: "{app}"; Components: Manual;
Source: "ncvc\Init.nci"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Deep.nci"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Init.ncj"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Init.ncw"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Laser.nci"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Init.mnc"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Lathe.mnc"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Wire.mnc"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Header.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Footer.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\HeaderLathe.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\FooterLathe.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\HeaderWire.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\FooterWire.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\HeaderLaser.txt"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\NCVCcolor.ini"; DestDir: "{app}"; Components: Main; Flags: onlyifdoesntexist
Source: "ncvc\Gcode.txt"; DestDir: "{app}"; Components: Main;
Source: "ncvc\GcodeLathe.txt"; DestDir: "{app}"; Components: Main;
Source: "ncvc\GcodeWire.txt"; DestDir: "{app}"; Components: Main;
Source: "ncvc\Readme.txt"; DestDir: "{app}"; Components: Main; Flags: isreadme
Source: "ncvc\sample\*"; DestDir: "{app}\sample"; Components: Samples;
Source: "ncvc\Texture\*"; DestDir: "{app}\texture"; Components: Texture; Flags: onlyifdoesntexist
Source: "ncvc\ReadJW\*"; DestDir: "{app}"; Components: ReadJW; Flags: ignoreversion
Source: "ncvc\ReadCSV\*"; DestDir: "{app}"; Components: ReadCSV; Flags: ignoreversion
Source: "ncvc\SendNCD\*"; DestDir: "{app}"; Components: SendNCD; Flags: ignoreversion
Source: "ncvc\SolveTSP\*"; DestDir: "{app}"; Components: SolveTSP; Flags: ignoreversion
Source: "ncvc\Scriptorium\*"; DestDir: "{app}"; Components: Scriptorium; Flags: ignoreversion
Source: "ncvc\scripts\*"; DestDir: "{app}\scripts"; Components: SampleScripts; Flags: recursesubdirs

[Code]
function IsMFCregistry: boolean;
var
  DisplayName: String;
begin
  if RegQueryStringValue(HKEY_CLASSES_ROOT, 'Installer\Dependencies\Microsoft.VS.VC_RuntimeMinimumVSU_x86,v14', 'DisplayName', DisplayName) then begin
    if Pos('2022 X86', DisplayName) > 0 then begin
      Result := true;
    end else begin
      Result := false;
    end;
  end else begin
    Result := false;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if ( CurStep = ssPostInstall ) then begin
    if not IsMFCregistry() then begin
      if MsgBox('NCVC���s�ɕK�v��MFC����т��C���X�g�[�����܂����H', mbConfirmation, MB_YESNO) = IDYES then begin
        ExtractTemporaryFile('vc_redist.x86.exe');
        Exec(ExpandConstant('{tmp}\vc_redist.x86.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
      end;
    end;
  end;
end;

[Icons]
Name: "{group}\NCVC"; Filename: "{app}\NCVC.exe"
Name: "{group}\NCVC�����"; Filename: "{app}\NCVC.pdf"
Name: "{group}\�����֊s���������"; Filename: "{app}\NCVC2.pdf"
Name: "{group}\���Ճf�[�^���������"; Filename: "{app}\NCVC3.pdf"
Name: "{group}\���C�����d���H�@�f�[�^���������"; Filename: "{app}\NCVC4.pdf"
Name: "{group}\CAD�ް��̓��������"; Filename: "{app}\NCVC5.pdf"
Name: "{group}\�����̃��[�N���W���_����������菇��"; Filename: "{app}\NCVC6.pdf"
Name: "{group}\NURBS�Ȗʂ̐؍�f�[�^���������"; Filename: "{app}\NCVC7.pdf"
Name: "{group}\NCVC�̃A���C���X�g�[��"; Filename: "{uninstallexe}"
Name: "{userdesktop}\NCVC"; Filename: "{app}\NCVC.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\NCVC.exe"; Description: "NCVC���N��"; Flags: nowait postinstall runmaximized skipifsilent

[Registry]
Root: HKCR; Subkey: ".cam"; ValueType: string; ValueName: ""; ValueData: "CAM.Document"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "CAM.Document"; ValueType: string; ValueName: ""; ValueData: "CAM.Document"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".dxf"; ValueType: string; ValueName: ""; ValueData: "DXF.Document"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "DXF.Document"; ValueType: string; ValueName: ""; ValueData: "DXF.Document"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".ncd"; ValueType: string; ValueName: ""; ValueData: "NC.Document"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "NC.Document"; ValueType: string; ValueName: ""; ValueData: "NC.Document"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\MNCT-S\NCVC"; Flags: uninsdeletekey

;[InstallDelete]
;Type: files; Name: "{app}\sample\*";

; *** Inno Setup version 4.2.2+ Japanese messages ***
;
; Translation by Mark Callow <callow_mark@hicorp.co.jp>.
; Based on original by Koji Ueda.
;
; To download user-contributed translations of this file, go to:
;   http://www.jrsoftware.org/is3rdparty.php
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).
;
; $jrsoftware: issrc/Files/Default.isl,v 1.51 2004/02/08 18:50:49 jr Exp $

[LangOptions]
LanguageName=Japanese
LanguageID=$0411
LanguageCodePage=932
; If the language you are translating to requires special font faces or
; sizes, uncomment any of the following entries and change them accordingly.
DialogFontName=�l�r �o�S�V�b�N
DialogFontSize=9
TitleFontName=�l�r �o�S�V�b�N
TitleFontSize=29
WelcomeFontName=�l�r �o�S�V�b�N
WelcomeFontSize=12
CopyrightFontName=�l�r �o�S�V�b�N
CopyrightFontSize=8

[Messages]

; *** Application titles
SetupAppTitle=�Z�b�g�A�b�v
SetupWindowTitle=%1 �Z�b�g�A�b�v
UninstallAppTitle=�A���C���X�g�[��
UninstallAppFullTitle=%1 �A���C���X�g�[��

; *** Misc. common
InformationTitle=���
ConfirmTitle=�m�F
ErrorTitle=�G���[

; *** SetupLdr messages
SetupLdrStartupMessage=%1 ���C���X�g�[�����܂��B���s���܂����H
LdrCannotCreateTemp=�ꎞ�t�@�C�����쐬�ł��܂���B�Z�b�g�A�b�v�𒆎~���܂��B
LdrCannotExecTemp=�ꎞ�t�H���_�̃t�@�C�������s�ł��܂���B�Z�b�g�A�b�v�𒆎~���܂��B

; *** Startup error messages
LastErrorMessage=%1.%n%n�G���[ %2: %3
SetupFileMissing=�t�@�C�� %1 ��������܂���B�����������邩�V�����Z�b�g�A�b�v�v���O��������肵�Ă��������B
SetupFileCorrupt=�Z�b�g�A�b�v�t�@�C�������Ă��܂��B�V�����Z�b�g�A�b�v�v���O��������肵�Ă��������B
SetupFileCorruptOrWrongVer=�Z�b�g�A�b�v�t�@�C�������Ă��邩�A���̃o�[�W�����̃Z�b�g�A�b�v�ƌ݊���������܂���B�����������邩�V�����Z�b�g�A�b�v�v���O��������肵�Ă��������B
NotOnThisPlatform=���̃v���O������ %1 �ł͓��삵�܂���B
OnlyOnThisPlatform=���̃v���O�����̎��s�ɂ� %1 ���K�v�ł��B
WinVersionTooLowError=���̃v���O�����̎��s�ɂ� %1 %2 �ȍ~���K�v�ł��B
WinVersionTooHighError=���̃v���O������ %1 %2 �ȍ~�ł͓��삵�܂���B
AdminPrivilegesRequired=���̃v���O�������C���X�g�[�����邽�߂ɂ͊Ǘ��҂Ƃ��ă��O�C������K�v������܂��B
PowerUserPrivilegesRequired=���̃v���O�������C���X�g�[�����邽�߂ɂ͊Ǘ��҂܂��̓p���[���[�U�[�Ƃ��ă��O�C������K�v������܂��B
SetupAppRunningError=�Z�b�g�A�b�v�͎��s���� %1 �����o���܂����B%n%n�J���Ă���A�v���P�[�V���������ׂĕ��Ă���uOK�v���N���b�N���Ă��������B�u�L�����Z���v���N���b�N����ƁA�Z�b�g�A�b�v���I�����܂��B
UninstallAppRunningError=�A���C���X�g�[���͎��s���� %1 �����o���܂����B%n%n�J���Ă���A�v���P�[�V���������ׂĕ��Ă���uOK�v���N���b�N���Ă��������B�u�L�����Z���v���N���b�N����ƁA�Z�b�g�A�b�v���I�����܂��B

; *** Misc. errors
ErrorCreatingDir=�t�H���_ %1 ���쐬���ɃG���[���������܂����B
ErrorTooManyFilesInDir=�t�H���_ %1 �Ƀt�@�C�����쐬���ɃG���[���������܂����B�t�@�C���̐����������܂��B

; *** Setup common messages
ExitSetupTitle=�Z�b�g�A�b�v�I��
ExitSetupMessage=�Z�b�g�A�b�v��Ƃ͊������Ă��܂���B�����ŃZ�b�g�A�b�v���I������ƃv���O�����̓C���X�g�[������܂���B%n%n���߂ăC���X�g�[������ꍇ�́A������x�Z�b�g�A�b�v�����s���Ă��������B%n%n�Z�b�g�A�b�v���I�����܂����H
AboutSetupMenuItem=�Z�b�g�A�b�v�ɂ���(&A)...
AboutSetupTitle=�Z�b�g�A�b�v�ɂ���
AboutSetupMessage=%1 %2%n%3%n%n%1 �z�[���y�[�W:%n%4
AboutSetupNote=

; *** Buttons
ButtonBack=< �߂�(&B)
ButtonNext=����(&N) >
ButtonInstall=�C���X�g�[��(&I)
ButtonOK=OK
ButtonCancel=�L�����Z��
ButtonYes=�͂�(&Y)
ButtonYesToAll=���ׂĂ͂�(&A)
ButtonNo=������(&N)
ButtonNoToAll=���ׂĂ�����(&O)
ButtonFinish=����(&F)
ButtonBrowse=�Q��(&B)...
ButtonWizardBrowse=�Q��(&r)
ButtonNewFolder=�V�����t�H���_(&M)

; *** "Select Language" dialog messages
SelectLanguageTitle=�Z�g�A�v�̌��t��I���
SelectLanguageLabel=�C���X�g�������p���t���т܂�:

; *** Common wizard text
ClickNext=���s����ɂ́u���ցv�A�Z�b�g�A�b�v���I������ɂ́u�L�����Z���v���N���b�N���Ă��������B
BeveledLabel=
BrowseDialogTitle=�t�H���_�Q��
BrowseDialogLabel=���X�g����t�H���_��I��OK�������Ă��������B
NewFolderName=�V�����t�H���_

; *** "Welcome" wizard page
WelcomeLabel1=[name] �Z�b�g�A�b�v�E�B�U�[�h�̊J�n
WelcomeLabel2=���̃v���O�����͂��g�p�̃R���s���[�^�� [name/ver] ���C���X�g�[�����܂��B%n%n���s����O�ɑ��̃A�v���P�[�V���������ׂďI�����Ă��������B

; *** "Password" wizard page
WizardPassword=�p�X���[�h
PasswordLabel1=���̃C���X�g�[���v���O�����̓p�X���[�h�ɂ���ĕی삳��Ă��܂��B
PasswordLabel3=�p�X���[�h����͂��āu���ցv���N���b�N���Ă��������B�p�X���[�h�͑啶���Ə���������ʂ���܂��B
PasswordEditLabel=�p�X���[�h(&P):
IncorrectPassword=���͂��ꂽ�p�X���[�h������������܂���B������x���͂��Ȃ����Ă��������B

; *** "License Agreement" wizard page
WizardLicense=�g�p�����_�񏑂̓���
LicenseLabel=���s����O�Ɉȉ��̏d�v�ȏ������ǂ݂��������B
LicenseLabel3=�ȉ��̎g�p�����_�񏑂����ǂ݂��������B�C���X�g�[���𑱍s����ɂ͂��̌_�񏑂ɓ��ӂ���K�v������܂��B
LicenseAccepted=���ӂ���(&A)
LicenseNotAccepted=���ӂ��Ȃ�(&D)

; *** "Information" wizard pages
WizardInfoBefore=���
InfoBeforeLabel=���s����O�Ɉȉ��̏d�v�ȏ������ǂ݂��������B
InfoBeforeClickLabel=�Z�b�g�A�b�v�𑱍s����ɂ́u���ցv���N���b�N���Ă��������B
WizardInfoAfter=���
InfoAfterLabel=���s����O�Ɉȉ��̏d�v�ȏ������ǂ݂��������B
InfoAfterClickLabel=�Z�b�g�A�b�v�𑱍s����ɂ́u���ցv���N���b�N���Ă��������B

; *** "User Information" wizard page
WizardUserInfo=���[�U�[���
UserInfoDesc=���[�U�[������͂��Ă��������B
UserInfoName=���[�U�[��(&U):
UserInfoOrg=�g�D(&O):
UserInfoSerial=�V���A���ԍ�(&S):
UserInfoNameRequired=���[�U�[������͂��Ă��������B

; *** "Select Destination Directory" wizard page
WizardSelectDir=�C���X�g�[����̎w��
SelectDirDesc=[name] �̃C���X�g�[������w�肵�Ă��������B
SelectDirLabel3=�Z�b�g�A�b�v�́mname]���ȉ��̃t�H���_�ɃC���X�g�����܂��B
SelectDirBrowseLabel=���s����ɂ́u���ցv���N���b�N���Ă��������B�Ⴄ�t�H���_���w�肵������΁u�u���[�Y�v���N���b�N���Ă��������B
DiskSpaceMBLabel=���̃v���O�����͍Œ� [mb] MB�̃f�B�X�N�󂫗̈��K�v�Ƃ��܂��B
ToUNCPathname=�Z�b�g�A�b�v��UNC�t�H���_�ɃC���X�g�[�����邱�Ƃ��ł��܂���B�l�b�g���[�N�ɃC���X�g�[������ꍇ�̓l�b�g���[�N�h���C�u�Ɋ��蓖�ĂĂ��������B
InvalidPath=�h���C�u�������܂ފ��S�ȃp�X����͂��Ă��������B%n%n��FC:\APP%n%n�܂���UNC�`���̃p�X����͂��Ă��������B%n%n��F\\server\share
InvalidDrive=�w�肵���h���C�u�܂���UNC�p�X��������Ȃ����A�N�Z�X�ł��܂���B�ʂ̃p�X���w�肵�Ă��������B
DiskSpaceWarningTitle=�f�B�X�N�󂫗̈�̕s��
DiskSpaceWarning=�C���X�g�[���ɂ͍Œ� %1 KB�̃f�B�X�N�󂫗̈悪�K�v�ł����A�w�肳�ꂽ�h���C�u�ɂ� %2 KB�̋󂫗̈悵������܂���B%n%n���̂܂ܑ��s���܂����H
DirNameTooLong=�f�B���N�g�����A���̓p�X�����߂��܂��B
InvalidDirName=�t�H���_���������ł��B
BadDirName32=�ȉ��̕������܂ރt�H���_���͎w��ł��܂���B:%n%n%1
DirExistsTitle=�����̃t�H���_
DirExists=�t�H���_ %n%n%1%n%n�����ɑ��݂��܂��B���̂܂܂��̃t�H���_�փC���X�g�[�����܂����H
DirDoesntExistTitle=�V�����t�H���_
DirDoesntExist=�t�H���_ %n%n%1%n%n��������܂���B�V�����t�H���_���쐬���܂����H

; *** "Select Components" wizard page
WizardSelectComponents=�R���|�[�l���g�̑I��
SelectComponentsDesc=�C���X�g�[���R���|�[�l���g��I�����Ă��������B
SelectComponentsLabel2=�C���X�g�[������R���|�[�l���g��I�����Ă��������B�C���X�g�[������K�v�̂Ȃ��R���|�[�l���g�̓`�F�b�N���O���Ă��������B���s����ɂ́u���ցv���N���b�N���Ă��������B
FullInstallation=�t���C���X�g�[��
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=�R���p�N�g�C���X�g�[��
CustomInstallation=�J�X�^���C���X�g�[��
NoUninstallWarningTitle=�����̃R���|�[�l���g
NoUninstallWarning=�Z�b�g�A�b�v�͈ȉ��̃R���|�[�l���g�����ɃC���X�g�[������Ă��邱�Ƃ����o���܂����B%n%n%1%n%n�����̃R���|�[�l���g�̑I�����������Ă��A���C���X�g�[���͂���܂���B%n%n���̂܂ܑ��s���܂����H
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceMBLabel=���݂̑I���͍Œ� [mb] MB�̃f�B�X�N�󂫗̈��K�v�Ƃ��܂��B

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=�ǉ��^�X�N�̑I��
SelectTasksDesc=���s����ǉ��^�X�N��I�����Ă��������B
SelectTasksLabel2=[name] �C���X�g�[�����Ɏ��s����ǉ��^�X�N��I�����āA�u���ցv���N���b�N���Ă��������B

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=�v���O�����O���[�v�̎w��
SelectStartMenuFolderDesc=�v���O�����A�C�R�����쐬����ꏊ���w�肵�Ă��������B
SelectStartMenuFolderLabel3=�Z�b�g�A�b�v�͈ȉ��̃X�^�[�g���j���[�̃t�H���_�ɃV���[�g�J�b�g���쐬���܂��B
SelectStartMenuFolderBrowseLabel=���s����ɂ́u���ցv���N���b�N���Ă��������B�Ⴄ�t�H���_���w�肵������΁u�u���[�Y�v���N���b�N���Ă��������B
NoIconsCheck=�A�C�R�����쐬���Ȃ�(&D)
MustEnterGroupName=�O���[�v�����w�肵�Ă��������B
GroupNameTooLong=�t�H���_�����̓p�X�����߂��܂��B
InvalidGroupName=�O���[�v���������ł��B
BadGroupName=�ȉ��̕������܂ރO���[�v���͎w��ł��܂���B:%n%n%1
NoProgramGroupCheck2=�v���O�����O���[�v���쐬���Ȃ�(&D)

; *** "Ready to Install" wizard page
WizardReady=�C���X�g�[����������
ReadyLabel1=���g�p�̃R���s���[�^�� [name] ���C���X�g�[�����鏀�����ł��܂����B
ReadyLabel2a=�C���X�g�[���𑱍s����ɂ́u�C���X�g�[���v���A�ݒ�̊m�F��ύX���s���ɂ́u�߂�v���N���b�N���Ă��������B
ReadyLabel2b=�C���X�g�[���𑱍s����ɂ́u�C���X�g�[���v���N���b�N���Ă��������B
ReadyMemoUserInfo=���[�U�[���:
ReadyMemoDir=�C���X�g�[����:
ReadyMemoType=�Z�b�g�A�b�v�̎��:
ReadyMemoComponents=�I���R���|�[�l���g:
ReadyMemoGroup=�v���O�����O���[�v:
ReadyMemoTasks=�ǉ��^�X�N�ꗗ:

; *** "Preparing to Install" wizard page
WizardPreparing=�C���X�g�[��������
PreparingDesc=���g�p�̃R���s���[�^�� [name] ���C���X�g�[�����鏀�������Ă��܂��B
PreviousInstallNotCompleted=�O��s�����A�v���P�[�V�����̃C���X�g�[���܂��͍폜���������Ă��܂���B��������ɂ̓R���s���[�^���ċN������K�v������܂��B%n%n[name] �̃C���X�g�[�����������邽�߂ɂ́A�ċN����ɂ�����x�Z�b�g�A�b�v�����s���Ă��������B
CannotContinue=�Z�b�g�A�b�v�𑱍s�ł��܂���B�u�L�����Z���v���N���b�N���ăZ�b�g�A�b�v���I�����Ă��������B

; *** "Installing" wizard page
WizardInstalling=�C���X�g�[����
InstallingLabel=���g�p�̃R���s���[�^�� [name] ���C���X�g�[�����Ă��܂��B���΂炭���҂����������B

; *** "Setup Completed" wizard page
FinishedHeadingLabel=[name] �Z�b�g�A�b�v�E�B�U�[�h�̊���
FinishedLabelNoIcons=���g�p�̃R���s���[�^�� [name] ���Z�b�g�A�b�v����܂����B
FinishedLabel=���g�p�̃R���s���[�^�� [name] ���Z�b�g�A�b�v����܂����B�A�v���P�[�V���������s����ɂ̓C���X�g�[�����ꂽ�A�C�R����I�����Ă��������B
ClickFinish=�Z�b�g�A�b�v���I������ɂ́u�����v���N���b�N���Ă��������B
FinishedRestartLabel=[name] �̃C���X�g�[�����������邽�߂ɂ́A�R���s���[�^���ċN������K�v������܂��B�����ɍċN�����܂����H
FinishedRestartMessage=[name] �̃C���X�g�[�����������邽�߂ɂ́A�R���s���[�^���ċN������K�v������܂��B%n%n�����ɍċN�����܂����H
ShowReadmeCheck=README�t�@�C����\������B
YesRadio=�����ċN��(&Y)
NoRadio=��Ŏ蓮�ōċN��(&N)
; used for example as 'Run MyProg.exe'
RunEntryExec=%1 �̎��s
; used for example as 'View Readme.txt'
RunEntryShellExec=%1 �̕\��

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=�f�B�X�N�̑}��
SelectDiskLabel2=�f�B�X�N %1 ��}�����A�uOK�v���N���b�N���Ă��������B%n%n���̃f�B�X�N�̃t�@�C�������ɕ\������Ă���t�H���_�ȊO�̏ꏊ�ɂ���ꍇ�́A�������p�X����͂��邩�u�Q�Ɓv�{�^�����N���b�N���Ă��������B
PathLabel=�p�X(&P):
FileNotInDir2=�t�@�C�� %1 �� %2 �Ɍ�����܂���B�������f�B�X�N��}�����邩�A�ʂ̃t�H���_���w�肵�Ă��������B
SelectDirectoryLabel=���̃f�B�X�N�̂���ꏊ���w�肵�Ă��������B

; *** Installation phase messages
SetupAborted=�Z�b�g�A�b�v�͊������Ă��܂���B%n%n�����������Ă���A������x�Z�b�g�A�b�v�����s���Ă��������B
EntryAbortRetryIgnore=������x���Ȃ����ɂ́u�Ď��s�v�A�G���[�𖳎����đ��s����ɂ́u�����v�A�C���X�g�[���𒆎~����ɂ́u���~�v���N���b�N���Ă��������B

; *** Installation status messages
StatusCreateDirs=�t�H���_���쐬���Ă��܂�...
StatusExtractFiles=�t�@�C����W�J���Ă��܂�...
StatusCreateIcons=�V���|�g�J�b�g���쐬���Ă��܂�...
StatusCreateIniEntries=INI�t�@�C����ݒ肵�Ă��܂�...
StatusCreateRegistryEntries=���W�X�g����ݒ肵�Ă��܂�...
StatusRegisterFiles=�t�@�C����o�^���Ă��܂�...
StatusSavingUninstall=�A���C���X�g�[������ۑ����Ă��܂�...
StatusRunProgram=�C���X�g�[�����������Ă��܂�...
StatusRollback=�ύX�����ɖ߂��Ă��܂�...

; *** Misc. errors
ErrorInternal2=�����G���[: %1
ErrorFunctionFailedNoCode=%1 �G���[
ErrorFunctionFailed=%1 �G���[: �R�[�h %2
ErrorFunctionFailedWithMessage=%1 �G���[: �R�[�h %2.%n%3
ErrorExecutingProgram=�t�@�C�����s�G���[:%n%1

; *** Registry errors
ErrorRegOpenKey=���W�X�g���L�[�I�[�v���G���[:%n%1\%2
ErrorRegCreateKey=���W�X�g���L�[�쐬�G���[:%n%1\%2
ErrorRegWriteKey=���W�X�g���L�[�������݃G���[:%n%1\%2

; *** INI errors
ErrorIniEntry=INI�t�@�C���G���g���쐬�G���[: �t�@�C�� %1

; *** File copying errors
FileAbortRetryIgnore=������x���Ȃ����ɂ́u�Ď��s�v�A���̃t�@�C�����X�L�b�v���đ��s����ɂ́u�����v�i��������܂���j�A�C���X�g�[���𒆎~����ɂ́u���~�v���N���b�N���Ă��������B
FileAbortRetryIgnore2=������x���Ȃ����ɂ́u�Ď��s�v�A���̃t�@�C�����X�L�b�v���đ��s����ɂ́u�����v�i��������܂���j�A�C���X�g�[���𒆎~����ɂ́u���~�v���N���b�N���Ă��������B
SourceIsCorrupted=�R�s�[���̃t�@�C�������Ă��܂��B
SourceDoesntExist=�R�s�[���̃t�@�C�� %1 ��������܂���B
ExistingFileReadOnly=�����̃t�@�C���͓ǂݎ���p�ł��B%n%n�ǂݎ���p�������������Ă�����x���Ȃ����ɂ́u�Ď��s�v�A���̃t�@�C�����X�L�b�v���đ��s����ɂ́u�����v�A�C���X�g�[���𒆎~����ɂ́u���~�v���N���b�N���Ă��������B
ErrorReadingExistingDest=�����̃t�@�C����ǂݍ��ݒ��ɃG���[���������܂����B:
FileExists=�t�@�C���͊��ɑ��݂��܂��B%n%n�㏑�����܂����H
ExistingFileNewer=�C���X�g�[�����悤�Ƃ��Ă���t�@�C�������V�����t�@�C�������݂��܂��B�����̃t�@�C�����c�����Ƃ������߂��܂��B%n%n�����̃t�@�C�����c���܂����B
ErrorChangingAttr=�����t�@�C���̑�����ύX���ɃG���[���������܂����B:
ErrorCreatingTemp=�R�s�[��̃t�H���_�Ƀt�@�C�����쐬���ɃG���[���������܂����B:
ErrorReadingSource=�R�s�[���̃t�@�C����ǂݍ��ݒ��ɃG���[���������܂����B:
ErrorCopying=�t�@�C�����R�s�[���ɃG���[���������܂����B:
ErrorReplacingExistingFile=�����t�@�C����u���������ɃG���[���������܂����B:
ErrorRestartReplace=�u�������ĊJ���ɃG���[���������܂����B:
ErrorRenamingTemp=�R�s�[��t�H���_�̃t�@�C������ύX���ɃG���[���������܂����B:
ErrorRegisterServer=DLL/OCX�̓o�^�Ɏ��s���܂����B: %1
ErrorRegisterServerMissingExport=DllRegisterServer�G�N�X�|�[�g��������܂���B
ErrorRegisterTypeLib=�^�C�v���C�u�����ւ̓o�^�Ɏ��s���܂����B: %1

; *** Post-installation errors
ErrorOpeningReadme=README�t�@�C���̃I�[�v���Ɏ��s���܂����B
ErrorRestartingComputer=�R���s���[�^�̍ċN���Ɏ��s���܂����B�蓮�ōċN�����Ă��������B

; *** Uninstaller messages
UninstallNotFound=�t�@�C�� %1 ��������܂���B�A���C���X�g�[�������s�ł��܂���B
UninstallOpenError=�t�@�C�� %1 ���J���邱�Ƃ��ł��܂���B�A���C���X�g�[�������s�ł��܂���B
UninstallUnsupportedVer=�A���C���X�g�[�����O�t�@�C�� %1 �́A���̃o�[�W�����̃A���C���X�g�[���v���O�������F���ł��Ȃ��`���ł��B�A���C���X�g�[�������s�ł��܂���B
UninstallUnknownEntry=�A���C���X�g�[�����O�ɕs���̃G���g�� %1 ��������܂����B
ConfirmUninstall=%1 �Ƃ��̊֘A�R���|�[�l���g�����ׂč폜���܂��B��낵���ł����H
OnlyAdminCanUninstall=�A���C���X�g�[�����邽�߂ɂ͊Ǘ��Ҍ������K�v�ł��B
UninstallStatusLabel=���g�p�̃R���s���[�^���� %1 ���폜���Ă��܂��B���΂炭���҂����������B
UninstalledAll=%1 �͂��g�p�̃R���s���[�^���琳��ɍ폜����܂����B
UninstalledMost=%1 �̃A���C���X�g�[�����������܂����B%n%n�������̍��ڂ��폜�ł��܂���ł����B�蓮�ō폜���Ă��������B
UninstalledAndNeedsRestart=[name] �̍폜���������邽�߂ɂ́A�R���s���[�^���ċN������K�v������܂��B�����ɍċN�����܂����H
UninstallDataCorrupted=�t�@�C�� %1 �����Ă��܂��B�A���C���X�g�[�������s�ł��܂���B

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=���L�t�@�C���̍폜
ConfirmDeleteSharedFile2=�V�X�e����ŁA���̋��L�t�@�C���͂ǂ̃v���O�����ł��g�p����Ă��܂���B���̋��L�t�@�C�����폜���܂����H%n%n���̃v���O�������܂����̃t�@�C�����g�p����ꍇ�A�폜����ƃv���O���������삵�Ȃ��Ȃ鋰�ꂪ����܂��B���܂�m���łȂ��ꍇ�́u�������v��I�����Ă��������B�V�X�e���Ƀt�@�C�����c���Ă����������N�������Ƃ͂���܂���B
SharedFileNameLabel=�t�@�C����:
SharedFileLocationLabel=�ꏊ:
WizardUninstalling=�A���C���X�g�[����
StatusUninstalling=%1 ���A���C���X�g�[�����Ă��܂�...

; The custom messages below aren't used by Setup itself, but if you make
; use of them in your scripts, you'll want to translate them.

[CustomMessages]

NameAndVersion=%1�o�[�V����%2
AdditionalIcons=�t�����A�C�R���F
CreateDesktopIcon=�f�X�N�g�b�v�A�C�R�����쐬���܂�(&d)
CreateQuickLaunchIcon=�N�E�B�b�N���E���V���A�C�R�����쐬���܂�(&Q)
ProgramOnTheWeb=�E�G�u�� %1
UninstallProgram=%1 ���A���C���X�g������
LaunchProgram=%1�����s����
AssocFileExtension=%2 �t�@�C���̃G�O�Y�e���V������ %1������(&A)
AssocingFileExtension=%2 �t�@�C���̃G�O�Y�e���V������ %1�������f���顡�

