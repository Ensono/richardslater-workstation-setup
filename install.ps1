#Requires -RunAsAdministrator

# Enable Windows Features
## Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online;

