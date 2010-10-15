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
    return;
    # If there was an error in the render, process it and re-render.
    $c->forward("Error") and $c->forward("render")
        if @{$c->error};

    if ( @{$c->error} )
    {
        my $mess = join("\n", @{$c->error});
        $c->response->content_type("text/plain");
        $c->response->body("Unrecoverable error. Fire the developer.\n\n"
                           . $mess );
        $c->clear_errors;
    }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

