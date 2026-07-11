import 'package:diatrack/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:diatrack/pages/loginpage.dart';
// import 'package:diatrack/pages/otp_verification_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://snjvfocksfnkyphhoosi.supabase.co",
    publishableKey: "sb_publishable_o4kJ7cT5r5CApbqMRazMxA_LiyVhwr9",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DiaTracker',
      home: const LoginPage(), // Replace with a valid email for testing
    );
  }
}