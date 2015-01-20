package CPANPR;

use strict;
use warnings;


sub load ($)
{
    my $file = shift;
    open my $f, '<:utf8', $file or die;
    my $content = do { local $/; <$f> };
    close $f;

    [
	map {
	    my %row;
	    @row{qw<member.url member.name dist.url dist.name author.url author.name repo.url repo.path>} =
		m!<td><a href='([^']*)'>([^>]*)</a></td>!g;
	    \%row
	}
	($content =~ m!<tr>(<td>\V*</td>)</tr>!g)
    ]
}

1;
