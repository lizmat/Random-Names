my constant @adjectives = <
  admiring adoring affectionate agitated amazing angry awesome beautiful
  blissful bold boring brave busy charming clever cool compassionate
  competent condescending confident cranky crazy dazzling determined
  distracted dreamy eager ecstatic elastic elated elegant eloquent epic
  exciting fervent festive flamboyant focused friendly frosty funny
  gallant gifted goofy gracious great happy hardcore heuristic hopeful
  hungry infallible inspiring interesting intelligent jolly jovial keen
  kind laughing loving lucid magical mystifying modest musing naughty
  nervous nice nifty nostalgic objective optimistic peaceful pedantic
  pensive practical priceless quirky quizzical recursing relaxed reverent
  romantic sad serene sharp silly sleepy stoic strange stupefied suspicious
  sweet tender thirsty trusting unruffled upbeat vibrant vigilant vigorous
  wizardly wonderful xenodochial youthful zealous zen
>;

my constant %info = do {
    my $people := %?RESOURCES<people>.open;
    my @lines = $people.slurp.lines;
    $people.close;  # UNCOVERABLE

    my %hash;
    while @lines {  # UNCOVERABLE
        my $key := @lines.shift;
        %hash{$key} := (@lines.shift, @lines.shift);  # UNCOVERABLE
        die "No ending found at $key"  # UNCOVERABLE
          unless @lines.shift.starts-with("-");
    }
    %hash.Map  # UNCOVERABLE
}

my constant @surnames := %info.keys.sort;

my role Link { has $.LINK }

my sub adjective-surname($adjective, $surname --> Str:D) {
    my $name := "$adjective\-$surname";
    with %info{$surname} -> @info {
        $name.set_why(@info[0] but Link(@info[1]));
    }
    $name
}

my sub surname-tc($surname --> Str:D) {
    my $name := $surname.tc;
    with %info{$surname} -> @info {
        $name.set_why(@info[0] but Link(@info[1]));
    }
    $name
}

my sub surname($surname --> Str:D) {
    my $name = $surname;
    with %info{$surname} -> @info {
        $name.set_why(@info[0] but Link(@info[1]));
    }
    $name
}

my proto sub docker-name(|) is export {*}
my multi sub docker-name() {
    adjective-surname(@adjectives.roll, @surnames.roll)
}
my multi sub docker-name(UInt:D $pick) is export {
    @adjectives.pick($pick) Z[&adjective-surname] @surnames.pick($pick)
}

my proto sub class-name(|) is export {*}
my multi sub class-name() {
    surname-tc(@surnames.roll)
}
my multi sub class-name(UInt:D $pick) {
    @surnames.pick($pick).map: &surname-tc
}

my proto sub identifier-name(|) is export {*}
my multi sub identifier-name() {
    surname(@surnames.roll)
}
my multi sub identifier-name(UInt:D $pick) {
    @surnames.pick($pick).map: &surname
}

class Random::Names {
    has @.adjectives = @adjectives;
    has @.surnames   = @surnames;

    multi method docker-name(Random::Names:U:) {
        docker-name
    }
    multi method docker-name(Random::Names:U: UInt:D $roll) {
        docker-name($roll)
    }
    multi method docker-name(Random::Names:D:) {
        adjective-surname(
          (@!adjectives.grab // die "No more adjectives available"),
          (@!surnames.grab // die "No more surnames available")
        )
    }
    multi method docker-name(Random::Names:D: UInt:D $grab) {
        my @adjectives = @!adjectives.grab($grab);
        my @surnames   = @!surnames.grab($grab);
        @adjectives .= @adjectives.grab(@surnames)
          if @surnames < @adjectives;
        @surnames .= @surnames.grab(@adjectives)
          if @adjectives < @surnames;

        @adjectives >>[&adjective-surname]<< @surnames
    }

    multi method class-name(Random::Names:U:) {
        class-name
    }
    multi method class-name(Random::Names:U: UInt:D $pick) {
        class-name($pick)
    }
    multi method class-name(Random::Names:D:) {
        surname-tc(@!surnames.grab // die "No more surnames left")
    }
    multi method class-name(Random::Names:D: UInt:D $grab) {
        @!surnames.grab($grab).map: &surname-tc
    }

    multi method identifier-name(Random::Names:U:) {
        identifier-name
    }
    multi method identifier-name(Random::Names:U: UInt:D $pick) {
        identifier-name($pick)
    }
    multi method identifier-name(Random::Names:D:) {
        surname(@!surnames.grab // die "No more surnames left")
    }
    multi method identifier-name(Random::Names:D: UInt:D $grab) {
        @!surnames.grab($grab).map: &surname
    }
}

# vim: expandtab shiftwidth=4
