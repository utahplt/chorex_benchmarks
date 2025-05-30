#!/usr/bin/env perl -*- mode: cperl -*-
use strict;
use warnings;

use v5.36;

my $worker_count = shift @ARGV;
$worker_count //= 100;

my @workers = map { "B${worker_count}Worker$_" } 1..$worker_count;
my $actor_list = join ', ', @workers;
my $actor_map =
  join ",\n", (map { "      B${worker_count}Worker$_ => B${worker_count}Worker${_}Impl" } 1..$worker_count);
$actor_map .= ",\n      Dispatch${worker_count} => Dispatch${worker_count}Impl";

my $dx = make_daisy_chain($worker_count, "x");
my $ws = join "\n\n", make_work_impls($worker_count);

my $full_mod =<<__FULL_MOD__;
defmodule BigChor${worker_count} do
  import Chorex

  defchor [Dispatch${worker_count}, $actor_list] do
    def run(Dispatch${worker_count}.(try?), B${worker_count}Worker1.(x)) do
      if Dispatch${worker_count}.(try?) do
        daisy_try(B${worker_count}Worker1.(x))
      else
        daisy_no_try(B${worker_count}Worker1.(x))
      end
    end

    def daisy_try(B${worker_count}Worker1.(x)) do
      try do
        with B${worker_count}Worker1.(y) <- work(B${worker_count}Worker1.(x)) do
          try do
            with B${worker_count}Worker1.(z) <- work(B${worker_count}Worker1.(y)) do
              try do
                work(B${worker_count}Worker1.(z))
              rescue
                B${worker_count}Worker1.(:boom2)
              end
            end
          rescue
            B${worker_count}Worker1.(:boom1)
          end
        end
      rescue
        B${worker_count}Worker1.(:boom0)
      end
    end

    def daisy_no_try(B${worker_count}Worker1.(x)) do
      with B${worker_count}Worker1.(y) <- work(B${worker_count}Worker1.(x)) do
        with B${worker_count}Worker1.(z) <- work(B${worker_count}Worker1.(y)) do
          work(B${worker_count}Worker1.(z))
        end
      end
    end

    def work(B${worker_count}Worker1.(x)) do
$dx
      B${worker_count}Worker1.(x)
    end
  end
end

$ws

defmodule Dispatch${worker_count}Impl do
  use BigChor.Chorex, :dispatch#{worker_count}
end

defmodule Big${worker_count}Runner do
  def run(start \\\\ 1, use_try? \\\\ true) do
    actor_map = %{
$actor_map
    }

    Chorex.start(BigChor${worker_count}.Chorex, actor_map, [start, use_try?])

    receive do
      {:chorex_return, B${worker_count}Worker1, _} = m ->
        m
    end
  end
end
__FULL_MOD__

say $full_mod;

sub make_daisy_chain($workers, $var_name) {
  my $daisy_chain = "";

  for my $i (1..$workers) {
    my $j = $i == $workers ? 1 : $i + 1;
    $daisy_chain .=<<__CHAIN__;
      B${worker_count}Worker$i.work_hard($var_name) ~> B${worker_count}Worker$j.($var_name)
__CHAIN__
  }

  return $daisy_chain;
}

sub make_work_impls($workers) {
  my $acc = "";

  for my $i (1..$workers) {
    $acc .=<<__WORKER__;
defmodule B${worker_count}Worker${i}Impl do
  use BigChor${worker_count}.Chorex, :b${worker_count}worker$i

  \@impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
__WORKER__
  }

  return $acc;
}
