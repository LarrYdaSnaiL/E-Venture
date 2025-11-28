import 'dart:io';

import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color _scaffoldBg = const Color(0xFFF9F5F6);
  final Color _brandColor = const Color(0xFFE55B5B);

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // String? _profileImageUrl;
  //
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final picked = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (picked == null) return;
  //
  //   final file = File(picked.path);
  //
  //   final auth = context.read<AuthProvider>();
  //   final newUrl = await auth.changeUserData(file: file);
  //
  //   if (newUrl != null) {
  //     setState(() {
  //       _profileImageUrl = newUrl;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _brandColor),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileImagePicker(),

            const SizedBox(height: 35),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(hintText: "Nama Lengkap", icon: Icons.person),
                  const SizedBox(height: 15),
                  CustomTextField(hintText: "Email", icon: Icons.email),
                  const SizedBox(height: 15),
                  CustomTextField(hintText: "Nomor Telepon", icon: Icons.phone),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: CustomButton(text: "Simpan", onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return FutureBuilder<Map<dynamic, dynamic>>(
      future: AuthProvider().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
            "Gagal memuat data profil",
            style: TextStyle(color: Colors.red),
          );
        }

        final userData = snapshot.data!;

        ImageProvider profileImage;
        if (userData['profilePicture'] != null &&
            userData['profilePicture'].toString().isNotEmpty) {
          profileImage = NetworkImage(userData['profilePicture']);
        } else {
          profileImage = AssetImage("assets/images/person.png");
        }

        return Center(
          child: Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                    ),
                  ],
                  image: DecorationImage(
                    image: profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    // TODO: Pokoknya nanti _imagePicker itu disini
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: _brandColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
