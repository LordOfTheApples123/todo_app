import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smth/page/todo_list_page/todo_list_widget.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(
              headlineLarge: GoogleFonts.montserrat(
                fontSize: 32,
                height: 32 / 40,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              headlineSmall: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 24 / 32,
                color: Colors.black,
              ),
              bodyLarge: GoogleFonts.montserrat(
                fontSize: 16,
                height: 16 / 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              bodyMedium: GoogleFonts.montserrat(
                fontSize: 14,
                height: 14 / 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
          colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: const Color(0xFFFF9900),
              primary: const Color(0xFFFF9900),
              background: const Color(0xFFEDEDED),
              surface: const Color(0xFFFFFFFF),
              onBackground: Colors.black,
              onSurface: const Color(0xFFAEAEAE),
              error: const Color(0xFFF85535),
              secondary: const Color(0xFF45B443),
              outlineVariant: const Color(0xFFAEAEAE))),
      home: const ToDoListWidget(),

    );
  }
}
