!addincludedir "include"
Var MSG     ;MSG�������붨�壬��������ǰ�棬����WndProc::onCallback���������������Ҫ�����Ϣ����,���ڼ�¼��Ϣ��Ϣ
Var Dialog  ;Dialog����Ҳ��Ҫ���壬��������NSISĬ�ϵĶԻ���������ڱ��洰���пؼ�����Ϣ
Var BGImage  ;������ͼ
Var ImageHandle
Var BGImage1  ;������ͼ
Var ImageHandle1
Var Txt_Browser
Var btn_Browser
Var btn_in
Var btn_ins
Var btn_back
Var btn_Close
Var btn_instetup
Var btn_instend
Var btn_instend1
Var btn_Licenseback
Var Txt_Xllicense
Var Rtf_license
Var Txt_ji
Var Ckbox0
Var Ckbox1
Var Ckbox1_State
Var Ckbox2
Var Ckbox2_State
Var ckbox4
;---------------------------ȫ�ֱ���ű�Ԥ����ĳ���-----------------------------------------------------
!define app_n "GG" ;����
!define app_v "17.04.09.12" ;�汾
!define app_c "godgou" ;��˾
!define reg_dir "Software\godgou\GG"
;---------------------------�������ѹ�����ͣ�Ҳ����ͨ���������ű����ƣ�------------------------------------
SetCompressor lzma
SetCompress force
;��װ������ʾ����
Name "${app_n}"
;��װ��������ļ���
OutFile "${app_n} ${app_v}.exe"
!define DIR "$PROGRAMFILES\godgou\GG" ;�������ﶨ�尲װ·��
InstallDir "${DIR}"
InstallDirRegKey HKCU "${reg_dir}" "exedir"
ShowInstDetails nevershow ;�����Ƿ���ʾ��װ��ϸ��Ϣ��
ShowUnInstDetails nevershow ;�����Ƿ���ʾɾ����ϸ��Ϣ��
;��װͼ���·������
!define MUI_ICON "Icon\gg.ico"
;ж��ͼ���·������
!define MUI_UNICON "Icon\Uninstall.ico"
;ʹ�õ�UI
!define MUI_UI "UI\mod.exe"
;ʹ��ReserveFile�Ǽӿ찲װ��չ���ٶȣ������뿴����
ReserveFile "images\bg.bmp"
ReserveFile "images\bg2.bmp"
ReserveFile "images\bg3.bmp"
ReserveFile "images\browse.bmp"
ReserveFile "images\close.bmp"
ReserveFile "images\custom.bmp"
ReserveFile "images\empty_bg.bmp"
ReserveFile "images\express.bmp"
ReserveFile "images\finish.bmp"
ReserveFile "images\full_bg.bmp"
ReserveFile "images\onekey.bmp"
ReserveFile "images\strongbtn.bmp"
ReserveFile "images\weakbtn.bmp"
;��չ����
ReserveFile "images\Slides.dat"
ReserveFile "images\InstallingBG01.png"
ReserveFile "images\InstallingBG02.png"
ReserveFile "images\InstallingBG03.png"
ReserveFile "images\InstallingBG04.png"
;DLL
ReserveFile `${NSISDIR}\Plugins\nsDialogs.dll`
ReserveFile `${NSISDIR}\Plugins\nsWindows.dll`
ReserveFile `${NSISDIR}\Plugins\SkinBtn.dll`
ReserveFile `${NSISDIR}\Plugins\SkinProgress.dll`
ReserveFile `${NSISDIR}\Plugins\System.dll`
ReserveFile `${NSISDIR}\Plugins\WndProc.dll`
ReserveFile `${NSISDIR}\Plugins\nsisSlideshow.dll`
ReserveFile `${NSISDIR}\Plugins\FindProcDLL.dll`
; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT myGuiInit
!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGuiInit
;�Զ���ҳ��
Page custom Page.1 Page.1leave
; ��װ����ҳ��
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
Page custom Page.3
;�����Ҫɾ���������Զ���ת������
Page custom Page.4
; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"
;���ɵ�EXE�������İ汾��Ϣ�������ʾ����˴��������!insertmacro MUI_LANGUAGE "SimpChinese"����
VIProductVersion "${app_v}" ;����汾��Ϣ
VIAddVersionKey /LANG=2052 "ProductName" "${app_n}"  ;��Ʒ����
VIAddVersionKey /LANG=2052 "CompanyName" "godgou" ;��˾
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) godgou" ;��Ȩ
VIAddVersionKey /LANG=2052 "FileDescription" "GG��װ����" ;��Ʒ����
VIAddVersionKey /LANG=2052 "FileVersion" "${app_v}" ;�ļ��汾��Ϣ
;------------------------------------------------------MUI �ִ����涨���Լ���������------------------------

Function .onInit
    InitPluginsDir ;��ʼ�����
    StrCpy $Ckbox1_State ${BST_CHECKED}
    StrCpy $Ckbox2_State ${BST_CHECKED}
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;��һ�󱳾�
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;�ڶ��󱳾�
    File `/oname=$PLUGINSDIR\bg3.bmp` `images\bg3.bmp` ;���ҳ����
    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;���ٰ�װ
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;�Զ��尲װ
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;�����ť
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;������װ
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;��װ���
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;����
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;��������
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;�ر�
		;������Ƥ��
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;Э��
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
		;��ʼ��
    SkinBtn::Init "$PLUGINSDIR\btn_onekey.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_custom.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_browse.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_strongbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_finish.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_weakbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_express.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_Close.bmp"
FunctionEnd
Function myGuiInit
	;����ظ�����
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "GG") i .r1 ?e'
  Pop $R1		;$$$$$��װ�����Ѿ�����
  StrCmp $R1 0 +3
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "godgou��װ�����Ѿ������С�"
  Abort  
    ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
    ${NSW_SetWindowSize} $HWNDPARENT 788 538 ;�ı��������С589 439
    System::Call User32::GetDesktopWindow()i.R0
    ;Բ��
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd
;�����ޱ߿��ƶ�
Function onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd
Function Page.1
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1990
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1991
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1992
    ShowWindow $0 ${SW_HIDE}
    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��
    ${NSW_SetWindowSize} $0 788 538 ;�ı�Page��С
    ;��ȡRTF���ı���
		nsDialogs::CreateControl "RichEdit20A" \
    ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} \
		${WS_EX_STATICEDGE}  1 1 784 480 ''
    Pop $rtf_License
		${LoadRTF} '$PLUGINSDIR\license.rtf' $rtf_License
    ShowWindow $rtf_License ${SW_HIDE}
    ;Э��ȷ����ť
    ${NSD_CreateButton} 360 500 55 30 "ȷ��"
    Pop $btn_Licenseback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Licenseback
    GetFunctionAddress $3 Licenseback
    SkinBtn::onClick $btn_Licenseback $3
    SetCtlColors $btn_Licenseback 7F7F7F transparent
    ShowWindow $btn_Licenseback ${SW_HIDE}   
    ;�Զ��尲װ��ť
    ${NSD_CreateButton} 650 500 98 17 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 onClickint
    SkinBtn::onClick $btn_ins $3   
    ;���ٰ�װ
    ${NSD_CreateButton} 260 382 262 64 ""
    Pop $btn_in
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_onekey.bmp $btn_in
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_in $3
    ;�رհ�ť
    ${NSD_CreateButton} 750 13 24 20 ""
    Pop $btn_Close
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_Close.bmp $btn_Close
    GetFunctionAddress $3 ABORT
    SkinBtn::onClick $btn_Close $3
    ;������װ
    ${NSD_CreateButton} 550 500 82 26 "������װ"
    Pop $btn_instetup
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_instetup
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_instetup $3
    SetCtlColors $btn_instetup FFFFFF transparent
    ShowWindow $btn_instetup ${SW_HIDE}
    ;����
    ${NSD_CreateButton} 674 500 56 26 "����"
    Pop $btn_back
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_back
    GetFunctionAddress $3 onClickBack
    SkinBtn::onClick $btn_back $3
    SetCtlColors $btn_back 7F7F7F transparent
    ShowWindow $btn_back ${SW_HIDE}  
#------------------------------------------
#���Э��
#------------------------------------------
    ${NSD_CreateCheckbox} 40 500 100 20 "ͬ��GG��"
    Pop $Ckbox0
    SetCtlColors $Ckbox0 "" FFFFFF
    ${NSD_Check} $Ckbox0
    ${NSD_OnClick} $Ckbox0 Chklicense
    ${NSD_CreateLink} 140 502 100 20 "�û����Э��"
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 5ba900 FFFFFF
    ${NSD_OnClick} $Txt_Xllicense xllicense
#------------------------------------------
#��ѡ��1
#------------------------------------------
    ${NSD_CreateCheckbox} 50 500 125 20 "��������ͼ��"
    Pop $Ckbox1
    SetCtlColors $Ckbox1 ""  FFFFFF ;ǰ��ɫ,�������͸��
		ShowWindow $Ckbox1 ${SW_HIDE}
		${NSD_Check} $Ckbox1
#------------------------------------------
#��ѡ��2
#------------------------------------------
    ${NSD_CreateCheckbox} 200 500 170 20 "��ӵ�����������"
    Pop $Ckbox2
    SetCtlColors $Ckbox2 ""  FFFFFF ;ǰ��ɫ,�������͸��
		ShowWindow $Ckbox2 ${SW_HIDE}
		${NSD_Check} $Ckbox2
		;������װĿ¼�����ı���
  	${NSD_CreateText} 54 421 600 35 "${DIR}"
		Pop $Txt_Browser
		SetCtlColors $Txt_Browser ""  FFFFFF ;�������͸��
		;${NSD_AddExStyle} $Txt_Browser ${WS_EX_WINDOWEDGE}
    CreateFont $1 "tahoma" "10" "500"
    SendMessage $Txt_Browser ${WM_SETFONT} $1 1
		ShowWindow $Txt_Browser ${SW_HIDE}
    ;��������·���ļ��а�ť
    ${NSD_CreateButton} 653 420 76 36  "���..."
		Pop $btn_Browser
		SkinBtn::Set /IMGID=$PLUGINSDIR\btn_browse.bmp $btn_Browser
		GetFunctionAddress $3 onClickSelectPath
    SkinBtn::onClick $btn_Browser $3
    SetCtlColors $btn_Browser 7F7F7F transparent ;ǰ��ɫ,�������͸��
    ShowWindow $btn_Browser ${SW_HIDE}
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage1
    ${NSD_SetImage} $BGImage1 $PLUGINSDIR\bg2.bmp $ImageHandle1
    ShowWindow $BGImage1 ${SW_HIDE}
    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    WndProc::onCallback $BGImage1 $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle
    ${NSD_FreeImage} $ImageHandle1
FunctionEnd
Function Page.1leave
${NSD_GetState} $Ckbox1 $Ckbox1_State
${NSD_GetState} $Ckbox2 $Ckbox2_State
FunctionEnd
Function  InstFilesPageShow
    FindWindow $R2 "#32770" "" $HWNDPARENT
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}
		;������չͼƬ
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
    File '/oname=$PLUGINSDIR\InstallingBG04.png' 'images\InstallingBG04.png' 
    StrCpy $R0 $R2 ;�ı�ҳ���С,��Ȼ��ͼ����ȫҳ
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 788, i 538) i r2"
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $R0 $0 ;�����ޱ߿����ƶ�
    GetDlgItem $R0 $R2 1004  ;���ý�����λ��
    System::Call "user32::MoveWindow(i R0, i 50, i 450, i 688, i 12) i r2"
    GetDlgItem $R1 $R2 1006  ;����������ı�ǩ"��װ�С�����"
    SetCtlColors $R1 ""  FFFFFF ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R1, i 50, i 400, i 688, i 25) i r2"
    GetDlgItem $R8 $R2 1016
    ;SetCtlColors $R8 ""  F6F6F6 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R8, i 0, i 60, i 788, i 200) i r2" ;��չͼƬ
    FindWindow $R2 "#32770" "" $HWNDPARENT  ;��ȡ1995������ͼƬ
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 788, i 538) i r2" ;��ͼ
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle
		;�����Ǹ���������ͼ
    FindWindow $R2 "#32770" "" $HWNDPARENT
    GetDlgItem $5 $R2 1004
	  SkinProgress::Set $5 "$PLUGINSDIR\ProgressBar.bmp" "$PLUGINSDIR\Progress.bmp"
FunctionEnd
Function Page.3
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;�������͸��
    ${NSW_SetWindowSize} $0 788 538 ;�ı�Page��С
    ${NSD_CreateCheckbox} 314 330 120 24  "�����Զ�����"
    Pop $Ckbox4
    SetCtlColors $Ckbox4 "" FFFFFF
    ;��������
    ${NSD_CreateButton} 190 390 160 54 ""
    Pop $btn_instend
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_express.bmp $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3
    ;��װ���
    ${NSD_CreateButton} 360 390 160 54 ""
    Pop $btn_instend1
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_finish.bmp $btn_instend1
    GetFunctionAddress $3 onClickend
    SkinBtn::onClick $btn_instend1 $3
    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle
FunctionEnd
Function Page.4

FunctionEnd
Section MainSetup
  ;����Ƿ���������
   killer::IsProcessRunning "GG.exe" ;�������н�������
   Pop $R0
  StrCmp $R0 1 0 +3
	  killer::KillProcess "GG.exe" ;�������� 
DetailPrint "���ڰ�װ..."
Sleep 1000
SetDetailsPrint None ;����ʾ��Ϣ
nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
Sleep 500 ;�ڰ�װ��������ִͣ��
SetOutPath $INSTDIR
File /r "C:\Users\Administrator\Desktop\app\outapp\winapp-win32-x64\*.*" ;��Ҫ����������ļ�
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 500
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
Sleep 50
    ${If} $Ckbox1_State == 1
    CreateShortCut "$DESKTOP\GG.lnk" "$INSTDIR\GG.exe" ;��������ͼ��
    ${EndIf}
    ${If} $Ckbox2_State == 1
    CreateDirectory "$SMPROGRAMS\godgou\GG"
    CreateShortCut "$SMPROGRAMS\godgou\GG\GG.lnk" "$INSTDIR\GG.exe" ;��ӵ�����������
    CreateShortCut "$SMPROGRAMS\godgou\GG\ж��GG.lnk" "$INSTDIR\Uninstall.exe"
    ${EndIf}
nsisSlideshow::Stop
SetAutoClose true
SectionEnd
Section -Post
  WriteUninstaller "$INSTDIR\Uninstall.exe" ;����ж���ļ�
  ;дע���
  WriteRegStr HKCU "${reg_dir}" "exedir" "$INSTDIR\GG.exe"
  WriteRegStr HKCU "${reg_dir}" "Uninstall" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKCU "${reg_dir}" "app_v" "${app_v}"
SectionEnd
Function ABORT
MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP '��ȷ��Ҫ�˳�${app_n} ${app_v}��װ����' IDNO CANCEL
SendMessage $hwndparent ${WM_CLOSE} 0 0
CANCEL:
Abort
FunctionEnd
;����ҳ����ת������
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd
Function onClickins
	${NSD_GetText} $Txt_Browser  $R0  ;������õİ�װ·��
   ;�ж�Ŀ¼�Ƿ���ȷ
	ClearErrors
	CreateDirectory "$R0"
	IfErrors 0 +3
  MessageBox MB_ICONINFORMATION|MB_OK "'$R0' ��װĿ¼�����ڣ����������á�"
  Return
	StrCpy $INSTDIR  $R0  ;���氲װ·��
  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd
;�������Զ��尲װ�����غ���ʾһ���ֿؼ�
Function onClickint
ShowWindow $BGImage ${SW_HIDE}
ShowWindow $Ckbox0 ${SW_HIDE}
ShowWindow $Txt_Xllicense ${SW_HIDE}
ShowWindow $Txt_ji ${SW_HIDE}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $BGImage1 ${SW_SHOW}
ShowWindow $btn_instetup ${SW_SHOW}
ShowWindow $btn_back ${SW_SHOW}
ShowWindow $Ckbox1 ${SW_SHOW}
ShowWindow $Ckbox2 ${SW_SHOW}
ShowWindow $btn_Browser ${SW_SHOW}
ShowWindow $Txt_Browser ${SW_SHOW}
FunctionEnd
;�������ʱ������ʾ���ֿؼ�
Function onClickBack
ShowWindow $BGImage1 ${SW_HIDE}
ShowWindow $BGImage ${SW_SHOW}
ShowWindow $Ckbox0 ${SW_SHOW}
ShowWindow $Txt_Xllicense ${SW_SHOW}
ShowWindow $Txt_ji ${SW_SHOW}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $btn_in ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $BGImage1 ${SW_HIDE}
ShowWindow $btn_instetup ${SW_HIDE}
ShowWindow $btn_back ${SW_HIDE}
ShowWindow $Ckbox1 ${SW_HIDE}
ShowWindow $Ckbox2 ${SW_HIDE}
ShowWindow $btn_Browser ${SW_HIDE}
ShowWindow $Txt_Browser ${SW_HIDE}
FunctionEnd
#------------------------------------------
#���Э��
#------------------------------------------
Function xllicense
ShowWindow $Ckbox0 ${SW_HIDE}
ShowWindow $Txt_Xllicense ${SW_HIDE}
ShowWindow $Txt_ji ${SW_HIDE}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $rtf_License ${SW_SHOW}
ShowWindow $btn_Licenseback ${SW_SHOW}
ShowWindow $rtf_License ${SW_SHOW}
FunctionEnd
;���Э���·��İ�ťִ��
Function Licenseback
ShowWindow $Ckbox0 ${SW_SHOW}
ShowWindow $Txt_Xllicense ${SW_SHOW}
ShowWindow $Txt_ji ${SW_SHOW}
ShowWindow $btn_in ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $btn_Licenseback ${SW_HIDE}
ShowWindow $rtf_License ${SW_HIDE}
FunctionEnd
#------------------------------------------
#�Ƿ�ѡ�����Э���ж�
#------------------------------------------
Function Chklicense
  Pop $Ckbox0
  ${NSD_GetState} $Ckbox0 $0
  ${If} $0 == 1
    EnableWindow $btn_ins 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_in 1
  ${Else}
    EnableWindow $btn_ins 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_in 0
  ${EndIf}
FunctionEnd
#--------------------------------------------------------
# ·��ѡ��ť�¼�����Windowsϵͳ�Դ���Ŀ¼ѡ��Ի���
#--------------------------------------------------------
Function onClickSelectPath
	 ${NSD_GetText} $Txt_Browser  $0
   nsDialogs::SelectFolderDialog  "��ѡ�� ${app_n}��װĿ¼��"  "$0"
   Pop $0
   ${IfNot} $0 == error
			${NSD_SetText} $Txt_Browser  $0
	${EndIf}
FunctionEnd
;����������
Function onClickexpress
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG" "$INSTDIR\GG.exe" ;�����Զ�����
  ${EndIf}
 Exec "$INSTDIR\GG.exe" ;������GG
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd
;���ҳ����ɰ�ť
Function onClickend
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG" "$INSTDIR\GG.exe" ;�����Զ�����
  ${EndIf}
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd
Section Uninstall
DetailPrint "����ж��${app_n}...."
  SetDetailsPrint None
  Delete "$DESKTOP\GG.lnk"
  RMDir /r "$SMPROGRAMS\godgou\GG"
  ;ɾ��ע���
  DeleteRegKey HKCU "${reg_dir}"
  DeleteRegValue HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG"
  RMDir /r "$INSTDIR" ;; ѭ��ɾ���ļ�ֱ��ɾ���ļ���
  SetAutoClose true
SectionEnd
Function un.myGuiInit
GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
FunctionEnd