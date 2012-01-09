==============================================================================
wdaemon - a cronlike daemon for Windows 2000/XP/Server/7
==============================================================================

0) About

    I use Perl Treads to restart a script oder program every n seconds.
    To do so, i install a perl script as a windows service with
    the windows ressource kit tools.

1) Requirements

    * MS Windows Ressource Kit Tools
      http://www.microsoft.com/download/en/details.aspx?id=17657

2) Installation

2.1) Install a Windows Service

    Assuming the Windows Ressource Kit Tools are installed
    in 
    
        C:\bin\Windows Resource Kits\
    
    you are able to install a new windows service:
    
        instsrv.exe wdaemon "C:\bin\Windows Resource Kits\Tools\srvany.exe"
    
    Under Windows 7 you have to run this command as administrator.
    (Start, Run, "cmd", Ctrl+Shift+Enter)
    
    Next, you have to install the Perl Script as service, therefor
    create a wdaemon.reg file with following content (Change the path names 
    for your needs/installation of perl):
    
    REGEDIT4
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wdaemon\Parameters]
    "Application"="c:\perl\bin\perl.exe"
    "AppDirectory"="c:\bin\wdaemon"
    "AppParameters"="wdaemon.pl c:\bin\wdaemon\wdaemon.rc"
    
    and insert it into your registry.
    
    
3) Usage

    For the configuration see the wdaemon.rc - file.
    If you add, delete or change entries, you have to restart 
    the service.


4) Uninstallation

    Stop the service with:
    
        net stop wdaemon

    Uninstall the service with:
    
        instsrv.exe wdaemon remove
    

------------------------------------------------------------------------------
(c) 2011 by Werner S��, GPL
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
