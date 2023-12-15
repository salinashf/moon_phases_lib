import 'package:test/test.dart';
import 'package:moon_phases/moon_phases.dart';
import 'package:moon_phases/extencions_utils.dart';

void main() {
  test('calculateMoonPhases', () {
    var today = DateTime.now();
    var aWeekAgo = today.subtract(Duration(days: 7));
    MoonPhase? moonToday = Moon.phase(today);
    MoonPhase? moonAWeekAgo = Moon.phase(aWeekAgo);
    print(moonToday?.trlMoon);
    print(moonAWeekAgo?.trlMoon);

    print('La luna el dia de hoy: ${moonToday?.trlMoon}');
    print('La luna de la semana pasada: ${moonAWeekAgo?.trlMoon}');
  });
}
