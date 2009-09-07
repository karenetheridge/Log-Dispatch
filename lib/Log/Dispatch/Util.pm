package Log::Dispatch::Util;
use Data::Dumper;
use strict;
use warnings;
use base qw(Exporter);

our @EXPORT_OK = qw(
  cmp_deeply
  dump_one_line
  require_dynamic
);

sub cmp_deeply {
    my ( $ref1, $ref2, $name ) = @_;

    my $tb = Test::Builder->new();
    $tb->is_eq( dump_one_line($ref1), dump_one_line($ref2), $name );
}

sub dump_one_line {
    my ($value) = @_;

    return Data::Dumper->new( [$value] )->Indent(0)->Sortkeys(1)->Quotekeys(0)
      ->Terse(1)->Dump();
}

sub require_dynamic {
    my ($class) = @_;

    unless ( defined( eval "require $class" ) )
    {    ## no critic (ProhibitStringyEval)
        die $@;
    }
}

1;

__END__

=head1 NAME

Log::Dispatch::Util - Utilities used internally by Log::Dispatch

=head1 METHODS

=over

=item cmp_deeply

A cheap version of Test::Deep::cmp_deeply.

=item dump_one_line

Dump a value to a single line using Data::Dumper.

=item require_dynamic

Require a module dynamically.

=cut
