set PLATFORM_IO_PACKAGE=framework-arduinoteensy
set PKG_URL=https://dl.bintray.com/platformio/dl-packages/%PLATFORM_IO_PACKAGE%-%PKG_VERSION%.tar.gz
set FILENAME=%PLATFORM_IO_PACKAGE%-%PKG_VERSION%.tar.gz
REM Download Windows binary.
"%PYTHON%" -m wget "%PKG_URL%"
if errorlevel 1 exit 1
mkdir "%PKG_NAME%"
REM Extract files from from gz archive.
tar xvf %FILENAME% -C "%PKG_NAME%"

if errorlevel 1 exit 1
REM Copy contents to PlatformIO directory in Conda environment.
set CONDA_PKGS_DIR=%PREFIX%\share\platformio\packages
setlocal enableextensions
md "%CONDA_PKGS_DIR%"
if errorlevel 1 exit 1
endlocal
xcopy /S /Y /I /Q %PKG_NAME% "%CONDA_PKGS_DIR%"\%PLATFORM_IO_PACKAGE%
if errorlevel 1 exit 1
