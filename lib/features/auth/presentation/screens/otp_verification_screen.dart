import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';
import 'package:diatrack/core/router/app_routes.dart';
import 'package:diatrack/features/auth/presentation/controllers/auth_controller.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_otp.length == 6) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otp;

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the full 6-digit OTP"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final success = await ref.read(authControllerProvider.notifier).confirmSignup(
          email: widget.email,
          otp: otp,
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account verified successfully! Please log in.")),
      );
      context.go(AppRoutes.login);
    } else {
      final error = ref.read(authControllerProvider).errorMessage ?? "Verification failed";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.redAccent,
          action: SnackBarAction(
            label: "Skip to Login",
            textColor: Colors.white,
            onPressed: () => context.go(AppRoutes.login),
          ),
        ),
      );
    }
  }

  Widget _digitBox(int index) {
    return SizedBox(
      width: 46,
      height: 54,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: AppColors.accentColor,
        maxLength: 1,
        style: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.mainFontColor,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.whiteColor,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.newBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.newBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.accentColor,
              width: 2,
            ),
          ),
        ),
        onChanged: (val) => _onDigitChanged(index, val),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.newAccentColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_read_outlined,
                      color: AppColors.accentColor,
                      size: 38,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Verify Your Email ✉️',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainFontColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We have sent a 6-digit confirmation code to',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: AppColors.hintTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.email.isNotEmpty ? widget.email : 'your email address',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.newTextColor,
                  ),
                ),

                const SizedBox(height: 36),

                // OTP inputs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (i) => _digitBox(i)),
                ),

                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentColor,
                      foregroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    onPressed: isLoading ? null : _verifyOtp,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Confirm & Continue',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // Back to login
                Center(
                  child: GestureDetector(
                    onTap: () => context.go(AppRoutes.login),
                    child: Text(
                      'Back to Login',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentColor,
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
