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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      borderSide:
                          BorderSide(color: provider.passwordValidate == true
                              ? Colors.blueAccent
                              : Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              onChanged: (pwdCheck) {
                registerProvider.setPasswordCheck(pwdCheck);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: '비밀번호 확인',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              registerProvider.checkInfo(
                  registerProvider.email, registerProvider.password);
            },
            child: Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(color: Colors.red),
              child: const Text('완료'),
            ),
          )
        ],
      ),
    );
  }
}
