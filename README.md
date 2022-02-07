# accord-ivy

The Accord consensus protocol in IVy, formally-verified to have [zarro
boogs](https://www.youtube.com/watch?v=4Q7FTjhvZ7Y&t=1098s)

## Authors

* Nathan Taylor (`ntaylor@cs.utexas.edu`)

## Documentation

Beginning with the [CEP][CEP] and the [whitepaper][whitepaper] is likely
a good place to start.

```
```

## Setup:

The scripts directory has a precommit hook that you might find useful:

```
$ git config core.hooksPath ./scripts/
```

You may wish to build a tagfile for your editor to consume ([Universal
Ctags](https://github.com/universal-ctags/ctags) required, and your
/path/to/ivy may vary):

```
$ ctags --options=./scripts/ivy.ctags -L<(find ~/code/ivy/ivy/include/1.8/)
$ ctags --options=./scripts/ivy.ctags --append -R
```

## Building and Running:

```
$ make build ; transpile to C++
$ make test  ; random testing
$ make bmc   ; run BMC

$ make       ; all of the above
```

CEP: https://cwiki.apache.org/confluence/display/CASSANDRA/CEP-15%3A+General+Purpose+Transactions
whitepaper: https://cwiki.apache.org/confluence/download/attachments/188744725/Accord.pdf?version=2&modificationDate=1637000779000&api=v2
