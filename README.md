[![Actions Status](https://github.com/lizmat/Random-Names/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Random-Names/actions) [![Actions Status](https://github.com/lizmat/Random-Names/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Random-Names/actions) [![Actions Status](https://github.com/lizmat/Random-Names/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Random-Names/actions)

NAME
====

Random::Names - Create random names to be used as identifiers

SYNOPSIS
========

```raku
use Random::Names;

# procedural interface
say docker-name;      # e.g. epic-engelbart
say class-name;       # e.g. Mendeleev
say identifier-name;  # e.g. dhawan

my @dn = docker-name(10);      # get array with 10 unique docker-names
my @cn = class-name(10);       # get array with 10 unique class-names
my @in = identifier-name(10);  # get array with 10 unique identifiers

# object interface
my $rn = Random::Names.new;  # set up unique pool of names
say $rn.docker-name;
say $rn.class-name;
say $rn.identifier-name;
```

DESCRIPTION
===========

Sometimes you need some placeholder names for things that do not have a name yet. This module provides a way to create names for things that are both fun and interesting. The names from which it selects, are the surnames of individuals that are famous in the history of scientific exploration and engineering.

It offers 3 types of random names:

  * docker-name

Similar to how Docker names unnamed containers.

  * class-name

Title-cased names used for classes in Raku.

  * identifier-name

Just a random name that can be used as an identifier.

This module also installs a `rn` script that allows you to generate one or more names, accepting a named argument `--docker` for docker names, `--class` for class names, or just identifiers if not specified. Also optionally takes a named argument `--verbose` to also show the `WHY` and `LINK` information.

ADDITIONAL INFORMATION
======================

Each string that is being returned by this module, also has a `.WHY` method attached to it that will give additional information about the person to which the name is attached. E.g.;

```raku
my $name = identifier-name;
say $name;  # einstein
my $why = $name.WHY;
say $why;  # Albert Einstein invented the general theory of relativity.
```

And that string has a `.LINK` method that produces a link to a page that will show you more information about that person:

```raku
say $why.LINK;  # https://en.wikipedia.org/wiki/Albert_Einstein
```

FUNCTIONS
=========

docker-name
-----------

Return a random string similar to how Docker names unnamed containers, such as: `interesting-mendeleev`, `epic-engelbart`, `lucid-dhawan`, `recursing-cori`, `ecstatic-liskov` and `busy-ardinghelli`. These are made from a random selection of an adjective and a surname.

Optionally takes the number of docker-names to be returned.

```raku
say docker-name;          # e.g. epic-engelbart
.say for docker-name(5);  # 5 different docker names
```

class-name
----------

Return a random string that can be used as a name of a class, such as *Mendeleev*.

Optionally takes the number of class names to be returned.

```raku
say class-name;          # e.g. Engelbart
.say for class-name(5);  # 5 different class names
```

identifier-name
---------------

Return a random string that can be used as an identifier, such as *dhawan*.

Optionally takes the number of identifiers to be returned.

```raku
say identifier-name;          # e.g. cori
.say for identifier-name(5);  # 5 different identifiers
```

METHODS
=======

The method interface has two different modes of operation. When called as a class method, the semantics are exactly the same as the functional interface.

When called on a `Random::Names` instance, it will only produce each adjective and each surname **only once**. This means that any mix of calls to `docker-name`, `class-name` or `identifier-name`, the returned strings will always be unique.

new
---

```raku
my $rn = Random::Names.new:
  adjectives => <pretty awful>,     # default: standard set of adjectives
  surnames   => <mattijsen kasik>,  # default: standard set of surnames
;
```

docker-name
-----------

Return a random string similar to how Docker names unnamed containers. These are made from a random selection of an adjective and a surname.

Optionally takes the number of docker-names to be returned.

```raku
my $rn = Random::Names.new;
say $rn.docker-name;          # e.g. epic-engelbart
.say for $rn.docker-name(5);  # 5 different docker names
```

class-name
----------

Return a random string that can be used as a name of a class, such as *Mendeleev*.

Optionally takes the number of class names to be returned.

```raku
my $rn = Random::Names.new;
say $rn.class-name;          # e.g. Engelbart
.say for $rn.class-name(5);  # 5 different class names
```

identifier-name
---------------

Return a random string that can be used as an identifier, such as *dhawan*.

Optionally takes the number of identifiers to be returned.

```raku
my $rn = Random::Names.new;
say $rn.identifier-name;          # e.g. cori
.say for $rn.identifier-name(5);  # 5 different identifiers
```

adjectives
----------

```raku
.say for Random::Names.new.adjectives;
```

Return an array of possible adjectives, alphabetically sorted.

surnames
--------

```raku
.say for Random::Names.new.surnames;
```

Return an array of possible surnames, alphabetically sorted.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>, inspired by the Perl module `Data::Docker::Names` by Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>.

Source can be located at: https://github.com/lizmat/Random-Names . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2020, 2021, 2022, 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

