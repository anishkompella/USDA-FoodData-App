import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/search_provider.dart';
import 'screens/search_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodData Central',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
