package Ego;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw(
                Unicode::Encoding
                ConfigLoader
                Static::Simple
              );

extends "Catalyst";

our $VERSION = "0.01";
$VERSION = eval $VERSION;

__PACKAGE__->config(
    name => "Ego",
    disable_component_resolution_regex_fallback => 1,
    "View::TT" => {
        INCLUDE_PATH => [ __PACKAGE__->path_to("root/tt/src"),
                          __PACKAGE__->path_to("root/tt") ],
        WRAPPER => "lib/html5.tt",
    },
);

# Start the application
__PACKAGE__->setup();

1;

__END__

=head1 NAME

Ego - Catalyst based application

=head1 SYNOPSIS

    script/ego_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Ego::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Ashley Pond V.

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
