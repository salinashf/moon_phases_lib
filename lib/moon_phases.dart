import 'package:moon_phases/extencions_utils.dart';

enum MoonPhase {
  newMoon,
  waningCrescent,
  lastQuarter,
  waningGibbous,
  full,
  waxingGibbous,
  firstQuarter,
  waxingCrescent,
}

/// Moon class has a convinience function `phase(DateTime)` which returns the moonPhase for a given time.
/// This Class relies on the JulianDate extension
class Moon {
  static MoonPhase? phase(DateTime input) {
    var D = ageOfMoon(input);
    return getMoonPhase(D);
  }

  /// ageOfMoon returns the number of days since the latest New Moon
  /// This calculation was adapted from https://www.subsystems.us/uploads/9/8/9/4/98948044/moonphase.pdf
  static double ageOfMoon(DateTime input) {
    const lunarCycle = 29.53;
    final lastNewMoon = DateTime(2019, 1, 6, 1, 29);
    final daysSinceLastNewMooon = input.julianDate - lastNewMoon.julianDate;
    final newMoons = daysSinceLastNewMooon / lunarCycle;
    return (newMoons - newMoons.floor()) * lunarCycle;
  }

  /// Returns a MoonPhase
  // ignore: missing_return
  static MoonPhase? getMoonPhase(double daysSinceNewMoon) {
    if (daysSinceNewMoon == 0 || daysSinceNewMoon == 29.5) {
      return MoonPhase.newMoon;
    }

    if (daysSinceNewMoon > 0 && daysSinceNewMoon < 3.5) {
      return MoonPhase.newMoon;
    }

    if (daysSinceNewMoon >= 3.5 && daysSinceNewMoon < 7) {
      return MoonPhase.waxingCrescent;
    }

    if (daysSinceNewMoon >= 7 && daysSinceNewMoon < 11) {
      return MoonPhase.firstQuarter;
    }

    if (daysSinceNewMoon >= 11 && daysSinceNewMoon < 15.0) {
      return MoonPhase.waxingGibbous;
    }

    if (daysSinceNewMoon >= 15.0 && daysSinceNewMoon < 18.5) {
      return MoonPhase.full;
    }

    if (daysSinceNewMoon >= 18.5 && daysSinceNewMoon < 22.0) {
      return MoonPhase.waningGibbous;
    }

    if (daysSinceNewMoon >= 22.0 && daysSinceNewMoon < 25.7) {
      return MoonPhase.lastQuarter;
    }

    if (daysSinceNewMoon >= 25.7 && daysSinceNewMoon < 29.5) {
      return MoonPhase.waningCrescent;
    }
    return null;
  }
}
