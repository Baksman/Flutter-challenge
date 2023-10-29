import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/ui/screen/dashbaord.dart';

void main() {
  ServiceLocator.registerSl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal,primary: Colors.teal),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
