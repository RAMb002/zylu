import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GenderProvider extends ChangeNotifier {
  bool? _male = true;
  bool? get isMale => _male;


  bool? _female= false;
  bool? get isFemale => _female;

  bool? _active = true;
  bool? get active => _active;

  bool? _inactive = false;
  bool? get inActive => _inactive;

  void changeMaleGender(bool? value) {
    _male = value;
    notifyListeners();
  }
  void changeFemaleGender(bool? value) {
    _female = value;
    notifyListeners();
  }
  void changeActiveStatus(bool? value) {
    _active = value;
    notifyListeners();
  }
  void changeInactiveStatus(bool? value) {
    _inactive = value;
    notifyListeners();
  }
}
