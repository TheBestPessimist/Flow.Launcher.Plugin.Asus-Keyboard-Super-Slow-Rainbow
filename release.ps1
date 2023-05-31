
$currentPath = "D:\all\work\Flow.Launcher.Plugin.Asus Keyboard Super Slow Rainbow\Flow.Launcher.Plugin.Asus Keyboard Super Slow Rainbow"

cd $currentPath
echo "➡️ dir: $pwd"

$version = (Get-Content 'plugin.json' | ConvertFrom-Json).Version

dotnet publish  -c Release -r win-x64 --no-self-contained


Remove-Item -Path "bin/Release/win-x64/Asus Keyboard Super Slow Rainbow-$version" -Recurse -Force -ErrorAction SilentlyContinue
Rename-Item -Path "bin/Release/win-x64/publish" -NewName "Asus Keyboard Super Slow Rainbow-$version" -Force
Compress-Archive -LiteralPath "bin/Release/win-x64/Asus Keyboard Super Slow Rainbow-$version" -DestinationPath "bin/Asus Keyboard Super Slow Rainbow Flow Launcher Plugin-$version.zip" -Force


### optional steps
Stop-Process -Name "Flow.Launcher" -ErrorAction SilentlyContinue

# if development FL
# TODO robocopy
#& "D:/all/work/Flow.Launcher/Output/Debug/Flow.Launcher.exe"

# if productive FL
robocopy /E /Z /R:5 /W:5 /TBD /unicode /V /XJ /ETA /MT:32 "$currentPath\bin\Release\win-x64\Asus Keyboard Super Slow Rainbow-$version" "D:\all\all\Flow.Launcher\app-1.15.0\UserData\Plugins\Asus Keyboard Super Slow Rainbow-$version"
& "D:\all\all\Flow.Launcher\Flow.Launcher.exe"


sleep 3
echo "Done!"