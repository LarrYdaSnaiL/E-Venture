import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/utils/exit_confirmation.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/toast_helper.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedFileName;
  PlatformFile? selectedFile;

  Future<void> _handleSignUp() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      ToastHelper.showShortToast(emailError);
      return;
    }

    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      ToastHelper.showShortToast(passwordError);
      return;
    }

    final success = await context.read<AuthProvider>().signIn(
      email: email,
      password: password,
    );

    if (success) {
      if (mounted) {
        Map<dynamic, dynamic> userData = await context
            .read<AuthProvider>()
            .getUserData();
        ToastHelper.showShortToast("Selamat Datang, ${userData["nama"]}!");
        if (mounted) context.go(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ExitConfirmation(
      child: Center(
        child: Scaffold(
          backgroundColor: Color(0xFFF78DA7),
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.2),

              Image.asset(
                "assets/logo/inappicon.png",
                width: screenWidth * 0.3,
              ),

              SizedBox(height: screenHeight * 0.03),

              Expanded(
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  color: Color(0xFFFDF5F7),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),

                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          icon: Icons.password,
                          keyboardType: TextInputType.visiblePassword,
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        CustomButton(
                          text: "Masuk",
                          onPressed: () => _handleSignUp(),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xFF8A8A8A),
                                thickness: 0.5,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Atau",
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                  fontSize: (screenWidth * 0.04).clamp(
                                    14.0,
                                    18.0,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Divider(
                                color: Color(0xFF8A8A8A),
                                thickness: 0.5,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/google.png",
                              width: screenWidth * 0.1,
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun?",
                              style: TextStyle(
                                color: Color(0xFF8A8A8A),
                                fontSize: (screenWidth * 0.04).clamp(
                                  14.0,
                                  18.0,
                                ),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go(AppRoutes.register),
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Color(0xFFD64F5C),
                                  fontSize: (screenWidth * 0.04).clamp(
                                    14.0,
                                    18.0,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
