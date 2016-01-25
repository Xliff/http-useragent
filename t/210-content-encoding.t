#!perl6

use v6;
use Test;
use HTTP::UserAgent;

plan 2;

if %*ENV<NETWORK_TESTING> {
    try require Compress::Zlib;
    if ::('Compress::Zlib::Stream') ~~ Failure {
        skip-rest("'Compress::Zlib' not installed won't test");
    }
    else {
        my $ua = HTTP::UserAgent.new;
        subtest {
            my $res;
            lives-ok { $res = $ua.get("http://httpbin.org/gzip") }, "get gzipped okay";
            like $res.content, /gzipped/, "and it is like the right thing";
        }, "gzipped fine";
        subtest {
            my $res;
            lives-ok { $res = $ua.get("http://httpbin.org/deflate") }, "get deflated okay";
            like $res.content, /deflated/, "and it is like the right thing";
        }, "deflated fine";
    }

}
else {
    skip-rest("'NETWORK_TESTING' not set");
}


done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
