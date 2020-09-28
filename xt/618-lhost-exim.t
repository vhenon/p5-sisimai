use strict;
use warnings;
use Test::More;
use lib qw(./lib ./blib/lib);
require './t/600-lhost-code';

my $enginename = 'Exim';
my $samplepath = sprintf("./set-of-emails/private/lhost-%s", lc $enginename);
my $enginetest = Sisimai::Lhost::Code->maketest;
my $isexpected = [
    { 'n' => '01001', 'r' => qr/policyviolation/ },
    { 'n' => '01002', 'r' => qr/expired/         },
    { 'n' => '01003', 'r' => qr/filtered/        },
    { 'n' => '01004', 'r' => qr/blocked/         },
    { 'n' => '01005', 'r' => qr/userunknown/     },
    { 'n' => '01006', 'r' => qr/filtered/        },
    { 'n' => '01007', 'r' => qr/policyviolation/ },
    { 'n' => '01008', 'r' => qr/userunknown/     },
    { 'n' => '01009', 'r' => qr/hostunknown/     },
    { 'n' => '01010', 'r' => qr/blocked/         },
    { 'n' => '01011', 'r' => qr/userunknown/     },
    { 'n' => '01012', 'r' => qr/userunknown/     },
    { 'n' => '01013', 'r' => qr/userunknown/     },
    { 'n' => '01014', 'r' => qr/expired/         },
    { 'n' => '01015', 'r' => qr/expired/         },
    { 'n' => '01016', 'r' => qr/userunknown/     },
    { 'n' => '01017', 'r' => qr/expired/         },
    { 'n' => '01018', 'r' => qr/userunknown/     },
    { 'n' => '01019', 'r' => qr/userunknown/     },
    { 'n' => '01020', 'r' => qr/userunknown/     },
    { 'n' => '01022', 'r' => qr/userunknown/     },
    { 'n' => '01023', 'r' => qr/userunknown/     },
    { 'n' => '01024', 'r' => qr/userunknown/     },
    { 'n' => '01025', 'r' => qr/userunknown/     },
    { 'n' => '01026', 'r' => qr/userunknown/     },
    { 'n' => '01027', 'r' => qr/expired/         },
    { 'n' => '01028', 'r' => qr/mailboxfull/     },
    { 'n' => '01029', 'r' => qr/userunknown/     },
    { 'n' => '01031', 'r' => qr/expired/         },
    { 'n' => '01032', 'r' => qr/userunknown/     },
    { 'n' => '01033', 'r' => qr/userunknown/     },
    { 'n' => '01034', 'r' => qr/userunknown/     },
    { 'n' => '01035', 'r' => qr/rejected/        },
    { 'n' => '01036', 'r' => qr/userunknown/     },
    { 'n' => '01037', 'r' => qr/expired/         },
    { 'n' => '01038', 'r' => qr/blocked/         },
    { 'n' => '01039', 'r' => qr/mailboxfull/     },
    { 'n' => '01040', 'r' => qr/expired/         },
    { 'n' => '01041', 'r' => qr/expired/         },
    { 'n' => '01042', 'r' => qr/networkerror/    },
    { 'n' => '01043', 'r' => qr/userunknown/     },
    { 'n' => '01044', 'r' => qr/networkerror/    },
    { 'n' => '01045', 'r' => qr/hostunknown/     },
    { 'n' => '01046', 'r' => qr/userunknown/     },
    { 'n' => '01047', 'r' => qr/userunknown/     },
    { 'n' => '01049', 'r' => qr/suspend/         },
    { 'n' => '01050', 'r' => qr/userunknown/     },
    { 'n' => '01051', 'r' => qr/userunknown/     },
    { 'n' => '01053', 'r' => qr/userunknown/     },
    { 'n' => '01054', 'r' => qr/suspend/         },
    { 'n' => '01055', 'r' => qr/userunknown/     },
    { 'n' => '01056', 'r' => qr/userunknown/     },
    { 'n' => '01057', 'r' => qr/suspend/         },
    { 'n' => '01058', 'r' => qr/userunknown/     },
    { 'n' => '01059', 'r' => qr/onhold/          },
    { 'n' => '01060', 'r' => qr/expired/         },
    { 'n' => '01061', 'r' => qr/userunknown/     },
    { 'n' => '01062', 'r' => qr/userunknown/     },
    { 'n' => '01063', 'r' => qr/userunknown/     },
    { 'n' => '01064', 'r' => qr/userunknown/     },
    { 'n' => '01065', 'r' => qr/userunknown/     },
    { 'n' => '01066', 'r' => qr/userunknown/     },
    { 'n' => '01067', 'r' => qr/userunknown/     },
    { 'n' => '01068', 'r' => qr/userunknown/     },
    { 'n' => '01069', 'r' => qr/userunknown/     },
    { 'n' => '01070', 'r' => qr/userunknown/     },
    { 'n' => '01071', 'r' => qr/userunknown/     },
    { 'n' => '01072', 'r' => qr/userunknown/     },
    { 'n' => '01073', 'r' => qr/suspend/         },
    { 'n' => '01074', 'r' => qr/userunknown/     },
    { 'n' => '01075', 'r' => qr/userunknown/     },
    { 'n' => '01076', 'r' => qr/userunknown/     },
    { 'n' => '01077', 'r' => qr/suspend/         },
    { 'n' => '01078', 'r' => qr/undefined/       },
    { 'n' => '01079', 'r' => qr/hostunknown/     },
    { 'n' => '01080', 'r' => qr/hostunknown/     },
    { 'n' => '01081', 'r' => qr/hostunknown/     },
    { 'n' => '01082', 'r' => qr/onhold/          },
    { 'n' => '01083', 'r' => qr/onhold/          },
    { 'n' => '01084', 'r' => qr/systemerror/     },
    { 'n' => '01085', 'r' => qr/(?:undefined|onhold|blocked)/ },
    { 'n' => '01086', 'r' => qr/onhold/          },
    { 'n' => '01087', 'r' => qr/onhold/          },
    { 'n' => '01088', 'r' => qr/(?:systemerror|onhold)/ },
    { 'n' => '01089', 'r' => qr/mailererror/     },
    { 'n' => '01090', 'r' => qr/onhold/          },
    { 'n' => '01091', 'r' => qr/onhold/          },
    { 'n' => '01092', 'r' => qr/undefined/       },
    { 'n' => '01093', 'r' => qr/(?:undefined|onhold|systemerror)/ },
    { 'n' => '01094', 'r' => qr/onhold/          },
    { 'n' => '01095', 'r' => qr/undefined/       },
    { 'n' => '01096', 'r' => qr/(?:hostunknown|onhold)/ },
    { 'n' => '01097', 'r' => qr/(?:hostunknown|networkerror)/ },
    { 'n' => '01098', 'r' => qr/expired/         },
    { 'n' => '01099', 'r' => qr/expired/         },
    { 'n' => '01100', 'r' => qr/mailererror/     },
    { 'n' => '01101', 'r' => qr/mailererror/     },
    { 'n' => '01102', 'r' => qr/mailererror/     },
    { 'n' => '01103', 'r' => qr/undefined/       },
    { 'n' => '01104', 'r' => qr/mailererror/     },
    { 'n' => '01105', 'r' => qr/mailererror/     },
    { 'n' => '01106', 'r' => qr/onhold/          },
    { 'n' => '01107', 'r' => qr/spamdetected/    },
    { 'n' => '01108', 'r' => qr/policyviolation/ },
    { 'n' => '01109', 'r' => qr/userunknown/     },
    { 'n' => '01110', 'r' => qr/hostunknown/     },
    { 'n' => '01111', 'r' => qr/blocked/         },
    { 'n' => '01112', 'r' => qr/blocked/         },
    { 'n' => '01113', 'r' => qr/blocked/         },
    { 'n' => '01114', 'r' => qr/blocked/         },
    { 'n' => '01115', 'r' => qr/rejected/        },
    { 'n' => '01116', 'r' => qr/hostunknown/     },
    { 'n' => '01117', 'r' => qr/blocked/         },
    { 'n' => '01118', 'r' => qr/blocked/         },
    { 'n' => '01119', 'r' => qr/blocked/         },
    { 'n' => '01120', 'r' => qr/blocked/         },
    { 'n' => '01121', 'r' => qr/blocked/         },
    { 'n' => '01122', 'r' => qr/rejected/        },
    { 'n' => '01123', 'r' => qr/mailererror/     },
    { 'n' => '01124', 'r' => qr/rejected/        },
    { 'n' => '01125', 'r' => qr/blocked/         },
    { 'n' => '01126', 'r' => qr/blocked/         },
    { 'n' => '01127', 'r' => qr/rejected/        },
    { 'n' => '01128', 'r' => qr/blocked/         },
    { 'n' => '01129', 'r' => qr/rejected/        },
    { 'n' => '01130', 'r' => qr/rejected/        },
    { 'n' => '01131', 'r' => qr/syntaxerror/     },
    { 'n' => '01132', 'r' => qr/mailererror/     },
    { 'n' => '01133', 'r' => qr/blocked/         },
    { 'n' => '01134', 'r' => qr/spamdetected/    },
    { 'n' => '01135', 'r' => qr/blocked/         },
    { 'n' => '01136', 'r' => qr/rejected/        },
    { 'n' => '01137', 'r' => qr/userunknown/     },
    { 'n' => '01138', 'r' => qr/blocked/         },
    { 'n' => '01139', 'r' => qr/rejected/        },
    { 'n' => '01140', 'r' => qr/toomanyconn/     },
    { 'n' => '01141', 'r' => qr/filtered/        },
    { 'n' => '01142', 'r' => qr/virusdetected/   },
    { 'n' => '01143', 'r' => qr/userunknown/     },
    { 'n' => '01144', 'r' => qr/(?:blocked|onhold)/ },
    { 'n' => '01145', 'r' => qr/mesgtoobig/      },
    { 'n' => '01146', 'r' => qr/userunknown/     },
    { 'n' => '01147', 'r' => qr/blocked/         },
    { 'n' => '01148', 'r' => qr/spamdetected/    },
    { 'n' => '01149', 'r' => qr/rejected/        },
    { 'n' => '01150', 'r' => qr/blocked/         },
    { 'n' => '01151', 'r' => qr/suspend/         },
    { 'n' => '01152', 'r' => qr/blocked/         },
    { 'n' => '01153', 'r' => qr/blocked/         },
    { 'n' => '01154', 'r' => qr/blocked/         },
    { 'n' => '01155', 'r' => qr/blocked/         },
    { 'n' => '01156', 'r' => qr/blocked/         },
    { 'n' => '01157', 'r' => qr/spamdetected/    },
    { 'n' => '01158', 'r' => qr/filtered/        },
    { 'n' => '01159', 'r' => qr/spamdetected/    },
    { 'n' => '01160', 'r' => qr/(?:blocked|userunknown|onhold)/ },
    { 'n' => '01161', 'r' => qr/mesgtoobig/      },
    { 'n' => '01162', 'r' => qr/blocked/         },
    { 'n' => '01163', 'r' => qr/mailboxfull/     },
    { 'n' => '01164', 'r' => qr/blocked/         },
    { 'n' => '01165', 'r' => qr/spamdetected/    },
    { 'n' => '01166', 'r' => qr/(?:hostunknown|expired|undefined)/ },
    { 'n' => '01167', 'r' => qr/(?:onhold|undefined|mailererror)/ },
    { 'n' => '01168', 'r' => qr/expired/         },
    { 'n' => '01169', 'r' => qr/systemerror/     },
    { 'n' => '01170', 'r' => qr/systemerror/     },
    { 'n' => '01171', 'r' => qr/mailboxfull/     },
    { 'n' => '01172', 'r' => qr/hostunknown/     },
    { 'n' => '01173', 'r' => qr/networkerror/    },
    { 'n' => '01174', 'r' => qr/(?:expired|systemerror)/ },
    { 'n' => '01175', 'r' => qr/expired/         },
    { 'n' => '01176', 'r' => qr/userunknown/     },
    { 'n' => '01177', 'r' => qr/filtered/        },
    { 'n' => '01178', 'r' => qr/expired/         },
    { 'n' => '01179', 'r' => qr/mailererror/     },
    { 'n' => '01180', 'r' => qr/blocked/         },
    { 'n' => '01181', 'r' => qr/mailererror/     },
    { 'n' => '01182', 'r' => qr/userunknown/     },
    { 'n' => '01183', 'r' => qr/mailboxfull/     },
    { 'n' => '01184', 'r' => qr/userunknown/     },
    { 'n' => '01185', 'r' => qr/suspend/         },
    { 'n' => '01186', 'r' => qr/userunknown/     },
    { 'n' => '01187', 'r' => qr/hostunknown/     },
];

plan 'skip_all', sprintf("%s not found", $samplepath) unless -d $samplepath;
$enginetest->($enginename, $isexpected, 1, 0);
done_testing;

