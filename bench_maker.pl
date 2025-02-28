#!/usr/bin/env perl
use strict;
use warnings;

use v5.36;

# my @configs = ([1_000_000, 1], [100_000, 10], [10_000, 100], [1_000, 1_000], [100, 10_000], [10, 100_000], [1, 1_000_000]);
# my @configs = ([100000, 1], [10000, 10], [1000, 100], [100, 1000], [10, 10000], [1, 100000]);
my @configs = ([10000, 1], [1000, 10], [100, 100], [10, 1000], [1, 10000]);

open my $fh, '>', "lib/autogen_benchmarks.ex"
  or die "Could not open benchmark file";

print $fh "defmodule AutogenBenchmarks do\n";

for my $conf (@configs) {
  my $runner = fmt_runner($conf->[0], $conf->[1]);
  print $fh $runner;

  my $code = fmt($conf->[0], $conf->[1]);
  my ($x, $y) = ($conf->[0], $conf->[1]);
  open my $mod_fh, '>', "lib/autogen_benchmarks/bench_${x}_${y}.ex"
    or die "Could not open file";
  print $mod_fh $code;
  close $mod_fh;
}

print $fh "\nend\n";

close $fh;

sub fmt_runner($try_blocks, $block_size, $mod_prefix = "Bench") {
  say "Building runner for $try_blocks $block_size";
  my $module = "$mod_prefix${try_blocks}x${block_size}";
  my $actor1 = "${module}Alice";
  my $actor2 = "${module}Bob";
  my $actor1_impl = "${actor1}Impl";
  my $actor2_impl = "${actor2}Impl";

  my $runner = "run_" . lc($module);

  return <<__runner__;
def $runner() do
  Chorex.start(${module}.Chorex, \%{$actor1 => $actor1_impl, $actor2 => $actor2_impl}, [])
end
__runner__
}

sub fmt($try_blocks, $block_size, $mod_prefix = "Bench") {
  my $module = "$mod_prefix${try_blocks}x${block_size}";
  say "Building $module";
  my $actor1 = "${module}Alice";
  my $actor2 = "${module}Bob";

  my $acc = "defmodule $module do\n";
  $acc .= "  import Chorex\n\n";
  $acc .= "  defchor [$actor1, $actor2] do\n";
  $acc .= "    def run() do\n";

  for my $block_idx (1..$try_blocks) {
    $acc .= "      try do\n";
    for my $block_size (1..$block_size) {
      $acc .= "        ${actor1}.(1) ~> ${actor2}.(x)\n";
      $acc .= "        ${actor2}.(x + 1) ~> ${actor1}.(y)\n";
      $acc .= "        ${actor1}.(y + 1)\n";
    }
    $acc .= "      rescue\n";
    $acc .= "        ${actor1}.(42)\n";
    $acc .= "        ${actor2}.(42)\n";
    $acc .= "      end\n";
  }

  $acc .= "    ${actor1}.(1)\n";
  $acc .= "    ${actor2}.(2)\n";
  $acc .= "    end\n  end\nend\n\n";

  # done defining module; build the runner

  my $runner = "run_" . lc($module);
  my $actor1lc = lc $actor1;
  my $actor2lc = lc $actor2;
  my $actor1_impl = "${actor1}Impl";
  my $actor2_impl = "${actor2}Impl";

  $acc .=<<__impls__;
defmodule $actor1_impl do
  use $module.Chorex, :$actor1lc
end

defmodule $actor2_impl do
  use $module.Chorex, :$actor2lc
end

__impls__

  return $acc;
}
