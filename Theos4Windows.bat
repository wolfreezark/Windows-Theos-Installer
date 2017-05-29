@echo off
rem To see **EXACTLY** what this script is doing remove '@echo off'



rem Making a temp directory so I can delete anything downloaded
mkdir C:\tmp
mkdir C:\tmp\theos
cd C:\tmp\

rem Finding if Cygwin is installed through registry
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Cygwin > cygwin.txt

rem Checking OS type
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64BITCHECK

rem Still finding if Cygwin is installed through registry
find "Cygwin" cygwin.txt && echo Cygwin installed skipping installation... && goto 32BITINSTALLED
goto 32BIT
:64BITCHECK
find "Cygwin" cygwin.txt && echo Cygwin installed skipping installation... && goto 64BITINSTALLED
goto 64BIT

rem Installing cygwin
:32BIT
powershell (new-object System.Net.WebClient).DownloadFile('https://www.cygwin.com/setup-x86.exe', 'c:\tmp\setup-x86.exe')
setup-x86.exe -q --root C:\cygwin --site http://cygwin.mirror.constant.com --no-admin -d -P wget,git,ca-certificates,make perl,openssh,curl,curl-debuginfo,libcurl-devel,libcurl-doc,libcurl4,php-curl
:32BITINSTALLED
C:\cygwin\bin\bash -l -c "test -e /opt/theos && echo exist > /cygdrive/c/tmp/doesit.txt"
find "exist" doesit.txt && goto CLOSE
C:\cygwin\bin\bash -l -c "git clone https://github.com/wolfreezark/theos2.git /cygdrive/c/tmp/theos/"
C:\cygwin\bin\bash -l -c "chmod u+x /cygdrive/c/tmp/theos/install.sh"
goto END

rem Installing cygwin 64bit
:64BIT
powershell (new-object System.Net.WebClient).DownloadFile('https://www.cygwin.com/setup-x86_64.exe', 'C:\tmp\setup-x86.exe')
setup-x86.exe -q --root C:\cygwin --site http://cygwin.mirror.constant.com --no-admin -d -P wget,git,ca-certificates,make perl,openssh,curl,curl-debuginfo,libcurl-devel,libcurl-doc,libcurl4,php-curl
:64BITINSTALLED
C:\cygwin\bin\bash -l -c "test -e /opt/theos && echo exist > /cygdrive/c/tmp/doesit.txt"
find "exist" doesit.txt && goto CLOSE
C:\cygwin\bin\bash -l -c "git clone https://github.com/wolfreezark/theos2.git /cygdrive/c/tmp/theos/"
C:\cygwin\bin\bash -l -c "chmod u+x /cygdrive/c/tmp/theos/install.sh"
:END
C:\cygwin\bin\bash -l -c /cygdrive/c/tmp/theos/install.sh
C:\cygwin\bin\bash -l -c "rm -rf $THEOS/sdks && git clone https://github.com/theos/sdks.git $THEOS/sdks"
goto END2
:CLOSE
cls
echo Theos is installed silly :)
echo Type 'theos' in Cygwin terminal to run Theos, press any key to exit this installer.
timeout 999>nul
rmdir C:\tmp /s /q
exit
:END2
cls
echo Type 'theos' in Cygwin terminal to run Theos, press any key to exit this installer.
timeout 999>nul
rmdir C:\tmp /s /q
