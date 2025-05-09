#!/usr/bin/env perl
use strict;
use warnings;

use v5.36;

my $worker_count = 100;

my @workers = map { "Worker$_" } 1..$worker_count;
my $actor_list = join ', ', @workers;

my $dx = make_daisy_chain($worker_count, "x");

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
                work(Worker1.(z)
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
          work(Worker1.(z)
        end
      end
    end

    def work(Worker1.(x)) do
      $dx
    end
  end
end
__FULL_MOD__

sub make_daisy_chain($workers, $var_name) {
  my $daisy_chain = "";

  for my $i (1..$workers) {
    my $j = $i == $workers ? 1 : $i + 1;
    $daisy_chain .=<<__CHAIN__;
      Worker$i.($var_name + 1) ~> Worker$j.($var_name)
__CHAIN__
  }

  return $daisy_chain;
}
