dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# restart machine


wsl --set-default-version 2

# install ubuntu + windows terminal from store