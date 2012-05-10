package HiD::Types;
# ABSTRACT: HiD type constraints
use strict;
use warnings;

use Moose::Util::TypeConstraints;

subtype 'HiD_DirPath'
  => as 'Str'
  => where { -d $_ };

# TODO make this a bit more useful?
subtype 'HiD_FileExtension'
  => as 'Str' ,
  #=> where { what, exactly? }
  ;

subtype 'HiD_FilePath'
  => as 'Str'
  => where { -f $_ };

subtype 'HiD_PosInt'
  => as 'Int'
  => where { $_ > 0 }
  => message { "Must be positive integer." };

no Moose::Util::TypeConstraints;
1;
