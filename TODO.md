# Fast-path quorums

## Topology representation

I'm not sure what the best way to partition the coordinator set into a
topology.  Presumably the thing we want for model-checking is an arbitrary
topology but the thing we want for execution is a deterministic/replayable one
that is generated orthogonally to randomised inputs?

## Latency estimator
Similarly, we need a way of mimicing max latencies between nodes in a given
topology.  I wonder if for a first cut we can assume these to be constant, and
then build from there.
