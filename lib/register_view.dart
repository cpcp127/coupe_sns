import 'package:couple_sns/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
    print('init reigster view');
    Provider.of<RegisterProvider>(context, listen: false).resetProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.close)),
          leadingWidth: 56,
          title: Text('회원가입'),
          centerTitle: true,
        ),
        bottomSheet: Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: Consumer<RegisterProvider>(
              builder: (_, provider, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        provider.stepCancel();
                      },
                      child: Container(
                        height: 60,
                        width: 128,
                        child: const Center(
                            child: Text(
                          '이전',
                          style: TextStyle(color: Colors.white),
                        )),
                        color: provider.pageIndex == 0
                            ? Colors.transparent
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.stepContinue(context);
                      },
                      child: Container(
                        height: 60,
                        width: 128,
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          provider.pageIndex == 2 ? '완료' : '다음',
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                );
              },
            )),
        body: Consumer<RegisterProvider>(
          builder: (_, provider, __) {
            if (provider.pageIndex == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Text('1. 이메일'),
                    const Text('이메일을 올바른 형식으로 입력해주세요'),
                    TextField(
                      onChanged: (email) {
                        provider.setEmail(email);
                      },
                      controller: provider.emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: '이메일',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.emailValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.emailValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.emailValidate == true ? false : true,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('이메일을 확인해주세요'),
                      ),
                    )
                  ],
                ),
              );
            } else if (provider.pageIndex == 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Text('1. 비밀번호'),
                    const Text('비밀번호를 특수문자를 포함해서 8~15로 입력해주세요'),
                    TextField(
                      onChanged: (pwd) {
                        provider.setPassword(pwd);
                      },
                      controller: provider.pwdController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: '비밀번호',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.passwordValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.passwordValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.passwordValidate == true ? false : true,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('비밀번호를 확인해주세요'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (pwdCheck) {
                        provider.setPasswordCheck(pwdCheck);
                      },
                      controller: provider.pwdValidateController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: '비밀번호 확인',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.passwordCheckValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.passwordCheckValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.passwordCheckValidate == true
                          ? false
                          : true,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('비밀번호가 일치하지 않습니다'),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (nick) {
                        provider.setNickName(nick);
                      },
                      controller: provider.nicknameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_rounded),
                        hintText: '닉네임',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.nicknameValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: provider.nicknameValidate == true
                                  ? Colors.blueAccent
                                  : Colors.red,
                              width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: provider.nicknameValidate == true ? false : true,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('닉네임을 확인해주세요'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }
          },
        ));
  }
}
