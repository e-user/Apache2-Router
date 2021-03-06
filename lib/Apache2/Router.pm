package Apache2::Router;

=head1 NAME

Apache2::Router - ROR style mod_perl router/dispatcher

=head1 SYNOPSIS

Blablabla.

=head1 DESCRIPTION

Blablabla.

=head1 COPYRIGHT

Copyright (C) 2010  Alexander Kahl <e-user@fsfe.org>

Apache2-Router is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation; either version 3 of the
License, or (at your option) any later version.

Apache2-Router is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=head1 AUTHOR

Alexander Kahl <e-user@fsfe.org>

=cut

use 5.008;
use strict;
use warnings;

use Apache2::Const -compile => qw (DECLINED OK);
use Apache2::Module;
use Apache2::RequestRec;
use Apache2::Router::Parameters qw (module_config);
use Apache2::Router::Routes qw (router);
use Apache2::Router::Util qw (log);

sub route
  {
    my ($self, $r) = @_;

    my $debug = 1; # module_config ($r, 'RouteDebug');
    my $router = router ($r, module_config ($r, 'RouteFiles'));
    my ($match, $route) = $router->routematch ($r->uri);

    if (defined $match)
      {
        log sprintf ('[%s] matched pattern [%s]', $r->uri, $route->{pattern}) if $debug;
        return Apache2::Const::OK;
      }
    else
      {
        log sprintf ('[%s] matched no pattern', $r->uri) if $debug;

        return Apache2::Const::DECLINED;
      }
  }

1
