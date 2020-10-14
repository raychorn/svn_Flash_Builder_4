REM cd AndroidGamersLoungeV1\bin-debug\
REM cd AndroidEmployeeDirectory\bin-debug\
cd SocialHax\bin-debug\


REM call "C:\Adobe_AIR_SDK_2.6\AdobeAIRSDK\bin\adt.bat" -package -target apk -storetype pkcs12 -keystore "H:\Ray Horn\AIR Certs\Thawte-VyperLogixCorp.p12" -keypass peekab00 AndroidGamersLoungeV1.apk AndroidGamersLoungeV1-app.xml AndroidGamersLoungeV1.swf

REM call "C:\Adobe_AIR_SDK_2.5\bin\adt.bat" -package -target apk -storetype pkcs12 -keystore "H:\Ray Horn\AIR Certs\Thawte-VyperLogixCorp.p12" -keypass peekab00 AndroidGamersLoungeV1.apk AndroidGamersLoungeV1-app.xml AndroidGamersLoungeV1.swf

REM call "C:\Adobe_AIR_SDK_2.5\bin\adt.bat" -package -target apk -storetype pkcs12 -keystore "H:\Ray Horn\AIR Certs\Thawte-VyperLogixCorp.p12" EmployeeDirectory.apk EmployeeDirectory-app.xml EmployeeDirectory.swf

REM if not exist NeoSansIntelLight.ttf then copy ..\src\NeoSansIntelLight.ttf NeoSansIntelLight.ttf

call "C:\Adobe_AIR_SDK_2.5\bin\adt.bat" -package -target apk -storetype pkcs12 -keystore "H:\Ray Horn\AIR Certs\Thawte-VyperLogixCorp.p12" -keypass peekab00 SocialHax.apk SocialHax-app.xml SocialHax.swf icon36.png icon48.png icon72.png

cd ..\..

