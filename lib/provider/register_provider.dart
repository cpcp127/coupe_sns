import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_sns/toast/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier {
  int _pageIndex = 0;
  String _email = "";
  bool _emailValidate = true;
  String _password = "";
  bool _passwordValidate = true;
  String _passwordCheck = '';
  bool _passwordcCheckValidate = true;
  String _nickname = "";
  bool _nicknameValidate = true;

  int get pageIndex => _pageIndex;

  String get email => _email;

  bool get emailValidate => _emailValidate;

  bool get passwordValidate => _passwordValidate;

  String get password => _password;

  String get passwordCheck => _passwordCheck;

  bool get passwordcCheckValidate => _passwordcCheckValidate;

  String get nickname => _nickname;

  bool get nicknameValidate => _nicknameValidate;

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

  void setNickName(String input_nickname) {
    _nickname = input_nickname;
    notifyListeners();
  }

  Future<void> stepContinue(context) async {
    if (_pageIndex == 0) {
      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(_email) ==
              false ||
          _email.isEmpty) {
        _emailValidate = false;
      } else {
        _emailValidate = true;
        _pageIndex++;
      }
    } else if (_pageIndex == 1) {
      if (RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
                  .hasMatch(_password) ==
              false ||
          _password.isEmpty) {
        _passwordValidate = false;
      } else {
        _passwordValidate = true;
      }

      if (_password != _passwordCheck) {
        _passwordcCheckValidate = false;
      } else {
        _passwordcCheckValidate = true;
      }
      if (_passwordValidate == true && _passwordcCheckValidate == true) {
        _pageIndex++;
      }
    } else {
      if (_nickname.isEmpty || _nickname.length == 1) {
        _nicknameValidate = false;
      } else {
        _nicknameValidate = true;
        registerEmail(context);
      }
    }
    notifyListeners();
  }

  Future<void> stepCancel() async {
    if (_pageIndex == 0) {
    } else {
      _pageIndex--;
    }
    notifyListeners();
  }

  Future<void> checkInfo() async {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(_email) ==
            false ||
        _email.isEmpty) {
      _emailValidate = false;
    } else {
      _emailValidate = true;
    }
    if (RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
                .hasMatch(_password) ==
            false ||
        _password.isEmpty) {
      _passwordValidate = false;
    } else {
      _passwordValidate = true;
    }

    if (_nickname.isEmpty || _nickname.length == 1) {
      _nicknameValidate = false;
    } else {
      _nicknameValidate = true;
    }

    if (_password != _passwordCheck) {
      _passwordcCheckValidate = false;
    } else {
      _passwordcCheckValidate = true;
    }
    notifyListeners();
  }

  Future<void> registerEmail(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((credentialValue) {
        FirebaseFirestore.instance.collection('user').doc(_email).set({
          'email': _email,
          'nickname': _nickname,
        });
        if (credentialValue.user!.email == null) {
        } else {
          Navigator.pop(context);
          showToast('회원가입 완료! 이메일 인증을 해주세요!');
        }
        return credentialValue;
      });
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast('이미 등록된 이메일입니다');
      }
    } catch (e) {
      showToast('회원가입 실패!');
    }
  }

  void resetProvider() {
    _pageIndex = 0;
    _email = "";
    _emailValidate = true;
    _password = "";
    _passwordValidate = true;
    _passwordCheck = '';
    _passwordcCheckValidate = true;
    _nickname = "";
    _nicknameValidate = true;
  }
}
