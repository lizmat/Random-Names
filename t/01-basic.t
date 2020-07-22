use Test;
use Random::Names;

my $rn = Random::Names.new;
isa-ok $rn, Random::Names, 'did we get a Random::names?';

for
  docker-name,
  Random::Names.docker-name,
  $rn.docker-name
-> $docker-name {
    isa-ok $docker-name, Str, 'did we get a string';
    ok $docker-name.contains("-"), 'is there a hyphen in the name';
    isa-ok $docker-name.WHY, Str, 'does the .WHY return a Str';
    isa-ok $docker-name.WHY.LINK, Str, 'does the .WHY.LINK return a Str';
    ok $docker-name.WHY.LINK.starts-with("https://"), 'is it a link?';
}

for
  class-name,
  Random::Names.class-name,
  $rn.class-name
-> $class-name {
    isa-ok $class-name, Str, 'did we get a string';
    ok $class-name.contains(/ ^<[A..Z]> /), 'does it start with uppercaser';
    isa-ok $class-name.WHY, Str, 'does the .WHY return a Str';
    isa-ok $class-name.WHY.LINK, Str, 'does the .WHY.LINK return a Str';
    ok $class-name.WHY.LINK.starts-with("https://"), 'is it a link?';
}

for
  identifier-name,
  Random::Names.identifier-name,
  $rn.identifier-name
-> $identifier-name {
    isa-ok $identifier-name, Str, 'did we get a string';
    ok $identifier-name.contains(/ ^<[a..z]> /), 'does it start with lowercase';
    isa-ok $identifier-name.WHY, Str, 'does the .WHY return a Str';
    isa-ok $identifier-name.WHY.LINK, Str, 'does the .WHY.LINK return a Str';
    ok $identifier-name.WHY.LINK.starts-with("https://"), 'is it a link?';
}

for
  docker-name(5),
  Random::Names.docker-name(5),
  $rn.docker-name(5),
  class-name(5),
  Random::Names.class-name(5),
  $rn.class-name(5),
  identifier-name(5),
  Random::Names.identifier-name(5),
  $rn.identifier-name(5)
-> @name {
    is @name.elems, 5, 'did we get 5 elements';
    ok all(@name) ~~ Str, 'did we get just strings';
    ok all(@name.map: *.WHY) ~~ Str, 'are all .WHY just strings';
    ok all(@name.map: *.WHY.LINK) ~~ Str,
      'are all .WHY.LINK just strings';
    ok all(@name.map: *.WHY.LINK.starts-with("https://")),
      'are all .WHY.LINK just strings';
}

done-testing;
