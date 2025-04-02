import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleModel extends ChangeNotifier {
  Locale? _primaryLocale;
  Locale? _secondaryLocale;
  final SharedPreferences _prefs;

  LocaleModel(this._prefs) {
    var primaryLocale = _prefs.getString("primaryLocale");
    if (primaryLocale != null) {
      _primaryLocale = Locale(
        primaryLocale.toString().split("_").first,
        primaryLocale.toString().split("_").last,
      );
    } else {
      _primaryLocale = const Locale('en', 'US');
    }

    // Load secondary locale from SharedPreferences
    var secondaryLocale = _prefs.getString("secondaryLocale");
    if (secondaryLocale != null) {
      _secondaryLocale = Locale(
        secondaryLocale.toString().split("_").first,
        secondaryLocale.toString().split("_").last,
      );
    } else {
      _secondaryLocale = const Locale('sp', 'GE');
    }
  }

  Locale? get primaryLocale => _primaryLocale;

  Locale? get secondaryLocale => _secondaryLocale;

  void setPrimaryLocale(Locale locale) {
    _primaryLocale = locale;
    _prefs.setString('primaryLocale', locale.toString());
    notifyListeners();
  }

  void setSecondaryLocale(Locale locale) {
    _secondaryLocale = locale;
    _prefs.setString('secondaryLocale', locale.toString());
    notifyListeners();
  }
}
