set PLATFORM_IO_PACKAGE=framework-arduinoteensy
set PKG_URL=https://dl.bintray.com/platformio/dl-packages/framework-arduinoteensy-1.136.0.tar.gz
set FILENAME=framework-arduinoteensy-1.136.0.tar.gz
set PKG_NAME=platformio-framework-arduinoteensy
set WIRE_VERSION=0.1.2

REM Download Windows binary.
"%PYTHON%" -m wget "%PKG_URL%"
if errorlevel 1 exit 1
mkdir "%PKG_NAME%"
REM Extract files from from tar.gz archive.
tar xvf %FILENAME% -C "%PKG_NAME%"
if errorlevel 1 exit 1

REM Delete Wire library
rmdir /S/Q "%PKG_NAME%\libraries\Wire"
if errorlevel 1 exit 1

"%PYTHON%" -m wget "https://github.com/sci-bots/Wire/archive/v%WIRE_VERSION%.tar.gz" -o Wire-v%WIRE_VERSION%.tar.gz
if errorlevel 1 exit 1
tar xvf Wire-v%WIRE_VERSION%.tar.gz
if errorlevel 1 exit 1
mv Wire-%WIRE_VERSION% "%PKG_NAME%\libraries\Wire"
if errorlevel 1 exit 1

REM Copy contents to PlatformIO directory in Conda environment.
set CONDA_PKGS_DIR=%PREFIX%\share\platformio\packages
setlocal enableextensions
md "%CONDA_PKGS_DIR%"
if errorlevel 1 exit 1
endlocal
xcopy /S /Y /I /Q %PKG_NAME% "%CONDA_PKGS_DIR%"\%PLATFORM_IO_PACKAGE%
if errorlevel 1 exit 1
