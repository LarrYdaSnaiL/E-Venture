import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:eventure/utils/toast_helper.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildProfileHeader(context),

                    const SizedBox(height: 20),
                    const Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 15),

                    MenuSection(
                      title: "Profil",
                      items: [
                        MenuItemData(
                          icon: Icons.person_outline,
                          text: "Edit Profil",
                          onTap: () => context.go(AppRoutes.editProfile),
                        ),
                        MenuItemData(
                          icon: Icons.notifications_none,
                          text: "Notifikasi",
                          onTap: () => context.go('/editprofil'),
                        ),
                        MenuItemData(
                          icon: Icons.vpn_key_outlined,
                          text: "Ubah Password",
                          onTap: () => _showChangePasswordModal(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MenuSection(
                      title: "Bantuan",
                      items: [
                        MenuItemData(
                          icon: Icons.support_agent,
                          text: "Pusat Bantuan",
                          onTap: () => context.go('/editprofil'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MenuSection(
                      title: "Lainnya",
                      items: [
                        MenuItemData(
                          icon: Icons.info_outline,
                          text: "Tentang Aplikasi",
                          onTap: () => context.go('/about'),
                        ),
                        MenuItemData(
                          icon: Icons.logout,
                          text: "Keluar",
                          onTap: () => AuthProvider().signOut().then(
                            (value) => {
                              ToastHelper.showShortToast("Berhasil Keluar"),
                              if (context.mounted) context.go(AppRoutes.login),
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordModal(BuildContext context) {
    final TextEditingController currentPassController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    bool obscureCurrent = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ubah Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  _buildPasswordInput(
                    label: "Password Saat Ini",
                    controller: currentPassController,
                    isObscure: obscureCurrent,
                    onToggle: () {
                      setModalState(() {
                        obscureNew = !obscureNew;
                      });
                    },
                  ),

                  _buildPasswordInput(
                    label: "Password Baru",
                    controller: newPassController,
                    isObscure: obscureNew,
                    onToggle: () {
                      setModalState(() {
                        obscureNew = !obscureNew;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  _buildPasswordInput(
                    label: "Konfirmasi Password",
                    controller: confirmPassController,
                    isObscure: obscureConfirm,
                    onToggle: () {
                      setModalState(() {
                        obscureConfirm = !obscureConfirm;
                      });
                    },
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: "Simpan",
                      onPressed: () async {
                        if (newPassController.text !=
                            confirmPassController.text) {
                          ToastHelper.showShortToast(
                            "Konfirmasi password tidak cocok",
                          );
                          return;
                        }

                        final passwordError = Validators.validatePassword(
                          newPassController.text,
                        );
                        if (passwordError != null) {
                          ToastHelper.showShortToast(passwordError);
                          return;
                        }

                        await AuthProvider()
                            .changePassword(
                              currentPassword: currentPassController.text,
                              newPassword: newPassController.text,
                            )
                            .then(
                              (value) => {
                                if (value)
                                  if (context.mounted)
                                    context.go(AppRoutes.splash),
                              },
                            );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPasswordInput({
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE55B5B)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
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
          profileImage = const AssetImage("assets/images/person.png");
        }

        return Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: profileImage, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['nama'] ?? "User",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userData['email'] ?? "-",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  MenuItemData({required this.icon, required this.text, required this.onTap});
}

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;

  const MenuSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: const Color(0xFFD65B5B),
                      size: 22,
                    ),
                    minLeadingWidth: 20,
                    title: Row(
                      children: [
                        Container(height: 24, width: 1, color: Colors.black12),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -2),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    onTap: item.onTap,
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.only(left: 55, right: 16),
                      child: Divider(height: 1, color: Colors.black12),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
