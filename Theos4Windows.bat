@echo off
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64BIT
mkdir C:\tmp
mkdir C:\tmp\theos
cd C:\tmp\
powershell (new-object System.Net.WebClient).DownloadFile('https://www.cygwin.com/setup-x86.exe', 'C:\tmp\setup-x86.exe')
setup-x86.exe -q --root C:\cygwin --site http://cygwin.mirror.constant.com --no-admin -d -P wget,git,ca-certificates,make perl,openssh
c:\cygwin\bin\bash -l -c "git clone https://github.com/wolfreezark/theos2.git /cygdrive/c/tmp/theos/"
c:\cygwin\bin\bash -l -c "chmod u+x /cygdrive/c/tmp/theos/install.sh"
goto END
:64BIT
mkdir C:\tmp
mkdir C:\tmp\theos
cd C:\tmp
powershell (new-object System.Net.WebClient).DownloadFile('https://www.cygwin.com/setup-x86_64.exe', 'C:\tmp\setup-x86.exe')
setup-x86.exe -q --root C:\cygwin --site http://cygwin.mirror.constant.com --no-admin -d -P wget,git,ca-certificates,make perl,openssh
c:\cygwin\bin\bash -l -c "git clone https://github.com/wolfreezark/theos2.git /cygdrive/c/tmp/theos/"
c:\cygwin\bin\bash -l -c "chmod u+x /cygdrive/c/tmp/theos/install.sh"
:END
c:\cygwin\bin\bash -l -c /cygdrive/c/tmp/theos/install.sh
echo Type ~/theos/bin/nic.pl in Cygwin terminal to run Theos, press any key to exit this installer.
timeout 300
rmdir C:\tmp /s /q