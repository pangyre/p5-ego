package Ego;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw(
                Unicode::Encoding
                ConfigLoader
                Static::Simple
    Authentication
    Session
    Session::Store::FastMmap
    Session::State::Cookie

              );

extends "Catalyst";

our $VERSION = "0.01";

__PACKAGE__->config(
    name => "Ego",
    # disable_component_resolution_regex_fallback => 1,
    "View::TT" => {
        INCLUDE_PATH => [ __PACKAGE__->path_to("root/tt/src"),
                          __PACKAGE__->path_to("root/tt") ],
        WRAPPER => "lib/html5.tt",
    },
    static => {
        debug => 1,
        include_path => [ __PACKAGE__->path_to('root', 'static') ],
        # ignore_extensions => [], # Turns all others, like html, on.
    },
    "Plugin::Authentication" => {
        default_realm => "openid",
        realms => {
            openid => {
                credential => {
                    class => "OpenID",
                    store => {
                        class => "OpenID",
                    },
                    # consumer_secret => "Don't bother setting",
                    ua_class => "LWPx::ParanoidAgent",
                    # whitelist is only relevant for LWPx::ParanoidAgent
                    ua_args => {
                        whitelisted_hosts => [qw/ 127.0.0.1 localhost /],
                    },
                    extensions => [
                        'http://openid.net/extensions/sreg/1.1',
                        {
                            required => 'email',
                            optional => 'fullname,nickname,timezone',
                        },
                        ],
                    flatten_extensions_into_user => 1,
                },
            },
        },
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
