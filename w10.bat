@echo off


cls
echo.
echo  :: Disabling Windows Update
timeout /t 2 /nobreak > NUL
net stop wuauserv
sc config wuauserv start= disabled

cls
echo.
echo  :: Disabling Data Logging Services
timeout /t 2 /nobreak > NUL
taskkill /f /im explorer.exe

:: Disable Tracking Services and Data Collection
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f > NUL 2>&1

:: Disable and Delete Tasks
cls
schtasks /change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE > NUL 2>&1
cls
schtasks /change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE > NUL 2>&1
cls
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE > NUL 2>&1
cls
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /DISABLE > NUL 2>&1
cls
schtasks /change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Clip\License Validation" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\HelloFace\FODCleanupTask" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Maps\MapsToastTask" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /f > NUL 2>&1
cls
schtasks /delete /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /f > NUL 2>&1
cls



:: Registry Edits
cls
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DownloadMode /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /v TCGSecurityActivationDisabled /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers" /v authenticodeenabled /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseActionCenterExperience /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAHealth /t REG_DWORD /d 0x1 /f > NUL 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f > NUL 2>&1

:: Remove SecurityHealth from startup
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f


:: Turns off Windows blocking installation of files downloaded from the internet
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 1 /f > NUL 2>&1

:: Disables SmartScreen
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v ContentEvaluation /t REG_DWORD /d 0 /f > NUL 2>&1

:: Remove Metadata Tracking
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /f > NUL 2>&1

:: New Control Panel cleanup - List of commands: https://winaero.com/ms-settings-commands-in-windows-10/
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v SettingsPageVisibility /t REG_SZ /d "showonly:display;nightlight;sound;notifications;quiethours;powersleep;batterysaver;tabletmode;multitasking;clipboard;remote-desktop;about;bluetooth;connecteddevices;printers;mousetouchpad;devices-touchpad;typing;pen;autoplay;usb;network-status;network-cellular;network-wifi;network-wificalling;network-wifisettings;network-ethernet;network-dialup;network-vpn;network-airplanemode;network-mobilehotspot;datausage;network-proxy;personalization-background;personalization-start;fonts;colors;lockscreen;themes;taskbar;defaultapps;videoplayback;startupapps;dateandtime;regionformatting;gaming;gamemode;easeofaccess-display;easeofaccess-colorfilter;easeofaccess-audio;easeofaccess-easeofaccess-narrator;easeofaccess-magnifier;easeofaccess-highcontrast;easeofaccess-closedcaptioning;easeofaccess-speechrecognition;easeofaccess-eyecontrol;easeofaccess-keyboard;easeofaccess-mouse;cortana-windowssearch;search-moredetails" /f > NUL 2>&1

:: Decrease shutdown time
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeOut /t REG_SZ /d 2000 /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v HungAppTimeout /t REG_SZ /d 2000 /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v AutoEndTasks /t REG_SZ /d 1 /f > NUL 2>&1

:: Disabling And Stopping Services
cls
sc config diagtrack start= disabled
cls
sc config RetailDemo start= disabled
cls
sc config diagnosticshub.standardcollector.service start= disabled
cls
sc config DiagTrack start= disabled
cls
sc config dmwappushservice start= disabled
cls
sc config HomeGroupListener start= disabled
cls
sc config HomeGroupProvider start= disabled
cls
sc config lfsvc start= disabled
cls
sc config MapsBroker start= disabled
cls
sc config NetTcpPortSharing start= disabled
cls
sc config RemoteAccess start= disabled
cls
sc config RemoteRegistry start= disabled
cls
sc config SharedAccess start= disabled
cls
sc config StorSvc start= disabled
cls
sc config TrkWks start= disabled
cls
sc config WbioSrvc start= disabled
cls
sc config WMPNetworkSvc start= disabled
cls
sc config wscsvc start= disabled
cls
net stop wlidsvc
sc config wlidsvc start= disabled
cls
:: Disable SMBv1. Effectively mitigates EternalBlue, popularly known as WannaCry.
PowerShell -Command "Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force"
sc config lanmanworkstation depend= bowser/mrxsmb20/nsi
sc config mrxsmb10 start= disabled

:: Cleaning up the This PC Icon Selection
cls
echo.
echo  :: Removing all Folders from MyPC
timeout /t 2 /nobreak
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > NUL 2>&1

:: Disabling Storage Sense
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense" /f > NUL 2>&1

:: Disabling Cortana and Removing Search Icon from Taskbar
cls
echo.
echo  :: Disabling Cortana
timeout /t 2 /nobreak
taskkill /f /im SearchUI.exe

cls
echo.
echo  :: Fixing Search
timeout /t 2 /nobreak
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AlwaysUseAutoLangDetection" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaInAmbientMode" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD 0 /f  > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "HasAboveLockTips" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "SafeSearchMode" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationDefaultOn" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "VoiceActivationEnableAboveLockscreen" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d 1 /f > NUL 2>&1
:: Batch magic to search for the current user SID and disable the web search in the stock start menu, this is the equivalent of enabling some group policy that does the same thing, will need to keep in mind if new users are to be added as they will also need this registry entry.
:: This bit here sends the output of a command to a variable
:: There is the assumption that the account the script is being run with has admin privileges, it will otherwise not work. If following the official documentation then it works fine.
for /f "tokens=* USEBACKQ" %%i in (`wmic useraccount where "name="%username%"" get sid ^| findstr "S-"`) do set currentusername=%%i
:: Trim 3 empty spaces off the end of the returned string
set currentusername=%currentusername:~0,-3%
reg add "HKEY_USERS\%currentusername%\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f > NUL 2>&1
:: Firewall rules to prevent the startmenu from talking
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block Search SearchApp.exe" /t REG_SZ /d "v2.30|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe|Name=Block Search SearchUI.exe|Desc=Block Cortana Outbound UDP/TCP Traffic|" /f > NUL 2>&1
::reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "Block Search Package" /t REG_SZ /d "v2.30|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|Name=Block Search Package|Desc=Block Search Outbound UDP/TCP Traffic|AppPkgId=S-1-15-2-536077884-713174666-1066051701-3219990555-339840825-1966734348-1611281757|Platform=2:6:2|Platform2=GTEQ|" /f > NUL 2>&1

:: Disable Timeline
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f > NUL 2>&1


:: Set Time to UTC
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f > NUL 2>&1

::Disable Users On Login Screen
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v dontdisplaylastusername /t REG_DWORD /d 1 /f > NUL 2>&1

::Disable The Lock Screen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f > NUL 2>&1

powercfg /h off

