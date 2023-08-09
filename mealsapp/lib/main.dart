import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealsapp/screens/tabsscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const  ProviderScope(
    child:MyApp(),
    )
  );
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark().copyWith
      (
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 131, 57, 0)),
        textTheme: GoogleFonts.latoTextTheme(),
        ),
    
      home: const TabsScreen()
      
    );
  }
}