package Ego::Controller::Error;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub process :Private {
    my ( $self, $c ) = @_;
    $c->clear_errors;
    $c->response->status(503);
    $c->response->body("O NOES");
}

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#}

__PACKAGE__->meta->make_immutable;

1;

__END__
