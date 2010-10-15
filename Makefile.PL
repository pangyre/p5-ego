#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Ego';
all_from 'lib/Ego.pm';
repository "git://github.com/pangyre/p5-ego";

requires 'Catalyst::Runtime' => '5.80027';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires "Catalyst::View::TT";
requires "Catalyst::View::JSON";
requires "Catalyst::Runtime" => "5.80007";
requires "Catalyst::Plugin::ConfigLoader";
requires "Catalyst::Plugin::Encode::Unicode";


#build_requires "Pod::Spell";
#build_requires "Test::Spelling";
#requires "Catalyst::Plugin::ConfigLoader::Multi";

requires "Catalyst::Plugin::Static::Simple";
requires "Catalyst::Action::RenderView";
#requires "Catalyst::Controller::REST";
#requires "Catalyst::Plugin::Authorization::Roles";

#requires "CHI";
#requires "Catalyst::Plugin::Authentication";
#requires "Catalyst::Plugin::Session::State::Cookie";
#requires "Catalyst::Plugin::Session";
#requires "Catalyst::Authentication::Realm::SimpleDB"; # I think this is a BUG!
#requires "Catalyst::View::TT::Alloy";

#requires "HTML::FormFu::Model::DBIC";
#requires "FCGI::ProcManager";
#requires "DBIx::Class::ResultSet::HashRef";

#requires "Lingua::EN::Numbers";
#requires "Number::Format";
#requires "HTML::FormFu";
#requires "Catalyst::Controller::HTML::FormFu";

#requires "MIME::Lite";

#requires "Data::UUID";
#requires "DBIx::Class::EncodedColumn";

requires "Class::MOP" => 0.92;
requires "Moose" => 0.89;
requires "parent";
requires "YAML::XS";
requires "DBIx::Class" => 0.081;
#requires "DBIx::Class::EncodedColumn";
#requires "Crypt::Eksblowfish::Bcrypt";
requires "JSON::XS";
#requires "XML::LibXML";
requires "URI";
#requires "CatalystX::Plugin::Blurb";
#requires "DateTime::Format::SQLite";

#requires "Catalyst::Plugin::RequireSSL";

recommends "Catalyst::Manual";
recommends "Archive::Zip";
recommends "IPC::Run";
recommends "File::Find::Rule";
recommends "Pod::POM";
recommends "Proc::ProcessTable";
recommends "IPC::Run";
recommends "Schedule::At";
recommends "LWPx::ParanoidAgent";
#recommends "Catalyst::Plugin::Authentication::Credential::OpenID";

#requires "URI::QueryParam";

test_requires "HTTP::Request::Common";
test_requires "Test::WWW::Mechanize::Catalyst";

catalyst;

if ( $Module::Install::AUTHOR )
{
    system("pod2text lib/Yesh.pm > README") == 0
        or die "Couldn't update the README file";
    system("pod2text lib/Yesh/Manual/ReleaseNotes.pod > Changes") == 0
        or die "Couldn't update the Changes file";
}

#Create dirs qw( etc var...? )

#install_script glob("script/*.pl");

auto_install;

WriteAll;

__END__

# requires "Catalyst::Authentication::Realm::SimpleDB";


test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
