Richard's Workstation Setup Scripts
===================================

This repository contains a series of scripts designed to build a Windows Workstation from a AutoPilot image to include the majority of applications used on a day-to-day basis.

 - `bootstrap.ps1` - performs one-time tasks such as installing [Chocolatey](https://chocolatey.org/) and starting OpenSSH Agent.
 - `install.ps1` - performs one-time installation tasks, specifcially installing packages from `packages.config`.
 - `cleanup.ps1` - cleans up the "cruft" that builds up due to installing software.
 - `upgrade.ps1` - performs an upgrade of all installed software.

Benefits
--------

Treat workstations like [Cattle not Pets](https://devops.stackexchange.com/questions/653/what-is-the-definition-of-cattle-not-pets).

1. Being able to setup a workstation quickly reduces the downtime caused by equipment failure.
2. Scripting the installation reduces the chance of changes to software.
3. Auditing is easier when you know exactly what you installed.
4. Reducing the barrier to rebuilding a workstation improves security, regular rebuilds remove legacy cruft and reduce the persistence of malware on machines.

Instructions
------------

### Add a package
Test the install with:
```
choco install <package-name>
```

If successfull add to `packages.config`

### Remove a package
Uninstall the package first with:
```
choco uninstall <package-name>
```