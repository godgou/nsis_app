!addincludedir "include"
;---------------------------全局编译脚本预定义的常量-----------------------------------------------------
!define app_n "GGupdate" ;名称
!define app_v "17.04.09.12" ;版本
!define app_c "godgou" ;公司
;---------------------------设置软件压缩类型（也可以通过外面编译脚本控制）------------------------------------
SetCompressor lzma ;压缩算法
SetCompress force ;如果压缩标记为 force，则始终使用压缩
AutoCloseWindow true ; 完成后自动关闭更新程序
SilentInstall silent ;静默更新
Name "${app_n} ${app_v}" ;更新程序显示名字
OutFile "${app_n}.exe" ;更新程序输出文件名
!define MUI_ICON "Icon\gg.ico" ;更新图标的路径名字
!define MUI_UI "UI\mod.exe" ;使用的UI
;DLL
ReserveFile `${NSISDIR}\Plugins\System.dll`
ReserveFile `${NSISDIR}\Plugins\killer.dll`
; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
; 更新界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"
;生成的EXE增加中文版本信息，解决显示乱码此处代码放在!insertmacro MUI_LANGUAGE "SimpChinese"后面
VIProductVersion "${app_v}" ;程序版本信息
VIAddVersionKey /LANG=2052 "ProductName" "${app_n}"  ;产品名称
VIAddVersionKey /LANG=2052 "CompanyName" "godgou" ;公司
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) godgou" ;版权
VIAddVersionKey /LANG=2052 "FileDescription" "GG更新程序" ;产品描述
VIAddVersionKey /LANG=2052 "FileVersion" "${app_v}" ;文件版本信息
Section
    ;检测是否正在运行
   killer::IsProcessRunning "GG.exe" ;检测的运行进程名称
   Pop $R0
  StrCmp $R0 1 0 +3
	 killer::KillProcess "GG.exe" ;结束进程
DetailPrint "GG正在更新..."
SetOutPath "$EXEDIR\resources"
File /r "C:\Users\Administrator\Desktop\app\outapp\winapp-win32-x64\resources\*.*" ;需要打包的所有文件
Exec "$EXEDIR\GG.exe"
SectionEnd
;------------------------------------------------------MUI 现代界面定义以及函数结束------------------------
Function .onInit
    InitPluginsDir ;初始化插件
FunctionEnd
Function onGUIInit
	;检查重复运行
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "GGupdate") i .r1 ?e'
  Pop $R1					
  StrCmp $R1 0 +3 																									 ;;;;$$$$$更新程序已经运行
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "GG更新程序已经在运行。"
  Abort
FunctionEnd
