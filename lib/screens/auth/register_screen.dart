import 'dart:io';
import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:eventure/utils/exit_confirmation.dart';
import 'package:eventure/utils/toast_helper.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:eventure/widgets/custom_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedFileName;
  PlatformFile? selectedFile;

  Future<void> _handleSignUp() async {
    final String nama = namaController.text;
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

    if (selectedFile == null) {
      ToastHelper.showShortToast("Pilih file terlebih dahulu");
      return;
    }

    if (selectedFile!.path == null) {
      ToastHelper.showShortToast("Path file tidak tersedia");
      return;
    }

    final File file = File(selectedFile!.path!);

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signUp(
      nama: nama,
      email: email,
      password: password,
      file: file,
    );

    if (success) {
      if (mounted) {
        ToastHelper.showShortToast("Pendaftaran Berhasil!");
        context.go(AppRoutes.home);
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),

                          CustomTextField(
                            controller: namaController,
                            hintText: "Nama Lengkap",
                            icon: Icons.person,
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          CustomTextField(
                            controller: emailController,
                            hintText: "Email",
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          CustomTextField(
                            controller: passwordController,
                            hintText: "Password",
                            icon: Icons.password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          CustomFilePicker(
                            label: "Kartu Tanda Mahasiswa (KTM)",
                            fileName: selectedFileName,
                            onFilePicked: (file) {
                              if (file != null) {
                                setState(() {
                                  selectedFile = file;
                                  selectedFileName = file.name;
                                });
                              }
                            },
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          CustomButton(
                            text: "Daftar",
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
                                "Sudah punya akun?",
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
                                onPressed: () => context.go(AppRoutes.login),
                                child: Text(
                                  "Masuk",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
