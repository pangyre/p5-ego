#!/usr/bin/env perl
use strict;
use warnings;
use Ego;

Ego->setup_engine('PSGI');
my $app = sub { Ego->run(@_) };

