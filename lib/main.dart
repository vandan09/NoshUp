import 'package:flutter/material.dart';
import 'package:canteen_food_ordering_app/screens/landingPage.dart';
import 'package:provider/provider.dart';
import 'notifiers/authNotifier.dart';

// void main() {
//   runApp(MyApp());
// }

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthNotifier(),
      ),
      // ChangeNotifierProvider(
      //   create: (_) => FoodNotifier(),
      // ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoshUp',
      theme: ThemeData(
        fontFamily: 'Questrial',
        primaryColor: Colors.redAccent,
        timePickerTheme: TimePickerThemeData(),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: Colors.redAccent),
      ),
      home: Scaffold(
        body: LandingPage(),
      ),
    );
  }
}
