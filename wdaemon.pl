#!/usr/bin/perl

##############################################################################
# wdaemon.pl 
# A cron-like daemon for win32 systems
# (c) 2010,2011 Werner Süß
# mailto:suess_w@gmx.net
#
my $logfile="d:\\bin\\wdaemon\\wdaemon.log";   # FIXME
#
##############################################################################

use warnings;
use strict;
use threads qw(stringify);
use Log::Log4perl qw(:easy);

Log::Log4perl->easy_init(
{
   #levels from low to high:
    level => $DEBUG,
    level => $INFO,
   #level => $WARN,
   #level => $ERROR,
   #level => $FATAL,
    file => ">> $logfile",
   #file => 'stdout',
    mode => "append",
    layout => "%d %p> %m%n",
   }
);
my $log = get_logger;
my $rc_file = "wdaemon.rc";
my @entry;

if ( ! -e $rc_file) { $log->error("rc-file not found: $!") && die(); }

# rc auslesen
open(FILE, "< $rc_file");
    while (<FILE>) {
        chomp;
        my $current = $_;
        if ($current =~ /^#/ || $current eq "" ) {
            #ignoring
            DEBUG("Ignoring line ($current)");
        } else {
            $log->info("$current");
            my @tmp = split(/;/,$current);
            push(@entry,$tmp[0]);
        }
    }
close(FILE);

# Threads mal erzeugen
foreach(@entry) {
    my $thr = threads->new(\&create_thread, "$_");
    $thr->detach;
    #print "done.\n";
}

# den daemon am leben erhalten :)
while(1) {
    $log->info("$0: I am still alive ...");
    sleep(120); #FIXME
}





################################
sub create_thread {
################################
    
    my ($entry_number) = @_;
    my $command = get_call($entry_number);
    my @command = split(/ /,$command);
    my $sleeptime = get_intervall($entry_number);

    while(1) {
        $log->info("Thread $entry_number awaking.");
        $log->info("calling @command");
        #system(@command) || $log->warn("Problem running [$command] (maybe a shell-buidin?): $!");
        open(FH,"-|","@command") || $log->warn("Problem running [$command] (maybe a shell-buidin?): $!");
        while(<FH>) {
        my $out .= $_;
        my $timestamp = localtime();
        print "($timestamp): $out";
        #$c++;
        }
        close(FH);
        $log->info("Thread $entry_number sleeps for $sleeptime seconds.");
        sleep($sleeptime);
    }
    
}


################################
sub get_call {
################################
    $log->debug("get_call");
    my ($num_entry) = @_;
    open(FILE, "< $rc_file") || $log->error("Cannot open rc-file: $!");
    my @array;
    while (<FILE>) {
        chomp;
        my $current = $_;
        if ($current =~ /^#/) {
            #ignoring
        } else {
            if ( $current =~ /^$num_entry/) {
                #$log->info("$current");
                @array = split(/;/,$current);
            } else {
                #$log->error("entry $num_entry not found.");
            }
        }    
    }
    close(FILE);
    return my $command = $array[1];
    #return $command;
}


################################
sub get_intervall {
################################
    $log->debug("get_intervall");
    my ($num_entry) = @_;
    open(FILE, "< $rc_file") || $log->error("Cannot open rc-file: $!");
    my @array;
    while (<FILE>) {
        chomp;
        my $current = $_;
        if ($current =~ /^#/) {
            #ignoring
        } else {
            if ( $current =~ /^$num_entry/) {
                #$log->info("$current");
                @array = split(/;/,$current);
            } else {
                #$log->error("entry $num_entry not found.");
            }
        }
    }
    close(FILE);
    return my $intervall = $array[2];
    #return $intervall;
}






















=pod

REGEDIT4
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wdaemon\Parameters]
"Application"="d:\\bin\\perl\\bin\\perl.exe"
"AppDirectory"="d:\\bin\\wdaemon"
"AppParameters"="wdaemon.pl wdaemon.rc"

=cut
