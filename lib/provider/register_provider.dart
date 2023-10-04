
import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier {
  String _email = "";
  bool _emailValidate = true;
  String _password = "";
  bool _passwordValidate = true;
  String _passwordCheck = '';

  String get email => _email;

  bool get emailValidate => _emailValidate;

  bool get passwordValidate => _passwordValidate;

  String get password => _password;

  String get passwordCheck => _passwordCheck;

  void setEmail(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void setPassword(String input_password) {
    _password = input_password;
    notifyListeners();
  }

  void setPasswordCheck(String input_passwordCheck) {
    _passwordCheck = input_passwordCheck;
    notifyListeners();
  }

  void checkInfo(String email, String pwd) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false||email.isEmpty) {
      _emailValidate = false;
    } else {
      _emailValidate = true;
    }
    if (RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
            .hasMatch(pwd) ==
        false||pwd.isEmpty) {
      _passwordValidate = false;
    } else {
      _passwordValidate = true;
    }
    notifyListeners();
  }
}
