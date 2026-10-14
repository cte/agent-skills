---
name: validate-evaluator
description: "Calibrate an LLM judge against human labels using held-out data, class-specific error rates, and uncertainty. Use before trusting a judge or estimating aggregate quality from its outputs."
---

# Validate an LLM evaluator

Measure whether the judge detects the failure mode domain experts actually care
about. A well-formed verdict or high raw agreement is not validation.

## Data and splits

Gather human Pass/Fail labels for one failure mode and resolve material rubric
ambiguity before fitting the judge. Prefer domain-qualified reviewers. Around
50 examples of each class is a useful starting point, not a universal guarantee;
report the observed class counts and uncertainty.

Keep train (few-shot source), dev (iteration), and test (final measurement)
disjoint. A 15/45/40 split is an example, not a requirement. Group related user,
document, or conversation records together when splitting to avoid near-duplicate
leakage. Stratify when possible so each measurement split contains both classes.
Examples used in the prompt belong only to train.

Record dataset identity, split seed, rubric, prompt version, provider/model version,
and sampling parameters. Changing the model or prompt changes the evaluator.

## Calibrate

Run the judge on dev and build a confusion matrix with **Pass as positive**:

- TPR = human Pass also called Pass / all human Pass.
- TNR = human Fail also called Fail / all human Fail.
- A false pass is a missed failure; a false fail is a rejected acceptable output.

Missing classes make the corresponding rate undefined, not zero. Report evaluator
errors and malformed responses separately; never silently count them as passes.
Raw accuracy can hide an always-pass judge when failures are rare. Other metrics
may supplement these rates when they answer a specific product question.

Inspect disagreements. Clarify definitions, select examples from train, or split
a vague criterion into narrower checks. Set acceptance thresholds from the cost of
missed failures and false alarms. Values such as 90% for both rates are examples,
not universally sufficient safety thresholds. Bound iteration and model spend;
report stalled alignment or ambiguous labels rather than tuning indefinitely.

Run the locked judge once on the untouched test set. If that result causes a
revision, the set is no longer an untouched final test; obtain a new holdout for
the next final claim. Report counts, both rates, and confidence intervals.

## Optional aggregate correction

A calibrated judge can estimate prevalence on an unlabeled representative sample.
Under stable class-conditional error rates, the Rogan–Gladen correction is:

```text
estimated_pass_rate = (observed_pass_rate + TNR - 1) / (TPR + TNR - 1)
```

Do not apply it when the denominator is nonpositive or too close to zero for a
stable estimate, or when validation and target populations have materially different
error behavior. Report out-of-range raw estimates as a diagnostic; a clipped
[0, 1] display is not proof the assumptions hold.

Estimate uncertainty from both the labeled validation sample and the unlabeled
production sample, preserving groups when records are correlated. For a bootstrap,
resample both datasets, reject invalid replicates, and report failures or too few
valid replicates instead of returning a confident interval. If holding observed
prevalence fixed, label the interval conditional and incomplete. Neither TPR nor
TNR universally matters more; both enter the denominator and their uncertainty
and prevalence determine the result.

## Handoff

Report the locked evaluator, data provenance, class counts, split strategy,
confusion matrix, uncertainty, acceptance decision, and remaining limits. A
synthetic balanced holdout does not establish real-world failure prevalence.
Revalidate after model/prompt changes or distribution drift. Use ordinary software
tests for deterministic evaluators rather than replacing them with this workflow.
