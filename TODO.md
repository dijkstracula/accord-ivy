# Fast-path quorums

## Topology representation

I'm not sure what the best way to partition the coordinator set into a
topology.  Presumably the thing we want for model-checking is an arbitrary
topology but the thing we want for execution is a deterministic/replayable one
that is generated orthogonally to randomised inputs?

indexset might be part of the way forward, but in order to talk about a subset
of a basis we need, I guess, a _subtype_ of the basis?

The Java implementation, when driven by Maelstrom, just round-robins nodes
from shard to shard.  That's probably as good a solution as any.

Maelstrom internally represents a topology as a map from nodes to neighbours.

cluster: unifies:
 - full indexset quorum
 - fastpath electorate

## Latency estimator

Similarly, we need a way of mimicing max latencies between nodes in a given
topology.  I wonder if for a first cut we can assume these to be constant, and
then build from there.
