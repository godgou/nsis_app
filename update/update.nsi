!addincludedir "include"
;---------------------------ȫ�ֱ���ű�Ԥ����ĳ���-----------------------------------------------------
!define app_n "GGupdate" ;����
!define app_v "17.04.09.12" ;�汾
!define app_c "godgou" ;��˾
;---------------------------�������ѹ�����ͣ�Ҳ����ͨ���������ű����ƣ�------------------------------------
SetCompressor lzma ;ѹ���㷨
SetCompress force ;���ѹ�����Ϊ force����ʼ��ʹ��ѹ��
AutoCloseWindow true ; ��ɺ��Զ��رո��³���
SilentInstall silent ;��Ĭ����
Name "${app_n} ${app_v}" ;���³�����ʾ����
OutFile "${app_n}.exe" ;���³�������ļ���
!define MUI_ICON "Icon\gg.ico" ;����ͼ���·������
!define MUI_UI "UI\mod.exe" ;ʹ�õ�UI
;DLL
ReserveFile `${NSISDIR}\Plugins\System.dll`
ReserveFile `${NSISDIR}\Plugins\killer.dll`
; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
; ���½����������������
!insertmacro MUI_LANGUAGE "SimpChinese"
;���ɵ�EXE�������İ汾��Ϣ�������ʾ����˴��������!insertmacro MUI_LANGUAGE "SimpChinese"����
VIProductVersion "${app_v}" ;����汾��Ϣ
VIAddVersionKey /LANG=2052 "ProductName" "${app_n}"  ;��Ʒ����
VIAddVersionKey /LANG=2052 "CompanyName" "godgou" ;��˾
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) godgou" ;��Ȩ
VIAddVersionKey /LANG=2052 "FileDescription" "GG���³���" ;��Ʒ����
VIAddVersionKey /LANG=2052 "FileVersion" "${app_v}" ;�ļ��汾��Ϣ
Section
    ;����Ƿ���������
   killer::IsProcessRunning "GG.exe" ;�������н�������
   Pop $R0
  StrCmp $R0 1 0 +3
	 killer::KillProcess "GG.exe" ;��������
DetailPrint "GG���ڸ���..."
SetOutPath "$EXEDIR\resources"
File /r "C:\Users\Administrator\Desktop\app\outapp\winapp-win32-x64\resources\*.*" ;��Ҫ����������ļ�
Exec "$EXEDIR\GG.exe"
SectionEnd
;------------------------------------------------------MUI �ִ����涨���Լ���������------------------------
Function .onInit
    InitPluginsDir ;��ʼ�����
FunctionEnd
Function onGUIInit
	;����ظ�����
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "GGupdate") i .r1 ?e'
  Pop $R1					
  StrCmp $R1 0 +3 																									 ;;;;$$$$$���³����Ѿ�����
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "GG���³����Ѿ������С�"
  Abort
FunctionEnd
