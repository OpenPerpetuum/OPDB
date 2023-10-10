:: This script will do the following
:: - Restore database to the original state
:: - Apply, in order, every patch with their SQL and folder (if applicable)

:: Disable the default echo behavior of every commands so the output will be cleaner
@echo off

set StartAndWait=start /min /wait
set SqlCmd=sqlcmd -E -S %computername%\PERPSQL -d perpetuumsa -I -i

set TARGET_DIR=C:\PerpetuumServer\data
set TOOLS_DIR=%~dp0Tools
set PATCHES_DIR=%~dp0Patches

:: Check if the target directory exists
if not exist %TARGET_DIR% goto :directoryNotFound

echo Welcome to the patching script
echo.
echo Restoring original database state
%StartAndWait% %SqlCmd% "%TOOLS_DIR%\restore_DB_to_original_state.sql"

:: Apply the patches in order
call:applyPatch Pre_Alpha_0 prealpha_patch_0.sql
call:applyPatch Pre_Alpha_1 prealpha_patch_1.sql Server
call:applyPatch Pre_Alpha_2 prealpha_patch_2.sql Server
call:applyPatch Pre_Alpha_3 prealpha_patch_3.sql
call:applyPatch Pre_Alpha_4 prealpha_patch_4.sql Server
call:applyPatch Pre_Alpha_5 prealpha_patch_5.sql
call:applyPatch Pre_Alpha_6 prealpha_patch_6.sql
call:applyPatch Pre_Alpha_7_FInal FIX_robottemplaterelation_pinkarkhe.sql
call:applyPatch Pre_Alpha_7_FInal NPC_robottemplates_argano_GetsEcms__2018_04_12.sql
call:applyPatch Live_1 live_patch_1.sql
call:applyPatch Live_2 live_patch_2.sql
call:applyPatch Live_3 live_patch_3.sql
call:applyPatch Live_4 live_patch_4.sql
call:applyPatch Live_5 live_patch_5.sql
call:applyPatch Live_6 live_patch_6.sql
call:applyPatch Live_7 live_patch_7.sql
call:applyPatch Live_8 live_patch_8.sql
call:applyPatch Live_9 live_patch_9.sql
call:applyPatch Live_10 live_patch_10.sql Server
call:applyPatch Live_11 live_patch_11.sql Server
call:applyPatch Live_12 live_patch_12.sql
call:applyPatch Live_13 live_patch_13.sql Server
call:applyPatch Live_14 live_patch_14.sql
call:applyPatch Live_15 live_patch_15.sql Server
call:applyPatch Live_16 live_patch_16.sql Server
call:applyPatch Live_17 live_patch_17.sql Server
call:applyPatch Live_18 live_patch_18.sql Server
call:applyPatch Live_19 live_patch_19.sql Server
call:applyPatch Live_20 live_patch_20.sql Server
call:applyPatch Live_21 live_patch_21.sql Server
call:applyPatch Live_22 live_patch_22.sql Server
call:applyPatch Live_23 live_patch_23.sql
call:applyPatch Live_24 live_patch_24.sql Server
call:applyPatch Live_25 live_patch_25.sql Server
call:applyPatch Live_26 live_patch_26.sql Server
call:applyPatch Live_27 live_patch_27.sql Server
call:applyPatch Live_28 live_patch_28.sql Server
call:applyPatch Live_29 live_patch_29.sql Server
call:applyPatch Live_30 live_patch_30.sql

echo.
echo Setting up the tool admin account..
echo Username: test
echo Password: test
%StartAndWait% %SqlCmd% "%TOOLS_DIR%\TOOL_test_account.sql"
echo Tool admin account is created
echo.

echo Patching complete
:: Providing "skip" as the first argument to the script, you can skip the pause when the script ends
:: It can be useful when you have multiple scripts you want to run with a single command
if not "%~1" == "skip" pause

:: Functions definition below this line
:applyPatch
:: Arguments:
:: 1 - Name of the directory of the patch to apply (Ex: Pre_Alpha_1)
:: 2 - SQL File name to execute (Ex: prealpha_patch_1.sql)
:: 3 (optional) - Name of the directory containing the "data" folder (Ex: Server)
	set patchDir=%~1
	set sqlFile=%~2
	set dataDir=%~3
	
	echo Patching %patchDir%
	
	:: Patching SQL
	%StartAndWait% %SqlCmd% "%PATCHES_DIR%\%patchDir%\%sqlFile%"

	:: Copy data directory if applicable
	if not "%dataDir%"=="" %StartAndWait% xcopy "%PATCHES_DIR%\%patchDir%\%dataDir%\data" "%TARGET_DIR%" /s /e /y
exit /b

:directoryNotFound
	echo The data directory was not found at the location %TARGET_DIR%, please make sure you move the directory to that location.
	pause
exit
