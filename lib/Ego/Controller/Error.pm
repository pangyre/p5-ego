package Ego::Controller::Error;
use Moose;
use namespace::autoclean;
use HTTP::Status qw(:constants :is status_message);

BEGIN { extends 'Catalyst::Controller' }

sub process :Private {
    my ( $self, $c, $status, @err ) = @_;
    $c->response->status( $status ||= HTTP_INTERNAL_SERVER_ERROR );

    my $msg = join("\n", @err);
    # access control here? 
    $msg ||= join("\n", @{$c->error});
    $msg ||= status_message($status);

    $c->stash( template => "error/generic.tt",
               message => $msg,
               title => join(" \x{b7} ",
                             $c->config->{name},
                             $status,
                             status_message($status), )
        );

    $c->clear_errors;
    $c->forward("/render");

}

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#}

__PACKAGE__->meta->make_immutable;

1;

__END__
