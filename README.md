# sgug-rpm-tools

Build lifecycle + dependency tooling

## Licensing

The sgug-rpm-tools and related source code fall under the GPL3.

## How to build

Normally you'll get these tools as part of the base sgug-rse install.

That said, if you are curious, it's the usual:

```
./configure --prefix=/path/to/install
make
make install
```

## What is included?

(1) sgug_world_builder - a tool to generate a list that can be turned into a "build the world" script

(2) sgug_minimal_computer - a tool that will compute the smallest dependency tree that includes `rpm`, `sudo`

Both the above require that:

* All RPM packages to be considered for the above are currently installed
* All package `.spec` files + sources related to those packages are currently installed

The tools basically work by parsing all the `.spec` files found in `~/rpmbuid/SPECS` - and working out the dependencies for all the related `.rpm` files produced. The dependency graph is walked and resolved and then the tool produces it's output.

These tools aren't "production ready" - but are good and useful enough that having a project for them is useful.
