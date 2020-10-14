@echo off

if not exist %1.air goto error

if exist %1.air "Z:\#tDisk\Tools\Adobe AIR 2.0.3\AdobeAIRSDK\bin\adt" -package -target native %1.exe %1.air
REM -storetype pkcs12 -keystore "Z:\Adobe AIR Certs\VyperLogixCorp.p12" -keypass peekab00
goto end

:error

echo "There is a problem... with %1.air"

:end
