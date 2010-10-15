package Ego::Controller::Root;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->detach("Error");
}

sub render :ActionClass("RenderView") {}

sub end :Private {
    my ( $self, $c ) = @_;

    $c->forward("render") unless @{$c->error};
    # If there was an error in the render, process it and re-render.
    if ( @{$c->error} )
    {
        $c->forward("Error") and $c->forward("render");
    }

    # If there is a new error at this point, it's time to redirect to
    # a static page or do something terribly simple...
}

__PACKAGE__->meta->make_immutable;

1;

__END__

