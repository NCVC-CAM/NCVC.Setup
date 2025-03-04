[Setup]
OutputBaseFilename=ncvc415a_install64
AppName=NCVC
AppVerName=NCVC Version 4.15a (64bit Ver)
AppVersion=4.15a
VersionInfoVersion=4.1.5.1
VersionInfoDescription=NCVC setup program
AppCopyright=MNCT-S K.Magara
AppPublisher=MNCT-S
AppPublisherURL=https://k-magara.github.io/
AppSupportURL=https://k-magara.github.io/
AppUpdatesURL=https://k-magara.github.io/
DefaultDirName={pf}\NCVC
DefaultGroupName=NCVC
LicenseFile=license.txt
AllowNoIcons=yes
UninstallDisplayIcon={app}\NCVC.exe
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64

[Components]
Name: "Main"; Description: "NCVC 最小構成"; Types: full compact custom; Flags: fixed
Name: "Manual"; Description: "NCVC解説書"; Types: full;
Name: "Samples"; Description: "サンプルデータ"; Types: full;
Name: "Texture"; Description: "テクスチャ用画像データ"; Types: full;
Name: "ReadJW"; Description: "アドイン ReadJW"; Types: full;
Name: "ReadCSV"; Description: "アドイン ReadCSV"; Types: full;
Name: "SendNCD"; Description: "アドイン SendNCD"; Types: full;
Name: "SolveTSP"; Description: "アドイン SolveTSP"; Types: full;
Name: "Scriptorium"; Description: "スクリプトラッパー"; Types: full;
Name: "SampleScripts"; Description: "サンプルスクリプト"; Types: full;

[Tasks]
Name: "desktopicon"; Description: "デスクトップにショートカットの作成"; GroupDescription: "アイコンの追加:"; Flags: unchecked

[Files]
Source: "vc_redist.x64.exe"; Flags: dontcopy
Source: "ncvc\x64\NCVC.exe"; DestDir: "{app}"; Components: Main; Flags: ignoreversion
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
Source: "ncvc\x64\ReadJW\*"; DestDir: "{app}"; Components: ReadJW; Flags: ignoreversion
Source: "ncvc\x64\ReadCSV\*"; DestDir: "{app}"; Components: ReadCSV; Flags: ignoreversion
Source: "ncvc\x64\SendNCD\*"; DestDir: "{app}"; Components: SendNCD; Flags: ignoreversion
Source: "ncvc\x64\SolveTSP\*"; DestDir: "{app}"; Components: SolveTSP; Flags: ignoreversion
Source: "ncvc\x64\Scriptorium\*"; DestDir: "{app}"; Components: Scriptorium; Flags: ignoreversion
Source: "ncvc\scripts\*"; DestDir: "{app}\scripts"; Components: SampleScripts; Flags: recursesubdirs

[Code]
function IsMFCregistry: boolean;
var
  DisplayName: String;
begin
  if RegQueryStringValue(HKEY_CLASSES_ROOT, 'Installer\Dependencies\Microsoft.VS.VC_RuntimeMinimumVSU_amd64,v14', 'DisplayName', DisplayName) then begin
    if Pos('2022 X64', DisplayName) > 0 then begin
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
      if MsgBox('NCVC実行に必要なMFCﾗﾝﾀｲﾑをインストールしますか？', mbConfirmation, MB_YESNO) = IDYES then begin
        ExtractTemporaryFile('vc_redist.x64.exe');
        Exec(ExpandConstant('{tmp}\vc_redist.x64.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
      end;
    end;
  end;
end;

[Icons]
Name: "{group}\NCVC"; Filename: "{app}\NCVC.exe"
Name: "{group}\NCVC解説書"; Filename: "{app}\NCVC.pdf"
Name: "{group}\自動輪郭処理解説書"; Filename: "{app}\NCVC2.pdf"
Name: "{group}\旋盤データ生成解説書"; Filename: "{app}\NCVC3.pdf"
Name: "{group}\ワイヤ放電加工機データ生成解説書"; Filename: "{app}\NCVC4.pdf"
Name: "{group}\CADﾃﾞｰﾀの統合解説書"; Filename: "{app}\NCVC5.pdf"
Name: "{group}\複数のワーク座標原点を処理する手順書"; Filename: "{app}\NCVC6.pdf"
Name: "{group}\NURBS曲面の切削データ生成解説書"; Filename: "{app}\NCVC7.pdf"
Name: "{group}\NCVCのアンインストール"; Filename: "{uninstallexe}"
Name: "{userdesktop}\NCVC"; Filename: "{app}\NCVC.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\NCVC.exe"; Description: "NCVCを起動"; Flags: nowait postinstall runmaximized skipifsilent

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
DialogFontName=ＭＳ Ｐゴシック
DialogFontSize=9
TitleFontName=ＭＳ Ｐゴシック
TitleFontSize=29
WelcomeFontName=ＭＳ Ｐゴシック
WelcomeFontSize=12
CopyrightFontName=ＭＳ Ｐゴシック
CopyrightFontSize=8

[Messages]

; *** Application titles
SetupAppTitle=セットアップ
SetupWindowTitle=%1 セットアップ
UninstallAppTitle=アンインストール
UninstallAppFullTitle=%1 アンインストール

; *** Misc. common
InformationTitle=情報
ConfirmTitle=確認
ErrorTitle=エラー

; *** SetupLdr messages
SetupLdrStartupMessage=%1 をインストールします。続行しますか？
LdrCannotCreateTemp=一時ファイルを作成できません。セットアップを中止します。
LdrCannotExecTemp=一時フォルダのファイルを実行できません。セットアップを中止します。

; *** Startup error messages
LastErrorMessage=%1.%n%nエラー %2: %3
SetupFileMissing=ファイル %1 が見つかりません。問題を解決するか新しいセットアッププログラムを入手してください。
SetupFileCorrupt=セットアップファイルが壊れています。新しいセットアッププログラムを入手してください。
SetupFileCorruptOrWrongVer=セットアップファイルが壊れているか、このバージョンのセットアップと互換性がありません。問題を解決するか新しいセットアッププログラムを入手してください。
NotOnThisPlatform=このプログラムは %1 では動作しません。
OnlyOnThisPlatform=このプログラムの実行には %1 が必要です。
WinVersionTooLowError=このプログラムの実行には %1 %2 以降が必要です。
WinVersionTooHighError=このプログラムは %1 %2 以降では動作しません。
AdminPrivilegesRequired=このプログラムをインストールするためには管理者としてログインする必要があります。
PowerUserPrivilegesRequired=このプログラムをインストールするためには管理者またはパワーユーザーとしてログインする必要があります。
SetupAppRunningError=セットアップは実行中の %1 を検出しました。%n%n開いているアプリケーションをすべて閉じてから「OK」をクリックしてください。「キャンセル」をクリックすると、セットアップを終了します。
UninstallAppRunningError=アンインストールは実行中の %1 を検出しました。%n%n開いているアプリケーションをすべて閉じてから「OK」をクリックしてください。「キャンセル」をクリックすると、セットアップを終了します。

; *** Misc. errors
ErrorCreatingDir=フォルダ %1 を作成中にエラーが発生しました。
ErrorTooManyFilesInDir=フォルダ %1 にファイルを作成中にエラーが発生しました。ファイルの数が多すぎます。

; *** Setup common messages
ExitSetupTitle=セットアップ終了
ExitSetupMessage=セットアップ作業は完了していません。ここでセットアップを終了するとプログラムはインストールされません。%n%n改めてインストールする場合は、もう一度セットアップを実行してください。%n%nセットアップを終了しますか？
AboutSetupMenuItem=セットアップについて(&A)...
AboutSetupTitle=セットアップについて
AboutSetupMessage=%1 %2%n%3%n%n%1 ホームページ:%n%4
AboutSetupNote=

; *** Buttons
ButtonBack=< 戻る(&B)
ButtonNext=次へ(&N) >
ButtonInstall=インストール(&I)
ButtonOK=OK
ButtonCancel=キャンセル
ButtonYes=はい(&Y)
ButtonYesToAll=すべてはい(&A)
ButtonNo=いいえ(&N)
ButtonNoToAll=すべていいえ(&O)
ButtonFinish=完了(&F)
ButtonBrowse=参照(&B)...
ButtonWizardBrowse=参照(&r)
ButtonNewFolder=新しいフォルダ(&M)

; *** "Select Language" dialog messages
SelectLanguageTitle=セトアプの言葉を選んで
SelectLanguageLabel=インストル中利用言葉を撰びます:

; *** Common wizard text
ClickNext=続行するには「次へ」、セットアップを終了するには「キャンセル」をクリックしてください。
BeveledLabel=
BrowseDialogTitle=フォルダ参照
BrowseDialogLabel=リストからフォルダを選びOKを押してください。
NewFolderName=新しいフォルダ

; *** "Welcome" wizard page
WelcomeLabel1=[name] セットアップウィザードの開始
WelcomeLabel2=このプログラムはご使用のコンピュータへ [name/ver] をインストールします。%n%n続行する前に他のアプリケーションをすべて終了してください。

; *** "Password" wizard page
WizardPassword=パスワード
PasswordLabel1=このインストールプログラムはパスワードによって保護されています。
PasswordLabel3=パスワードを入力して「次へ」をクリックしてください。パスワードは大文字と小文字が区別されます。
PasswordEditLabel=パスワード(&P):
IncorrectPassword=入力されたパスワードが正しくありません。もう一度入力しなおしてください。

; *** "License Agreement" wizard page
WizardLicense=使用許諾契約書の同意
LicenseLabel=続行する前に以下の重要な情報をお読みください。
LicenseLabel3=以下の使用許諾契約書をお読みください。インストールを続行するにはこの契約書に同意する必要があります。
LicenseAccepted=同意する(&A)
LicenseNotAccepted=同意しない(&D)

; *** "Information" wizard pages
WizardInfoBefore=情報
InfoBeforeLabel=続行する前に以下の重要な情報をお読みください。
InfoBeforeClickLabel=セットアップを続行するには「次へ」をクリックしてください。
WizardInfoAfter=情報
InfoAfterLabel=続行する前に以下の重要な情報をお読みください。
InfoAfterClickLabel=セットアップを続行するには「次へ」をクリックしてください。

; *** "User Information" wizard page
WizardUserInfo=ユーザー情報
UserInfoDesc=ユーザー情報を入力してください。
UserInfoName=ユーザー名(&U):
UserInfoOrg=組織(&O):
UserInfoSerial=シリアル番号(&S):
UserInfoNameRequired=ユーザー名を入力してください。

; *** "Select Destination Directory" wizard page
WizardSelectDir=インストール先の指定
SelectDirDesc=[name] のインストール先を指定してください。
SelectDirLabel3=セットアップは［name]を以下のフォルダにインストルします。
SelectDirBrowseLabel=続行するには「次へ」をクリックしてください。違うフォルダを指定したければ「ブローズ」をクリックしてください。
DiskSpaceMBLabel=このプログラムは最低 [mb] MBのディスク空き領域を必要とします。
ToUNCPathname=セットアップはUNCフォルダにインストールすることができません。ネットワークにインストールする場合はネットワークドライブに割り当ててください。
InvalidPath=ドライブ文字を含む完全なパスを入力してください。%n%n例：C:\APP%n%nまたはUNC形式のパスを入力してください。%n%n例：\\server\share
InvalidDrive=指定したドライブまたはUNCパスが見つからないかアクセスできません。別のパスを指定してください。
DiskSpaceWarningTitle=ディスク空き領域の不足
DiskSpaceWarning=インストールには最低 %1 KBのディスク空き領域が必要ですが、指定されたドライブには %2 KBの空き領域しかありません。%n%nこのまま続行しますか？
DirNameTooLong=ディレクトリ名、又はパスが長過ぎます。
InvalidDirName=フォルダ名が無効です。
BadDirName32=以下の文字を含むフォルダ名は指定できません。:%n%n%1
DirExistsTitle=既存のフォルダ
DirExists=フォルダ %n%n%1%n%nが既に存在します。このままこのフォルダへインストールしますか？
DirDoesntExistTitle=新しいフォルダ
DirDoesntExist=フォルダ %n%n%1%n%nが見つかりません。新しいフォルダを作成しますか？

; *** "Select Components" wizard page
WizardSelectComponents=コンポーネントの選択
SelectComponentsDesc=インストールコンポーネントを選択してください。
SelectComponentsLabel2=インストールするコンポーネントを選択してください。インストールする必要のないコンポーネントはチェックを外してください。続行するには「次へ」をクリックしてください。
FullInstallation=フルインストール
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=コンパクトインストール
CustomInstallation=カスタムインストール
NoUninstallWarningTitle=既存のコンポーネント
NoUninstallWarning=セットアップは以下のコンポーネントが既にインストールされていることを検出しました。%n%n%1%n%nこれらのコンポーネントの選択を解除してもアンインストールはされません。%n%nこのまま続行しますか？
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceMBLabel=現在の選択は最低 [mb] MBのディスク空き領域を必要とします。

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=追加タスクの選択
SelectTasksDesc=実行する追加タスクを選択してください。
SelectTasksLabel2=[name] インストール時に実行する追加タスクを選択して、「次へ」をクリックしてください。

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=プログラムグループの指定
SelectStartMenuFolderDesc=プログラムアイコンを作成する場所を指定してください。
SelectStartMenuFolderLabel3=セットアップは以下のスタートメニューのフォルダにショートカットを作成します。
SelectStartMenuFolderBrowseLabel=続行するには「次へ」をクリックしてください。違うフォルダを指定したければ「ブローズ」をクリックしてください。
NoIconsCheck=アイコンを作成しない(&D)
MustEnterGroupName=グループ名を指定してください。
GroupNameTooLong=フォルダ名又はパスが長過ぎます。
InvalidGroupName=グループ名が無効です。
BadGroupName=以下の文字を含むグループ名は指定できません。:%n%n%1
NoProgramGroupCheck2=プログラムグループを作成しない(&D)

; *** "Ready to Install" wizard page
WizardReady=インストール準備完了
ReadyLabel1=ご使用のコンピュータへ [name] をインストールする準備ができました。
ReadyLabel2a=インストールを続行するには「インストール」を、設定の確認や変更を行うには「戻る」をクリックしてください。
ReadyLabel2b=インストールを続行するには「インストール」をクリックしてください。
ReadyMemoUserInfo=ユーザー情報:
ReadyMemoDir=インストール先:
ReadyMemoType=セットアップの種類:
ReadyMemoComponents=選択コンポーネント:
ReadyMemoGroup=プログラムグループ:
ReadyMemoTasks=追加タスク一覧:

; *** "Preparing to Install" wizard page
WizardPreparing=インストール準備中
PreparingDesc=ご使用のコンピュータへ [name] をインストールする準備をしています。
PreviousInstallNotCompleted=前回行ったアプリケーションのインストールまたは削除が完了していません。完了するにはコンピュータを再起動する必要があります。%n%n[name] のインストールを完了するためには、再起動後にもう一度セットアップを実行してください。
CannotContinue=セットアップを続行できません。「キャンセル」をクリックしてセットアップを終了してください。

; *** "Installing" wizard page
WizardInstalling=インストール状況
InstallingLabel=ご使用のコンピュータに [name] をインストールしています。しばらくお待ちください。

; *** "Setup Completed" wizard page
FinishedHeadingLabel=[name] セットアップウィザードの完了
FinishedLabelNoIcons=ご使用のコンピュータに [name] がセットアップされました。
FinishedLabel=ご使用のコンピュータに [name] がセットアップされました。アプリケーションを実行するにはインストールされたアイコンを選択してください。
ClickFinish=セットアップを終了するには「完了」をクリックしてください。
FinishedRestartLabel=[name] のインストールを完了するためには、コンピュータを再起動する必要があります。すぐに再起動しますか？
FinishedRestartMessage=[name] のインストールを完了するためには、コンピュータを再起動する必要があります。%n%nすぐに再起動しますか？
ShowReadmeCheck=READMEファイルを表示する。
YesRadio=すぐ再起動(&Y)
NoRadio=後で手動で再起動(&N)
; used for example as 'Run MyProg.exe'
RunEntryExec=%1 の実行
; used for example as 'View Readme.txt'
RunEntryShellExec=%1 の表示

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=ディスクの挿入
SelectDiskLabel2=ディスク %1 を挿入し、「OK」をクリックしてください。%n%nこのディスクのファイルが下に表示されているフォルダ以外の場所にある場合は、正しいパスを入力するか「参照」ボタンをクリックしてください。
PathLabel=パス(&P):
FileNotInDir2=ファイル %1 が %2 に見つかりません。正しいディスクを挿入するか、別のフォルダを指定してください。
SelectDirectoryLabel=次のディスクのある場所を指定してください。

; *** Installation phase messages
SetupAborted=セットアップは完了していません。%n%n問題を解決してから、もう一度セットアップを実行してください。
EntryAbortRetryIgnore=もう一度やりなおすには「再試行」、エラーを無視して続行するには「無視」、インストールを中止するには「中止」をクリックしてください。

; *** Installation status messages
StatusCreateDirs=フォルダを作成しています...
StatusExtractFiles=ファイルを展開しています...
StatusCreateIcons=ショ−トカットを作成しています...
StatusCreateIniEntries=INIファイルを設定しています...
StatusCreateRegistryEntries=レジストリを設定しています...
StatusRegisterFiles=ファイルを登録しています...
StatusSavingUninstall=アンインストール情報を保存しています...
StatusRunProgram=インストールを完了しています...
StatusRollback=変更を元に戻しています...

; *** Misc. errors
ErrorInternal2=内部エラー: %1
ErrorFunctionFailedNoCode=%1 エラー
ErrorFunctionFailed=%1 エラー: コード %2
ErrorFunctionFailedWithMessage=%1 エラー: コード %2.%n%3
ErrorExecutingProgram=ファイル実行エラー:%n%1

; *** Registry errors
ErrorRegOpenKey=レジストリキーオープンエラー:%n%1\%2
ErrorRegCreateKey=レジストリキー作成エラー:%n%1\%2
ErrorRegWriteKey=レジストリキー書き込みエラー:%n%1\%2

; *** INI errors
ErrorIniEntry=INIファイルエントリ作成エラー: ファイル %1

; *** File copying errors
FileAbortRetryIgnore=もう一度やりなおすには「再試行」、このファイルをスキップして続行するには「無視」（推奨されません）、インストールを中止するには「中止」をクリックしてください。
FileAbortRetryIgnore2=もう一度やりなおすには「再試行」、このファイルをスキップして続行するには「無視」（推奨されません）、インストールを中止するには「中止」をクリックしてください。
SourceIsCorrupted=コピー元のファイルが壊れています。
SourceDoesntExist=コピー元のファイル %1 が見つかりません。
ExistingFileReadOnly=既存のファイルは読み取り専用です。%n%n読み取り専用属性を解除してもう一度やりなおすには「再試行」、このファイルをスキップして続行するには「無視」、インストールを中止するには「中止」をクリックしてください。
ErrorReadingExistingDest=既存のファイルを読み込み中にエラーが発生しました。:
FileExists=ファイルは既に存在します。%n%n上書きしますか？
ExistingFileNewer=インストールしようとしているファイルよりも新しいファイルが存在します。既存のファイルを残すことをお奨めします。%n%n既存のファイルを残しますか。
ErrorChangingAttr=既存ファイルの属性を変更中にエラーが発生しました。:
ErrorCreatingTemp=コピー先のフォルダにファイルを作成中にエラーが発生しました。:
ErrorReadingSource=コピー元のファイルを読み込み中にエラーが発生しました。:
ErrorCopying=ファイルをコピー中にエラーが発生しました。:
ErrorReplacingExistingFile=既存ファイルを置き換え中にエラーが発生しました。:
ErrorRestartReplace=置き換え再開中にエラーが発生しました。:
ErrorRenamingTemp=コピー先フォルダのファイル名を変更中にエラーが発生しました。:
ErrorRegisterServer=DLL/OCXの登録に失敗しました。: %1
ErrorRegisterServerMissingExport=DllRegisterServerエクスポートが見つかりません。
ErrorRegisterTypeLib=タイプライブラリへの登録に失敗しました。: %1

; *** Post-installation errors
ErrorOpeningReadme=READMEファイルのオープンに失敗しました。
ErrorRestartingComputer=コンピュータの再起動に失敗しました。手動で再起動してください。

; *** Uninstaller messages
UninstallNotFound=ファイル %1 が見つかりません。アンインストールを実行できません。
UninstallOpenError=ファイル %1 を開けることができません。アンインストールを実行できません。
UninstallUnsupportedVer=アンインストールログファイル %1 は、このバージョンのアンインストールプログラムが認識できない形式です。アンインストールを実行できません。
UninstallUnknownEntry=アンインストールログに不明のエントリ %1 が見つかりました。
ConfirmUninstall=%1 とその関連コンポーネントをすべて削除します。よろしいですか？
OnlyAdminCanUninstall=アンインストールするためには管理者権限が必要です。
UninstallStatusLabel=ご使用のコンピュータから %1 を削除しています。しばらくお待ちください。
UninstalledAll=%1 はご使用のコンピュータから正常に削除されました。
UninstalledMost=%1 のアンインストールが完了しました。%n%nいくつかの項目が削除できませんでした。手動で削除してください。
UninstalledAndNeedsRestart=[name] の削除を完了するためには、コンピュータを再起動する必要があります。すぐに再起動しますか？
UninstallDataCorrupted=ファイル %1 が壊れています。アンインストールを実行できません。

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=共有ファイルの削除
ConfirmDeleteSharedFile2=システム上で、次の共有ファイルはどのプログラムでも使用されていません。この共有ファイルを削除しますか？%n%n他のプログラムがまだこのファイルを使用する場合、削除するとプログラムが動作しなくなる恐れがあります。あまり確実でない場合は「いいえ」を選択してください。システムにファイルを残しても問題を引き起こすことはありません。
SharedFileNameLabel=ファイル名:
SharedFileLocationLabel=場所:
WizardUninstalling=アンインストール状況
StatusUninstalling=%1 をアンインストールしています...

; The custom messages below aren't used by Setup itself, but if you make
; use of them in your scripts, you'll want to translate them.

[CustomMessages]

NameAndVersion=%1バーション%2
AdditionalIcons=付加もアイコン：
CreateDesktopIcon=デスクトップアイコンを作成します(&d)
CreateQuickLaunchIcon=クウィックラウンシュアイコンを作成します(&Q)
ProgramOnTheWeb=ウエブで %1
UninstallProgram=%1 をアンインストルする
LaunchProgram=%1を実行する
AssocFileExtension=%2 ファイルのエグズテンションに %1を因む(&A)
AssocingFileExtension=%2 ファイルのエグズテンションに %1を因ンデいる｡｡｡

