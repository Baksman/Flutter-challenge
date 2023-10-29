import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/view/screen/dashbaord.dart';
import 'package:flutter_challenge/view/style/color_styles.dart';

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
      title: 'Dog App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.teal, primary: AppColor.teal),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
