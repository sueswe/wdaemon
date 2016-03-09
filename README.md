==============================================================================
wdaemon - a cronlike daemon for Windows
==============================================================================

## 0) About ##

I use Perl threads to restart a script or program every n seconds.  
To do so, I install a perl script as a windows service.


## 1) Requirements ##

Following Perl-Modules are required:  

* threads <http://search.cpan.org/~jdhedden/threads-1.86/lib/threads.pm>  
* Log::Log4perl <http://search.cpan.org/~mschilli/Log-Log4perl-1.40/>  


## 2) Installation ##

### 2.1) Install a Windows Service ###

Use nssm ([http://nssm.cc](http://nssm.cc)):

    nssm install wdaemon C:\strawberry\perl\bin\perl.exe C:\foo\bar\wdaemon.pl

### 2.2) Linux and Un*x ###

Just start the wdaemon.pl script however you want =)


## 3) Usage ##

For the configuration see the wdaemon.rc - file.  
If you add, delete or change entries, you have to restart  
the service.
