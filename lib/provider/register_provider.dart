import 'package:couple_sns/toast/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier {
  String _email = "";
  bool _emailValidate = true;
  String _password = "";
  bool _passwordValidate = true;
  String _passwordCheck = '';
  bool _passwordcCheckValidate = true;

  String get email => _email;

  bool get emailValidate => _emailValidate;

  bool get passwordValidate => _passwordValidate;

  String get password => _password;

  String get passwordCheck => _passwordCheck;

  bool get passwordcCheckValidate => _passwordcCheckValidate;

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
    if (_password != _passwordCheck) {
      _passwordcCheckValidate = false;
    } else {
      _passwordcCheckValidate = true;
    }
    notifyListeners();
  }

  Future<void> registerEmail(context) async {
    await checkInfo().then((value) async {
      if (_emailValidate == true &&
          _passwordcCheckValidate == true &&
          _passwordValidate == true) {
        print('통과');
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((value) {
            if (value.user!.email == null) {
            } else {
              Navigator.pop(context);
              showToast('회원가입 완료! 이메일 인증을 해주세요!');
            }
            return value;
          });
          FirebaseAuth.instance.currentUser?.sendEmailVerification();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            showToast('이미 등록된 이메일입니다');
          }
        }catch(e){
          showToast('회원가입 실패!');
        }
      } else {
        showToast('정보를 제대로 입력해주세요');
      }
    });
  }
}
