import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF78DA7),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraint) {
          final isLargeScreen = constraint.maxWidth > 600;
          final maxWidth = isLargeScreen ? 400.0 : constraint.maxWidth;

          return Center(
            child: Container(
              width: maxWidth,
              height: constraint.maxHeight,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.06, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.15),

                  Image.asset("assets/logo/inappicon.png", width: screenWidth * 0.3),

                  SizedBox(height: screenHeight * 0.04),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: NANTI UNTUK FIELD MASUK
                        },
                        child: Text("Masuk"),
                      ),

                      SizedBox(width: screenWidth * 0.1),

                      ElevatedButton(
                        onPressed: () {
                          // TODO: NANTI UNTUK FIELD DAFTAR
                        },
                        child: Text("Daftar"),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  Expanded(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      color: Color(0xFFFDF5F7),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: "Nama Lengkap...",
                              icon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                            ),

                            SizedBox(height: screenHeight * 0.015),

                            CustomTextField(
                              hintText: "Email...",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            SizedBox(height: screenHeight * 0.015),

                            CustomTextField(
                              hintText: "Password...",
                              icon: Icons.lock_outline,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),

                            SizedBox(height: screenHeight * 0.025),

                            CustomButton(
                              text: "Masuk",
                              onPressed: () {
                                context.go(AppRoutes.home);
                              },
                              isEnabled: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
