@echo off
title System Health
goto check_permission

:check_permission
	echo Checking permission...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto scan_system
    ) else (
        goto no_permission
    )
:no_permission
	echo Administrative permission is required, please run as admin.
	goto exit
:scan_system
	echo Administrative permissions confirmed.
	title [DISM] Checking health...
	DISM /Online /Cleanup-Image /CheckHealth
	title [DISM] Scanning health...
	DISM /Online /Cleanup-Image /ScanHealth
	title [DISM] Restoring health...
	DISM /Online /Cleanup-Image /RestoreHealth
	title [SFC] Scanning...
	sfc /scannow
	title System Health
	echo.
	echo Finished system scan.
	goto exit
:exit
	echo.
	echo Press any key to exit...
	pause>nul