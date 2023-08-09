import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

final klightcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(198, 192, 254, 1));
final kdarkcolorscheme =
    ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 26, 201, 250));

void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//  ]).then((fn) {
   runApp(const MyApp());
  // });
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  void isdark() {
    setState(() {
      if (isDark == true) {
        //thememode
        isDark=false;
      } else if (isDark == false) {
        isDark = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(
          useMaterial3: true,
       

        ).copyWith(
            cardTheme: const CardTheme().copyWith(
                margin:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
                     ),
        
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: klightcolorscheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: klightcolorscheme.onPrimaryContainer,
              foregroundColor: klightcolorscheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
                color: klightcolorscheme.secondaryContainer,
                margin:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 16)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: klightcolorscheme.primaryContainer,
            )),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: klightcolorscheme.onSecondaryContainer))
            ),
        debugShowCheckedModeBanner: false,
        themeMode:isDark?ThemeMode.dark:ThemeMode.light,
        home: Expenses(isdark:isdark,isDark:isDark));
  }
}








































//dark and light mode
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isdark = false;
//   void darkmode() {
//     setState(() {
//       if(isdark==false){
//       isdark =true;}
//       else if(isdark==true){
//         isdark=false;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: isdark?ThemeData.dark():ThemeData.light(),
//       home:Scaffold(
//         body: ElevatedButton.icon(
//         onPressed: darkmode,
//         icon: Icon(isdark ? Icons.dark_mode : Icons.light_mode),
//         label: const Text('Transparency'))
//       )
//     );
    
   
//   }
// }
