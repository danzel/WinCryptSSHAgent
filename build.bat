@echo off
setlocal

echo "Test Run GOV before"
goversioninfo

set PATH=%PATH%;%GOPATH%\bin

echo "Test Run GOV after"
goversioninfo

echo %PATH%

@rem Build all by default
if [%1]==[] (
	go generate
	call :build 386 WinCryptSSHAgent_32bit.exe
	call :build amd64 WinCryptSSHAgent.exe
) else (
	go generate
	call :build %1 WinCryptSSHAgent-%1.exe
)
goto :eof


:build
set arch=%1
set output=%2
echo Build %arch% to %output%

set GOARCH=%arch%
go build -ldflags "-w -s -H=windowsgui" -trimpath -o %output%

goto :eof
