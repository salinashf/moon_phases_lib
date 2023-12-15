import 'package:moon_phases/moon_phases.dart';

extension MoonPhaseExtension on MoonPhase {
  String get trlMoon {
    switch (this) {
      case MoonPhase.newMoon:
        return 'Luna Nueva ';
      case MoonPhase.waningCrescent:
        return 'Creciente menguante';
      case MoonPhase.lastQuarter:
        return 'Último cuarto';
      case MoonPhase.waningGibbous:
        return 'Gibosa menguante';
      case MoonPhase.full:
        return 'Luna Llena';
      case MoonPhase.waxingGibbous:
        return 'Luna menguante';
      case MoonPhase.firstQuarter:
        return 'Primer cuarto';
      case MoonPhase.waxingCrescent:
        return 'Luna creciente';
      default:
        return 'Desconocido';
    }
  }
}

extension ControlString on String {
  bool isValidosApp() {
    return isEmpty;
  }
}

/// JulianDate extension on DateTime provides thee DateTime object a `julianDate` property which useful for plently astronomy algorithms.
/// Calculations were all adapted and based on the following book:
/// "Practical Astronomy with your Calculator or Spreadsheet Fourth Edition" by Peter Duffett-Smith and Jonathan Zwart
extension JulianDate on DateTime {
  /// isLeapYear determines if the given DateTime is a leap year
  /// `DateTime.now().isLeapYear`
  bool get isLeapYear {
    if (year % 400 == 0) {
      return true;
    } else if (year % 100 == 0) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    }
    return false;
  }

  // Section 3. Converting Date to Day Number
  /// This converts the date of the month to day number
  /// e.g. What is the day number of June 19 (not a leap year?) 170
  int get dayNumber {
    var month = this.month;
    if (month > 2) {
      month += 1;
      month = (month.toDouble() * 30.6).toInt();
      month = isLeapYear ? month -= 62 : month -= 63;
    } else {
      month -= 1;
      month = isLeapYear ? month * 62 : month * 63;
      month = month ~/ 2;
    }
    month += day;
    return month;
  }

  // dayAsFraction returns the day with the time as fraction
  // e.g. Midday of January 3 is, 3.5 (dayNumber 3 at 12:00PM)
  double get dayAsFraction {
    return day.toDouble() + (hour / 24.0);
  }

  // from Section 4. Julian Dates
  /// get the Julian Date of a DateTime object
  /// `DateTime.now().julianDate`
  double get julianDate {
    var utcnow = toUtc();
    dynamic yPrime;
    dynamic mPrime;
    if (utcnow.month == 1 || utcnow.month == 2) {
      yPrime = year - 1;
      mPrime = month + 12;
    } else {
      yPrime = year;
      mPrime = month;
    }

    var compare = DateTime(1582, 10, 15).toUtc();
    int A;
    int B;
    int C;
    int D;
    if (utcnow.isAfter(compare)) {
      A = yPrime ~/ 100;
      B = 2 - A + (A ~/ 4);
    } else {
      B = 0;
    }

    if (yPrime < 0) {
      C = ((365.25 * yPrime) - 0.75).floor();
    } else {
      C = (365.25 * yPrime).floor();
    }
    D = (30.6001 * (mPrime + 1)).floor();
    return B.toDouble() +
        C.toDouble() +
        D.toDouble() +
        dayAsFraction +
        1720994.5;
  }
}
