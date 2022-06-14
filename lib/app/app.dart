import 'package:filmfan/movies/view/movies_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          secondary: Colors.black,
        ),
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        dividerTheme: const DividerThemeData(
          indent: 16,
          space: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
      ),
      home: const MoviesScreen(),
    );
  }
}
