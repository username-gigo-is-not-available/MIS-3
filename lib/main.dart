import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAL9dcC-B8sikXhNIEO0aGPSF3nSQm5ZXU",
      projectId: "lab3-mis-b2fc1",
      storageBucket: "lab3-mis-b2fc1.appspot.com",
      messagingSenderId: "759223723114",
      appId: "1:759223723114:android:d6b705524232501103d613",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
