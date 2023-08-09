import 'package:flutter/material.dart';
import 'package:forms/widget/grocery_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groceries',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(225, 147, 229, 250),
         brightness: Brightness.dark,
        surface: const Color.fromARGB(225, 42, 51, 59),
        ),
        scaffoldBackgroundColor: Colors.black
      ),
      home:const Scaffold(
        //appBar: AppBar(title: const Text('Shopping app'),),
        body: MyWidget(),
      )
    );
  }
}