package Ego::Controller::Auth;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    if ( $c->authenticate() )
    {
        $c->flash(message => "You signed in with OpenID!");
        $c->response->redirect($c->uri_for("/"));
    }
}

sub out :Local :Args(0) {
    my ( $self, $c ) = @_;
    $c->delete_session;
    $c->go("/index");
}


__PACKAGE__->meta->make_immutable;

1;

__END__

