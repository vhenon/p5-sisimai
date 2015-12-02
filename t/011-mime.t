use strict;
use Test::More;
use lib qw(./lib ./blib/lib);
use Sisimai::MIME;
use Encode;

my $PackageName = 'Sisimai::MIME';
my $MethodNames = {
    'class' => [ 'is_mimeencoded', 'mimedecode', 'boundary', 'qprintd', 'base64d' ],
    'object' => [],
};

use_ok $PackageName;
can_ok $PackageName, @{ $MethodNames->{'class'} };

MAKE_TEST: {
    my $v0  = '';
    my $p1 = 'ASCII TEXT';
    my $p2 = '白猫にゃんこ';
    my $p3 = 'ニュースレター';
    my $b2 = '=?utf-8?B?55m954yr44Gr44KD44KT44GT?=';
    my $q3 = '=?utf-8?Q?=E3=83=8B=E3=83=A5=E3=83=BC=E3=82=B9=E3=83=AC=E3=82=BF=E3=83=BC?=';

    is $PackageName->is_mimeencoded( \$p1 ), 0, '->mimeencoded = 0';
    is $PackageName->is_mimeencoded( \$p2 ), 0, '->mimeencoded = 0';
    is $PackageName->is_mimeencoded( \$b2 ), 1, '->mimeencoded = 1';
    is $PackageName->is_mimeencoded( \$q3 ), 1, '->mimeencoded = 1';

    for my $e ( $p1, $p2 ) {
        $v0 = $PackageName->mimedecode( [ $e ] );
        $v0 = Encode::encode_utf8 $v0 if utf8::is_utf8 $v0;
        is $v0, $e, '->mimedecode = '.$e;
    }

    $v0 = $PackageName->mimedecode( [ $b2 ] );
    $v0 = Encode::encode_utf8 $v0 if utf8::is_utf8 $v0;
    is $v0, $p2, '->mimedecode = '.$p2;

    $v0 = $PackageName->mimedecode( [ $q3 ] );
    $v0 = Encode::encode_utf8 $v0 if utf8::is_utf8 $v0;
    is $v0, $p3, '->mimedecode = '.$p3;

    # MIME-Encoded text in multiple lines
    my $p4 = '何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。';
    my $b4 = [
        '=?utf-8?B?5L2V44Gn44KC6JaE5pqX44GE44GY44KB44GY44KB44GX44Gf5omA?=',
        '=?utf-8?B?44Gn44OL44Oj44O844OL44Oj44O85rOj44GE44Gm44GE44Gf5LqL?=',
        '=?utf-8?B?44Gg44GR44Gv6KiY5oa244GX44Gm44GE44KL44CC?=',
    ];
    $v0 = $PackageName->mimedecode( $b4 );
    $v0 = Encode::encode_utf8 $v0 if utf8::is_utf8 $v0;
    is $v0, $p4, '->mimedecode = '.$p4;

    # Other encodings
    my $b5 = [
        '=?Shift_JIS?B?keWK24+8jeKJriAxMJackGyCyYKolIOVqIyUscDZDQo=?=',
        '=?ISO-2022-JP?B?Ym91bmNlSGFtbWVyGyRCJE41IUc9TVdLPhsoQg==?=',
    ];

    for my $e ( @$b5 ) {
        $v0 = $PackageName->mimedecode( [ $e ] );
        $v0 = Encode::encode_utf8 $v0 if utf8::is_utf8 $v0;
        chomp $v0;
        ok length $v0, '->mimedecode = '.$v0;
    }

    # Base64, Quoted-Printable
    my $b6 = '44Gr44KD44O844KT';
    my $p6 = 'にゃーん';
    is $PackageName->base64d( \$b6 ), $p6, '->base64d = '.$p6;
    is $PackageName->qprintd( \'=4e=65=6b=6f' ), 'Neko', '->qprintd = Neko';


    my $x1 = 'Content-Type: multipart/mixed; boundary=Apple-Mail-1-526612466';
    my $x2 = 'Apple-Mail-1-526612466';
    is $PackageName->boundary( $x1 ), $x2, '->boundary() = '.$x2;
    is $PackageName->boundary( $x1, 0 ), '--'.$x2, '->boundary(0) = --'.$x2;
    is $PackageName->boundary( $x1, 1 ), '--'.$x2.'--', '->boundary(1) = --'.$x2.'--';
    is $PackageName->boundary( $x1, 2 ), '--'.$x2.'--', '->boundary(2) = --'.$x2.'--';
}

done_testing;
