import 'package:flutter/material.dart';

import '../views/home_view.dart';

class Controller extends StatelessWidget {
  const Controller({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(title: 'Flutter Demo Home Page'),
    );
  }
}
