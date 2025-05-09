#!/usr/bin/env perl
use strict;
use warnings;

use v5.36;

my $worker_count = 100;

my @workers = map { "Worker$_" } 1..$worker_count;
my $actor_list = join ', ', @workers;
my $actor_map =
  join ",\n", (map { "      Worker$_ => Worker${_}Impl" } 1..$worker_count);
$actor_map .= ",\n      Dispatch => DispatchImpl";

my $dx = make_daisy_chain($worker_count, "x");
my $ws = join "\n\n", make_work_impls($worker_count);

my $full_mod =<<__FULL_MOD__;
defmodule BigChor do
  import Chorex

  defchor [Dispatch, $actor_list] do
    def run(Dispatch.(try?), Worker1.(x)) do
      if Dispatch.(try?) do
        daisy_try(Worker1.(x))
      else
        daisy_no_try(Worker1.(x))
      end
    end

    def daisy_try(Worker1.(x)) do
      try do
        with Worker1.(y) <- work(Worker1.(x)) do
          try do
            with Worker1.(z) <- work(Worker1.(y)) do
              try do
                work(Worker1.(z))
              rescue
                Worker1.(:boom2)
              end
            end
          rescue
            Worker1.(:boom1)
          end
        end
      rescue
        Worker1.(:boom0)
      end
    end

    def daisy_no_try(Worker1.(x)) do
      with Worker1.(y) <- work(Worker1.(x)) do
        with Worker1.(z) <- work(Worker1.(y)) do
          work(Worker1.(z))
        end
      end
    end

    def work(Worker1.(x)) do
$dx
      Worker1.(x)
    end
  end
end

$ws

defmodule DispatchImpl do
  use BigChor.Chorex, :dispatch
end

defmodule BigRunner do
  def run(start \\\\ 1, use_try? \\\\ true) do
    actor_map = %{
$actor_map
    }

    Chorex.start(BigChor.Chorex, actor_map, [start, use_try?])

    receive do
      {:chorex_return, Worker1, _} = m ->
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
      Worker$i.work_hard($var_name) ~> Worker$j.($var_name)
__CHAIN__
  }

  return $daisy_chain;
}

sub make_work_impls($workers) {
  my $acc = "";

  for my $i (1..$workers) {
    $acc .=<<__WORKER__;
defmodule Worker${i}Impl do
  use BigChor.Chorex, :worker$i

  \@impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
__WORKER__
  }

  return $acc;
}
