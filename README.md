# pymarl-util
Various utilities for running and evaluating the Python Multi-agent Reinforcement Learning framework
([PyMARL](https://github.com/oxwhirl/pymarl))

The [workflow](./workflow) directory contains notebooks and scripts for running and evaluating results

### Helpful notes

Evaluating the time taken for a set of experiments in a `sacred` directory:

```bash
find . -name "cout.txt" | xargs tail | grep Time | cut -f5 -d :
```
