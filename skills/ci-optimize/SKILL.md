---
name: ci-optimize
description: "Measure and improve CI latency or runner consumption through bounded, comparable experiments while preserving correctness and required checks."
---

# CI optimization

Optimize the user's metric: time to required verdict, full completion time, total
runner-seconds, or one lane's duration. Identify the actual checkout, baseline
revision, workflow event, selected jobs, runner class, and cache regime first.

## Establish evidence

Use the repository's measurement tooling if present; otherwise collect the same
facts from the CI provider and existing commands. Do not require another project's
benchmark harness. Inspect a completed run before attributing cost to a step.
Separate queue delay, dependencies, setup, execution, and retries. Failed runs are
diagnostic evidence, not successful performance baselines.

Use a small bounded experiment set (three is a useful starting point), subject to
the user's budget. Do not change runner billing, required checks, deployment
concurrency, or schedule future work without authorization.

## Experiment

1. Pick the largest measured bottleneck. Prefer removing repeated setup or builds,
   balancing shards, reducing unnecessary waits, and reusing safe fixtures.
2. Change one mechanism at a time. Record hypothesis, baseline/candidate SHAs,
   workload identity, commands, environment, cache state, and results in a local
   experiment ledger.
3. Keep baseline and candidate environments comparable. Reset only disposable
   experiment state for cold-cache samples; preserve active developer services.
4. Validate that assertions and job selection are unchanged. For test retirement,
   name the obsolete contract or demonstrate the retained test catches the same
   failure. Slow or flaky alone is not sufficient evidence for deletion.
5. For caches, verify source/config/toolchain keys and compare against a clean
   build. For sharding, verify complete coverage and total runner-seconds as well
   as wall-clock latency.
6. Run focused correctness gates before interpreting a speedup. A faster failure
   or omitted workload is not an improvement.

Screen locally with a small number of paired samples. Add samples when noise,
parallelism, or cache variance could change the decision. Report median and spread;
do not imply statistical confidence from a single pair. A removed deterministic
wait can support a narrow claim without proving a pipeline-wide improvement.

Confirm promising changes with comparable successful hosted runs when publication
is authorized. Distinguish local measurements, hosted measurements, and merged
results. Pending CI does not prevent independent local work, but cannot establish
acceptance. Never auto-merge as part of optimization.

## Stop and hand off

Keep accepted, rejected, inconclusive, and blocked outcomes. Revert only your own
rejected changes. Stop when the objective or budget is reached, no supported
bottleneck remains, or a required correctness/authorization boundary blocks work.
Report measured savings, evidence limits, preserved coverage, and the next useful
experiment. Create future monitoring only when requested and supported; never
claim it exists merely because it was described in a plan.
