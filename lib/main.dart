import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    final _buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.pink,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            shape: _buttonShape,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.pink,
            shape: _buttonShape,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.pink,
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.pink,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.pink,
        ),
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (cxt, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            const SplashScreen();
          }
          if (userSnapshot.hasData) {
            return const ChatScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
