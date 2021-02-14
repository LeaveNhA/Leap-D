module leap;

import std.stdio;
import std.algorithm;
import std.range : chain, only;

bool isLeap(int year)
{
  auto calculations = [(int y) => y % 4,
                       (int y) => y % 100,
                       (int y) => y % 400]
    .map!(f => f(year))
    .map!(b => b == 0);

  const bool dividedBy4 = calculations[0],
    dividedBy100 = calculations[1],
    dividedBy400 = calculations[2];

  return dividedBy400 || (dividedBy4 && !dividedBy100);
}

unittest
{
    immutable int allTestsEnabled = 1;

    // Year not divisible by 4 in common year
    assert(!isLeap(2015));

    static if (allTestsEnabled)
    {
        // Year divisible by 2, not divisible by 4 in common year
        assert(!isLeap(1970));

        // Year divisible by 4, not divisible by 100 in leap year
        assert(isLeap(1996));

        // Year divisible by 4 and 5 is still a leap year
        assert(isLeap(1960));

        // Year divisible by 100, not divisible by 400 in common year
        assert(!isLeap(2100));

        // Year divisible by 100 but not by 3 is still not a leap year
        assert(!isLeap(1900));

        // Year divisible by 400 in leap year
        assert(isLeap(2000));

        // Year divisible by 400 but not by 125 is still a leap year
        assert(isLeap(2400));

        // Year divisible by 200, not divisible by 400 in common year
        assert(!isLeap(1800));
    }
}
