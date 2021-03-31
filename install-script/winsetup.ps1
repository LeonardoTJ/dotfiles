# Disable Advertising ID 
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# Disable Activity Tracking
@('EnableActivityFeed','PublishUserActivities','UploadUserActivities') |% { Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name $_ -Type DWord -Value 0 }

# Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1

# Get Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Fonts
choco install dejavufonts -y
choco install font-nerd-DejaVuSansMono -y

# Media
choco install honeyview -y
choco install mpv -y
choco install paint.net -y
choco install aimp -y

# Security
choco install malwarebytes -y

# Dev
choco install git -y
choco install python -y
choco install notepadplusplus -y
choco install vscode -y

# Internet
choco install firefox -y
choco install qbittorrent -y

# Games
choco install steam -y

# Additional Tools
choco install 7zip -y
choco install sumatrapdf -y
choco install curl -y
choco install wget -y
choco install windirstat -y
choco install rufus -y
