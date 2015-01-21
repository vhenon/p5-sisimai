package Sisimai::Reason::NetworkError;
use feature ':5.10';
use strict;
use warnings;

sub text  { 'networkerror' }
sub match {
    my $class = shift;
    my $argvs = shift // return undef;
    my $regex = qr{(?:
         host[ ]is[ ]unreachable
        |mail[ ]forwarding[ ]loop[ ]for[ ]
        |maximum[ ]forwarding[ ]loop[ ]count[ ]exceeded
        |too[ ]many[ ]hops
        )
    }ix;

    return 1 if $argvs =~ $regex;
    return 0;
}

sub true { return undef };

1;
__END__

=encoding utf-8

=head1 NAME

Sisimai::Reason::NetworkError - Bounce reason is C<networkerror> or not.

=head1 SYNOPSIS

    use Sisimai::Reason::NetworkError;
    print Sisimai::Reason::NetworkError->match('554 5.4.6 Too many hops'); # 1

=head1 DESCRIPTION

Sisimai::Reason::NetworkError checks the bounce reason is C<networkerror> or not.
This class is called only Sisimai::Reason class.

=head1 CLASS METHODS

=head2 C<B<text()>>

C<text()> returns string: C<networkerror>.

    print Sisimai::Reason::NetworkError->text;  # networkerror

=head2 C<B<match( I<string> )>>

C<match()> returns 1 if the argument matched with patterns defined in this class.

    print Sisimai::Reason::NetworkError->match('5.3.5 System config error'); # 1

=head2 C<B<true( I<Sisimai::Data> )>>

C<true()> returns 1 if the bounce reason is C<networkerror>. The argument must be
Sisimai::Data object and this method is called only from Sisimai::Reason class.

=head1 AUTHOR

azumakuniyuki

=head1 COPYRIGHT

Copyright (C) 2014 azumakuniyuki E<lt>perl.org@azumakuniyuki.orgE<gt>,
All Rights Reserved.

=head1 LICENSE

This software is distributed under The BSD 2-Clause License.

=cut
