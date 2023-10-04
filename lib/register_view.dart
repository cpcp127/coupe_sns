import 'package:couple_sns/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final emailKey = GlobalKey<FormState>();
  final pwdKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer<RegisterProvider>(
                builder: (_, provider, __) {
                  return TextField(
                    onChanged: (email) {
                      registerProvider.setEmail(email);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: '이메일',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: provider.emailValidate == true
                                ? Colors.blueAccent
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: provider.emailValidate == true
                                ? Colors.blueAccent
                                : Colors.red,
                            width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  );
                },
              )),
          Consumer<RegisterProvider>(
            builder: (_, provider, __) {
              return Visibility(
                visible: provider.emailValidate == true ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('이메일을 확인해주세요'),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<RegisterProvider>(
              builder: (_, provider, __) {
                return TextField(
                  onChanged: (pwd) {
                    registerProvider.setPassword(pwd);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: '비밀번호',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: provider.passwordValidate == true
                              ? Colors.blueAccent
                              : Colors.red,
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: provider.passwordValidate == true
                              ? Colors.blueAccent
                              : Colors.red,
                          width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                );
              },
            ),
          ),
          Consumer<RegisterProvider>(
            builder: (_, provider, __) {
              return Visibility(
                visible: provider.passwordValidate == true ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('비밀번호를 확인해주세요'),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<RegisterProvider>(builder: (_, provider, __) {
              return TextFormField(
                onChanged: (pwdCheck) {
                  registerProvider.setPasswordCheck(pwdCheck);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: '비밀번호 확인',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: provider.passwordcCheckValidate == true
                            ? Colors.blueAccent
                            : Colors.red,
                        width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: provider.passwordcCheckValidate == true
                            ? Colors.blueAccent
                            : Colors.red,
                        width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              );
            }),
          ),
          Consumer<RegisterProvider>(
            builder: (_, provider, __) {
              return Visibility(
                visible: provider.passwordcCheckValidate == true ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('비밀번호가 일치하지 않습니다'),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              registerProvider.registerEmail(context);
            },
            child: Center(
              child: Container(
                width: 300,
                height: 50,
                decoration: const BoxDecoration(color: Colors.deepOrangeAccent),
                child: Center(child: const Text('완료')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
