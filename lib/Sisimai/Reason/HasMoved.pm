package Sisimai::Reason::HasMoved;
use feature ':5.10';
use strict;
use warnings;

sub text  { 'hasmoved' }
sub match {
    my $class = shift;
    my $argvs = shift // return undef;
    my $regex = qr/The[ ]e[-]mail[ ]address[ ].+[ ]has[ ]been[ ]replaced[ ]by[ ]/ix;

    return 1 if $argvs =~ $regex;
    return 0;
}

sub true { return undef };

1;
__END__

=encoding utf-8

=head1 NAME

Sisimai::Reason::HasMoved - Bounce reason is C<hasmoved> or not.

=head1 SYNOPSIS

    use Sisimai::Reason::HasMoved;
    print Sisimai::Reason::HasMoved->match('address neko@example.jp has been replaced by ...');   # 1

=head1 DESCRIPTION

Sisimai::Reason::HasMoved checks the bounce reason is C<hasmoved> or not.
This class is called only Sisimai::Reason class.

=head1 CLASS METHODS

=head2 C<B<text()>>

C<text()> returns string: C<systemfull>.

    print Sisimai::Reason::HasMoved->text;  # hasmoved

=head2 C<B<match( I<string> )>>

C<match()> returns 1 if the argument matched with patterns defined in this class.

    print Sisimai::Reason::HasMoved->match('address cat@example.jp has been replaced by ');   # 1

=head2 C<B<true( I<Sisimai::Data> )>>

C<true()> returns 1 if the bounce reason is C<hasmoved>. The argument must be
Sisimai::Data object and this method is called only from Sisimai::Reason class.

=head1 AUTHOR

azumakuniyuki

=head1 COPYRIGHT

Copyright (C) 2015 azumakuniyuki E<lt>perl.org@azumakuniyuki.orgE<gt>,
All Rights Reserved.

=head1 LICENSE

This software is distributed under The BSD 2-Clause License.

=cut