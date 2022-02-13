import 'package:brew_app/models/MyUser.dart';
import 'package:brew_app/screens/wrapper.dart';
import 'package:brew_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      // The datatype is the MyUser class
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService()
          .user, // It's listening to authservice stream in auth file
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
