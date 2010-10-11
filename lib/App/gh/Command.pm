package App::gh::Command;
use warnings;
use strict;
use App::gh::Utils;
use base qw(App::CLI App::CLI::Command);

sub alias {
    (
        "all" => "cloneall"
    );
}

sub invoke {
    my ($pkg, $cmd, @args) = @_;
    local *ARGV = [$cmd, @args];
    my $ret = eval {
        $pkg->dispatch();
    };
    if( $@ ) {
        warn $@;
    }
}

sub gen_uri {
    my ($self,$acc,$repo) = @_;

    if( $self->{protocal_ssh} ) {
        return sprintf( 'git@github.com:%s/%s.git' , $acc, $repo );
    }
    elsif( $self->{protocal_http} ) {
        return sprintf( 'http://github.com/%s/%s.git' , $acc , $repo );
    }
    elsif( $self->{protocal_https}) {
        return sprintf( 'https://github.com/%s/%s.git' , $acc , $repo );
    }
    elsif( $self->{protocal_git} ) {
        return sprintf( 'git://github.com/%s/%s.git', $acc, $repo );
    }
    return;
}

sub global_help {
    # XXX: scan command classes
    print <<'END';
App::gh


help                   
    - show help message

list [userid]          
    - list all repository of an user:

clone [userid] [repo] ([http|ro|ssh])
    - clone repository from an user

search [keyword] 
    - search repository:

all [userid]
    - to clone all repository of an user:

fork [userid] [repo]
    - to fork project:

fork
    - to fork current project:
        
network 
    -  to show fork network:

pull [userid] ([branch])
    - pull from other's fork:

END
}

1;
