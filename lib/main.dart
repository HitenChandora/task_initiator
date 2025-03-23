import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/home/bloc/post_bloc.dart';
import 'package:task_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:task_app/sign_up/bloc/sign_up_bloc.dart';
import 'package:task_app/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
    BlocProvider<SignInBloc>(create: (context) => SignInBloc()),
    BlocProvider<PostBloc>(create: (context) => PostBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
