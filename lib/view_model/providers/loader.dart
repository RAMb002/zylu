import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier{

  bool _status = false;

  bool get status => _status;

  void changeLoadingStatus(bool value){
    _status = value;
    notifyListeners();
  }

}