#Requires -RunAsAdministrator

# Install Software
choco install -y packages.config;

# Enable Windows Features
## Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online;

