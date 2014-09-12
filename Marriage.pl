package Marriage;
use feature 'say';
use strict;
use warnings;

=head1 Marriage

    The Marriage Class :D Run this or instantiate your own object!
    usage: new Marriage(stressed => 1, exhausted => 0, pregnant => 0);
    This code is available at: https://github.com/lizndavid/wedding.git

=cut

our $congratulations = "Congratulations on tying the knot Liz & David! ".
"May your future together be blessed with love & happiness";

sub new {
    my $marriage = shift;
    my %right_now = @_;
    my $self = {};

    say $congratulations."\n";
    bless $self, $marriage;

    my $normality = { stressed => 0, pregnant => 0, exhausted => 0 };

    foreach (keys %$normality) {
        $self->{$_} = defined $right_now{$_} ?  $right_now{$_} : $normality->{$_};
    }

    if($self->{stressed}) {
        say "Feeling stressed? not good! finding cure...";
        $self->get_smashed();
        $self->make_love();
    }

    if(!$self->{exhausted}) {
        say "Excess energy? lets go!!";
        do { $self->make_love() } while ( !$self->is_pregnant() );
    }

    $self->give_birth() if $self->is_pregnant();

    return $self;
}

sub divorce { die "Method will not be implemented!" }
sub cheat { die "Sorry this method is deprecated!" }
sub is_pregnant { shift->{pregnant} }
sub has_twins { shift->{pregnant} == 2 }
sub has_triplets { shift->{pregnant} == 3 }

sub give_birth {
    my $liz = shift;
    return if ! $liz->is_pregnant();

    if($liz->has_twins() || $liz->has_triplets()) {
        say "You didn't get off that easy! There's more to come fool!";
        say "But what has David been eating? I need me some of that!\n";
        warn "If this is happening too often, feel free to refactor the make_love() method.\n\n";
        --$liz->{pregnant};
        $liz->give_birth(); # recursive
    } else {
        $liz->{pregnant} = 0;
        my @baby_tasks = qw/spend_money find_school do_school_run teach_perl buy_earplugs/;
        say "Generating Marriage sub-class... Please implement the following methods: ";
        say join(' ',@baby_tasks) . "\n";
    }
}
sub make_love {
    my $self = shift;
    say "Time to make love!";
    if($self->{pregnant}) { warn "Daamn! Y'all just be easy now!\n\n" }
    say "ooh aahhh ooooh!!!";
    $self->{stressed}  = 0; $self->{exhausted} = 1;
    $self->{pregnant}  = int(rand(4));
    say "Something special is on the horizon! or should I say, Someone!\n" if $self->{pregnant};
}
sub get_smashed {
    my $self = shift;
    say "Time to get smashed!";
    if($self->is_pregnant()) {
        die "You shouldn't get smashed and have babies!\n";
    }
    if($self->{stressed}) {
        say "Good choice! Now please run make_love() method to reconcile object properties.\n";
        $self->{stressed} = 0;
        $self->{exhausted} = 1;
    }
}
1;

=head1 AUTHOR

 Nathaniel

=cut

package main;
new Marriage(stressed => 0, exhausted => 0, pregnant => 0);
