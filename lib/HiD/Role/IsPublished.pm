package HiD::Role::IsPublished;
# ABSTRACT: Role to be consumed by classes that are published during processing
use Moose::Role;
use namespace::autoclean;

use File::Basename  qw/ fileparse /;
use HiD::Types;

requires 'output_filename';
requires 'publish';

=attr basename ( ro / isa = Str / lazily built from input_filename

=cut

has basename => (
  is      => 'ro',
  isa     => 'Str' ,
  lazy    => 1 ,
  default => sub {
    my $self = shift;
    my $ext = '.' . $self->ext;
    return fileparse( $self->input_filename , $ext );
  },
);

=attr dest_dir ( ro / isa = HiD_DirPath / required )

The path to the directory where the output_filename will be written.

=cut

has dest_dir => (
  is       => 'ro' ,
  isa      => 'HiD_DirPath' ,
  required => 1 ,
);

=attr ext ( ro / isa = HiD_FileExtension / lazily built from filename )

The extension on the input filename of the consuming object.

=cut

has ext => (
  is      => 'ro' ,
  isa     => 'HiD_FileExtension' ,
  lazy    => 1 ,
  default => sub {
    my $self = shift;
    my( $extension ) = $self->input_filename =~ m|\.([^.]+)$|;
    return $extension;
  },
);

=attr input_filename ( ro / isa = HiD_FilePath / required )

The path of the consuming object's file. Required for instantiation.

=cut

has input_filename => (
  is       => 'ro' ,
  isa      => 'HiD_FilePath' ,
  required => 1 ,
);

=attr url ( ro / isa = Str / lazily built from output_filename and dest_dir )

The URL to the output path for the written file.

=cut

has url => (
  is      => 'ro' ,
  isa     => 'Str' ,
  lazy    => 1 ,
  default => sub {
    my $self = shift;
    my $url  = $self->output_filename;
    my $dest_dir = $self->dest_dir;
    $url =~ s|^$dest_dir||;
    $url =~ s|index.html$||;
    return $url;
  },
);


no Moose::Role;
1;
