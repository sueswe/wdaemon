==============================================================================
wdaemon - a cronlike daemon for Windows
==============================================================================

0) About

    I use Perl threads to restart a script or program every n seconds.
    To do so, I install a perl script as a windows service with
    the windows ressource kit tools.

1) Requirements

    Following Perl-Modules are required:
    * threads <http://search.cpan.org/~jdhedden/threads-1.86/lib/threads.pm>
    * Log::Log4perl <http://search.cpan.org/~mschilli/Log-Log4perl-1.40/>

2) Installation

2.1) Install a Windows Service

    You are able to install a new windows service with sc.exe and srvany.exe.
    Use srvany from the Windows RessourceKitTool 2003. 
    Example: sc create MyService binPath= C:\foo\bar\srvany.exe DisplayName= "My Custom Service"
    Then use RegEdit: create a "Parameters" key for your service 
    (e.g. HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MyService\Paramaters\)
    Within the newly created "Parameters"-key, create a string-value called 
    "Application" and enter the full path to the perl.exe c:\bar\foo\wdameon.pl .
    See <http://support.microsoft.com/kb/251192/EN-US>
    
2.2) Linux and Un*x

    Just start the wdaemon.pl script however you want =)

3) Usage

    For the configuration see the wdaemon.rc - file.
    If you add, delete or change entries, you have to restart 
    the service.


------------------------------------------------------------------------------

(c) 2011-2013 by Werner Süß, GPL
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


