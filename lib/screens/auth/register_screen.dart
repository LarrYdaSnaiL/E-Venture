import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/utils/exit_confirmation.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:eventure/widgets/custom_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedFileName;
  PlatformFile? selectedFile;

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

              Image.asset("assets/logo/inappicon.png", width: screenWidth * 0.3),

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

                          CustomTextField(hintText: "Nama Lengkap", icon: Icons.person),

                          SizedBox(height: screenHeight * 0.015),

                          CustomTextField(
                            hintText: "Email",
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          CustomTextField(
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

                          CustomButton(text: "Daftar", onPressed: () => context.go(AppRoutes.home)),

                          SizedBox(height: screenHeight * 0.02),

                          Row(
                            children: [
                              Expanded(child: Divider(color: Color(0xFF8A8A8A), thickness: 0.5)),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  "Atau",
                                  style: TextStyle(
                                    color: Color(0xFF8A8A8A),
                                    fontSize: (screenWidth * 0.04).clamp(14.0, 18.0),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              Expanded(child: Divider(color: Color(0xFF8A8A8A), thickness: 0.5)),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
                                  fontSize: (screenWidth * 0.04).clamp(14.0, 18.0),
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
                                    fontSize: (screenWidth * 0.04).clamp(14.0, 18.0),
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
