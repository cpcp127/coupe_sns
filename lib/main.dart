import 'package:couple_sns/create_profile_view.dart';
import 'package:couple_sns/firebase_options.dart';
import 'package:couple_sns/provider/register_provider.dart';
import 'package:couple_sns/register_view.dart';
import 'package:couple_sns/toast/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ], child: const MyApp()));
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (_, state) => const HomeView(),
    routes: [
      GoRoute(
        path: 'login',
        builder: (_, state) => const LoginView(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (_, state) => const RegisterView(),
          )
        ],
      ),
      GoRoute(
        path: 'createProfile',
        builder: (_, state) => const CreateProfileView(),
      ),
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var autoLoginStatus = 'loading';

  @override
  Widget build(BuildContext context) {
    if (autoLoginStatus == 'loading') {
      return Scaffold(
        body: Column(),
      );
    } else if (autoLoginStatus == 'false') {
      return LoginView();
    } else {
      return CreateProfileView();
    }
  }

  @override
  void initState() {
    super.initState();
    getAutoLogin();
  }

  Future<void> getAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('autoLogin')!.isEmpty) {
      setState(() {
        autoLoginStatus = 'false';
      });

    } else {
      setState(() {
        autoLoginStatus = 'true';
      });
    }
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

TextEditingController emailController = TextEditingController();
TextEditingController pwdController = TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
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
          const Text('앱 이름'),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: '이메일',
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: pwdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: '비밀번호',
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: emailController.text.replaceAll(RegExp('\\s'), ""),
                  password: pwdController.text.replaceAll(RegExp('\\s'), ""),
                )
                    .then((value) async {
                  if (value.user!.emailVerified == false) {
                    showToast('이메일 인증을 해주세요!');
                  } else {
                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('autoLogin', '${value.user!.email}');
                    showToast('${value.user!.email}님 환영합니다!');
                    context.go('/createProfile');
                  }
                }).catchError((e) {
                  print(e);
                });
              },
              child: Container(
                height: 56,
                width: double.infinity,
                color: Colors.amber,
                child: const Center(
                  child: Text('로그인'),
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                context.go('/register');
              },
              child: Container(
                  height: 44, child: Center(child: const Text('회원가입'))))
        ],
      ),
    );
  }
}
