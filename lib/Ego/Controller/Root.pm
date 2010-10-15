package Ego::Controller::Root;
use Moose;
use namespace::autoclean;
BEGIN { extends "Catalyst::Controller" }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
      if ( $c->authenticate() )
      {
          $c->flash(message => "You signed in with OpenID!");
      }
      else
      {
          # Present OpenID form.
      }

}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->go("Error", [ 404 ]);
}

sub render :ActionClass("RenderView") {}

sub end :Private {
    my ( $self, $c ) = @_;

    # No errors so far, render.
    $c->forward("render") unless @{$c->error};

    # If there was an error in the render, process it and re-render.
    if ( @{ $c->error } )
    {
        warn @{ $c->error };
        $c->forward("Error");
        $c->forward("render");
        $c->clear_errors;
    }

    # Still something wrong!? Plain text time.
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

