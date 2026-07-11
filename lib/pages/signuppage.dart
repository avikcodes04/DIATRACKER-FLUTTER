import 'package:diatrack/pallete.dart';
import 'package:diatrack/pages/otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    
    super.dispose();
  }
  Future<void> _signup() async {
  final name = _nameController.text.trim();
  final username = _usernameController.text.trim();
  final email = _emailController.text.trim();

  if (name.isEmpty || username.isEmpty || email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill in all fields"),
      ),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    // Send OTP using Supabase
    await _authService.sendOtp(email);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("OTP sent successfully."),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationPage(
          email: email,
          fullname: name,
          username: username,
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Pallete.newTextColor,
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Pallete.hintTextColor),
      filled: true,
      fillColor: Pallete.newAccentColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Pallete.newBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Pallete.newBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Pallete.accentColor,
          width: 1.8,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Pallete.newAccentColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Pallete.newBorderColor),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Pallete.accentColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'DiaTracker',
                      style: GoogleFonts.comfortaa(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Pallete.newTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'Create your account ✨',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Pallete.mainFontColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to start tracking and planning dialysis sessions.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Pallete.hintTextColor,
                  ),
                ),

                const SizedBox(height: 32),

                _fieldLabel('Full name'),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  cursorColor: Pallete.accentColor,
                  decoration: _fieldDecoration('Sonai Das'),
                ),

                const SizedBox(height: 16),

                _fieldLabel('Username'),
                const SizedBox(height: 6),
                TextField(
                  controller: _usernameController,
                  cursorColor: Pallete.accentColor,
                  decoration: _fieldDecoration('sonai'),
                ),

                const SizedBox(height: 16),

                _fieldLabel('Email'),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Pallete.accentColor,
                  decoration: _fieldDecoration('you@example.com'),
                ),

                const SizedBox(height: 16),

                _fieldLabel('Password'),

                const SizedBox(height: 24),

                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.accentColor,
                      foregroundColor: Pallete.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                    ),
                    onPressed: _isLoading ? null : _signup,
                    child: _isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Sign up',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Pallete.accentColor,
                      side: BorderSide(color: Pallete.newBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Already have an account? Log in',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}