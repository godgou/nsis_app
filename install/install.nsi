!addincludedir "include"
Var MSG     ;MSG变量必须定义，而且在最前面，否则WndProc::onCallback不工作，插件中需要这个消息变量,用于记录消息信息
Var Dialog  ;Dialog变量也需要定义，他可能是NSIS默认的对话框变量用于保存窗体中控件的信息
Var BGImage  ;背景大图
Var ImageHandle
Var BGImage1  ;背景大图
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
;---------------------------全局编译脚本预定义的常量-----------------------------------------------------
!define app_n "GG" ;名称
!define app_v "17.04.09.12" ;版本
!define app_c "godgou" ;公司
!define reg_dir "Software\godgou\GG"
;---------------------------设置软件压缩类型（也可以通过外面编译脚本控制）------------------------------------
SetCompressor lzma
SetCompress force
;安装程序显示名字
Name "${app_n}"
;安装程序输出文件名
OutFile "${app_n} ${app_v}.exe"
!define DIR "$PROGRAMFILES\godgou\GG" ;请在这里定义安装路径
InstallDir "${DIR}"
InstallDirRegKey HKCU "${reg_dir}" "exedir"
ShowInstDetails nevershow ;设置是否显示安装详细信息。
ShowUnInstDetails nevershow ;设置是否显示删除详细信息。
;安装图标的路径名字
!define MUI_ICON "Icon\gg.ico"
;卸载图标的路径名字
!define MUI_UNICON "Icon\Uninstall.ico"
;使用的UI
!define MUI_UI "UI\mod.exe"
;使用ReserveFile是加快安装包展开速度，具体请看帮助
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
;轮展数据
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
; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT myGuiInit
!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGuiInit
;自定义页面
Page custom Page.1 Page.1leave
; 安装过程页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
Page custom Page.3
;这个不要删除，否则自动跳转出问题
Page custom Page.4
; 安装卸载过程页面
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"
;生成的EXE增加中文版本信息，解决显示乱码此处代码放在!insertmacro MUI_LANGUAGE "SimpChinese"后面
VIProductVersion "${app_v}" ;程序版本信息
VIAddVersionKey /LANG=2052 "ProductName" "${app_n}"  ;产品名称
VIAddVersionKey /LANG=2052 "CompanyName" "godgou" ;公司
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) godgou" ;版权
VIAddVersionKey /LANG=2052 "FileDescription" "GG安装程序" ;产品描述
VIAddVersionKey /LANG=2052 "FileVersion" "${app_v}" ;文件版本信息
;------------------------------------------------------MUI 现代界面定义以及函数结束------------------------

Function .onInit
    InitPluginsDir ;初始化插件
    StrCpy $Ckbox1_State ${BST_CHECKED}
    StrCpy $Ckbox2_State ${BST_CHECKED}
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;第一大背景
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;第二大背景
    File `/oname=$PLUGINSDIR\bg3.bmp` `images\bg3.bmp` ;完成页背景
    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;快速安装
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;自定义安装
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;浏览按钮
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;立即安装
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;安装完成
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;返回
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;立即体验
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;关闭
		;进度条皮肤
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;协议
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
		;初始化
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
	;检查重复运行
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "GG") i .r1 ?e'
  Pop $R1		;$$$$$安装程序已经运行
  StrCmp $R1 0 +3
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "godgou安装程序已经在运行。"
  Abort  
    ;消除边框
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;隐藏一些既有控件
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
    ${NSW_SetWindowSize} $HWNDPARENT 788 538 ;改变主窗体大小589 439
    System::Call User32::GetDesktopWindow()i.R0
    ;圆角
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd
;处理无边框移动
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
    SetCtlColors $0 ""  transparent ;背景设成透明
    ${NSW_SetWindowSize} $0 788 538 ;改变Page大小
    ;读取RTF的文本框
		nsDialogs::CreateControl "RichEdit20A" \
    ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} \
		${WS_EX_STATICEDGE}  1 1 784 480 ''
    Pop $rtf_License
		${LoadRTF} '$PLUGINSDIR\license.rtf' $rtf_License
    ShowWindow $rtf_License ${SW_HIDE}
    ;协议确定按钮
    ${NSD_CreateButton} 360 500 55 30 "确定"
    Pop $btn_Licenseback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Licenseback
    GetFunctionAddress $3 Licenseback
    SkinBtn::onClick $btn_Licenseback $3
    SetCtlColors $btn_Licenseback 7F7F7F transparent
    ShowWindow $btn_Licenseback ${SW_HIDE}   
    ;自定义安装按钮
    ${NSD_CreateButton} 650 500 98 17 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 onClickint
    SkinBtn::onClick $btn_ins $3   
    ;快速安装
    ${NSD_CreateButton} 260 382 262 64 ""
    Pop $btn_in
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_onekey.bmp $btn_in
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_in $3
    ;关闭按钮
    ${NSD_CreateButton} 750 13 24 20 ""
    Pop $btn_Close
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_Close.bmp $btn_Close
    GetFunctionAddress $3 ABORT
    SkinBtn::onClick $btn_Close $3
    ;立即安装
    ${NSD_CreateButton} 550 500 82 26 "立即安装"
    Pop $btn_instetup
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_instetup
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_instetup $3
    SetCtlColors $btn_instetup FFFFFF transparent
    ShowWindow $btn_instetup ${SW_HIDE}
    ;返回
    ${NSD_CreateButton} 674 500 56 26 "返回"
    Pop $btn_back
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_back
    GetFunctionAddress $3 onClickBack
    SkinBtn::onClick $btn_back $3
    SetCtlColors $btn_back 7F7F7F transparent
    ShowWindow $btn_back ${SW_HIDE}  
#------------------------------------------
#许可协议
#------------------------------------------
    ${NSD_CreateCheckbox} 40 500 100 20 "同意GG的"
    Pop $Ckbox0
    SetCtlColors $Ckbox0 "" FFFFFF
    ${NSD_Check} $Ckbox0
    ${NSD_OnClick} $Ckbox0 Chklicense
    ${NSD_CreateLink} 140 502 100 20 "用户许可协议"
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 5ba900 FFFFFF
    ${NSD_OnClick} $Txt_Xllicense xllicense
#------------------------------------------
#可选项1
#------------------------------------------
    ${NSD_CreateCheckbox} 50 500 125 20 "创建桌面图标"
    Pop $Ckbox1
    SetCtlColors $Ckbox1 ""  FFFFFF ;前景色,背景设成透明
		ShowWindow $Ckbox1 ${SW_HIDE}
		${NSD_Check} $Ckbox1
#------------------------------------------
#可选项2
#------------------------------------------
    ${NSD_CreateCheckbox} 200 500 170 20 "添加到快速启动栏"
    Pop $Ckbox2
    SetCtlColors $Ckbox2 ""  FFFFFF ;前景色,背景设成透明
		ShowWindow $Ckbox2 ${SW_HIDE}
		${NSD_Check} $Ckbox2
		;创建安装目录输入文本框
  	${NSD_CreateText} 54 421 600 35 "${DIR}"
		Pop $Txt_Browser
		SetCtlColors $Txt_Browser ""  FFFFFF ;背景设成透明
		;${NSD_AddExStyle} $Txt_Browser ${WS_EX_WINDOWEDGE}
    CreateFont $1 "tahoma" "10" "500"
    SendMessage $Txt_Browser ${WM_SETFONT} $1 1
		ShowWindow $Txt_Browser ${SW_HIDE}
    ;创建更改路径文件夹按钮
    ${NSD_CreateButton} 653 420 76 36  "浏览..."
		Pop $btn_Browser
		SkinBtn::Set /IMGID=$PLUGINSDIR\btn_browse.bmp $btn_Browser
		GetFunctionAddress $3 onClickSelectPath
    SkinBtn::onClick $btn_Browser $3
    SetCtlColors $btn_Browser 7F7F7F transparent ;前景色,背景设成透明
    ShowWindow $btn_Browser ${SW_HIDE}
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage1
    ${NSD_SetImage} $BGImage1 $PLUGINSDIR\bg2.bmp $ImageHandle1
    ShowWindow $BGImage1 ${SW_HIDE}
    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    WndProc::onCallback $BGImage1 $0 ;处理无边框窗体移动
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
		;存入轮展图片
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
    File '/oname=$PLUGINSDIR\InstallingBG04.png' 'images\InstallingBG04.png' 
    StrCpy $R0 $R2 ;改变页面大小,不然贴图不能全页
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 788, i 538) i r2"
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $R0 $0 ;处理无边框窗体移动
    GetDlgItem $R0 $R2 1004  ;设置进度条位置
    System::Call "user32::MoveWindow(i R0, i 50, i 450, i 688, i 12) i r2"
    GetDlgItem $R1 $R2 1006  ;进度条上面的标签"安装中、、、"
    SetCtlColors $R1 ""  FFFFFF ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R1, i 50, i 400, i 688, i 25) i r2"
    GetDlgItem $R8 $R2 1016
    ;SetCtlColors $R8 ""  F6F6F6 ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R8, i 0, i 60, i 788, i 200) i r2" ;轮展图片
    FindWindow $R2 "#32770" "" $HWNDPARENT  ;获取1995并设置图片
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 788, i 538) i r2" ;贴图
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle
		;这里是给进度条贴图
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
    SetCtlColors $0 ""  transparent ;背景设成透明
    ${NSW_SetWindowSize} $0 788 538 ;改变Page大小
    ${NSD_CreateCheckbox} 314 330 120 24  "开机自动启动"
    Pop $Ckbox4
    SetCtlColors $Ckbox4 "" FFFFFF
    ;立即体验
    ${NSD_CreateButton} 190 390 160 54 ""
    Pop $btn_instend
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_express.bmp $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3
    ;安装完成
    ${NSD_CreateButton} 360 390 160 54 ""
    Pop $btn_instend1
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_finish.bmp $btn_instend1
    GetFunctionAddress $3 onClickend
    SkinBtn::onClick $btn_instend1 $3
    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 788 538 ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle
FunctionEnd
Function Page.4

FunctionEnd
Section MainSetup
  ;检测是否正在运行
   killer::IsProcessRunning "GG.exe" ;检测的运行进程名称
   Pop $R0
  StrCmp $R0 1 0 +3
	  killer::KillProcess "GG.exe" ;结束进程 
DetailPrint "正在安装..."
Sleep 1000
SetDetailsPrint None ;不显示信息
nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
Sleep 500 ;在安装程序里暂停执行
SetOutPath $INSTDIR
File /r "C:\Users\Administrator\Desktop\app\outapp\winapp-win32-x64\*.*" ;需要打包的所有文件
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
    CreateShortCut "$DESKTOP\GG.lnk" "$INSTDIR\GG.exe" ;创建桌面图标
    ${EndIf}
    ${If} $Ckbox2_State == 1
    CreateDirectory "$SMPROGRAMS\godgou\GG"
    CreateShortCut "$SMPROGRAMS\godgou\GG\GG.lnk" "$INSTDIR\GG.exe" ;添加到快速启动栏
    CreateShortCut "$SMPROGRAMS\godgou\GG\卸载GG.lnk" "$INSTDIR\Uninstall.exe"
    ${EndIf}
nsisSlideshow::Stop
SetAutoClose true
SectionEnd
Section -Post
  WriteUninstaller "$INSTDIR\Uninstall.exe" ;生成卸载文件
  ;写注册表
  WriteRegStr HKCU "${reg_dir}" "exedir" "$INSTDIR\GG.exe"
  WriteRegStr HKCU "${reg_dir}" "Uninstall" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKCU "${reg_dir}" "app_v" "${app_v}"
SectionEnd
Function ABORT
MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP '您确定要退出${app_n} ${app_v}安装程序？' IDNO CANCEL
SendMessage $hwndparent ${WM_CLOSE} 0 0
CANCEL:
Abort
FunctionEnd
;处理页面跳转的命令
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd
Function onClickins
	${NSD_GetText} $Txt_Browser  $R0  ;获得设置的安装路径
   ;判断目录是否正确
	ClearErrors
	CreateDirectory "$R0"
	IfErrors 0 +3
  MessageBox MB_ICONINFORMATION|MB_OK "'$R0' 安装目录不存在，请重新设置。"
  Return
	StrCpy $INSTDIR  $R0  ;保存安装路径
  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd
;当单击自定义安装后隐藏和显示一部分控件
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
;点击返回时隐藏显示部分控件
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
#许可协议
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
;点击协议下方的按钮执行
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
#是否选中许可协议判断
#------------------------------------------
Function Chklicense
  Pop $Ckbox0
  ${NSD_GetState} $Ckbox0 $0
  ${If} $0 == 1
    EnableWindow $btn_ins 1 ;对指定的窗口或控件是否允许键入0禁止
    EnableWindow $btn_in 1
  ${Else}
    EnableWindow $btn_ins 0 ;对指定的窗口或控件是否允许键入0禁止
    EnableWindow $btn_in 0
  ${EndIf}
FunctionEnd
#--------------------------------------------------------
# 路径选择按钮事件，打开Windows系统自带的目录选择对话框
#--------------------------------------------------------
Function onClickSelectPath
	 ${NSD_GetText} $Txt_Browser  $0
   nsDialogs::SelectFolderDialog  "请选择 ${app_n}安装目录："  "$0"
   Pop $0
   ${IfNot} $0 == error
			${NSD_SetText} $Txt_Browser  $0
	${EndIf}
FunctionEnd
;立即体验检测
Function onClickexpress
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG" "$INSTDIR\GG.exe" ;开机自动启动
  ${EndIf}
 Exec "$INSTDIR\GG.exe" ;即运行GG
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd
;完成页面完成按钮
Function onClickend
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG" "$INSTDIR\GG.exe" ;开机自动启动
  ${EndIf}
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd
Section Uninstall
DetailPrint "正在卸载${app_n}...."
  SetDetailsPrint None
  Delete "$DESKTOP\GG.lnk"
  RMDir /r "$SMPROGRAMS\godgou\GG"
  ;删除注册表
  DeleteRegKey HKCU "${reg_dir}"
  DeleteRegValue HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GG"
  RMDir /r "$INSTDIR" ;; 循环删除文件直至删除文件夹
  SetAutoClose true
SectionEnd
Function un.myGuiInit
GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
FunctionEnd