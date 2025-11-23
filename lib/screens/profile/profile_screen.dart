import 'package:eventure/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBg = const Color(0xFFF9F5F6);
    final Color brandColor = const Color(0xFFE55B5B);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          // REMOVED: The outer Padding that was here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with its own padding
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: _buildCustomHeader(brandColor),
              ),

              // 2. THE FULL WIDTH LINE
              // Since there is no parent padding blocking it, this touches both edges.
              const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black26 // Adjust opacity for lighter/darker line
              ),

              // 3. The rest of the content with its own padding
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 20),

                    // (Optional) Inner divider for the profile section
                    const Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 15),

                    // Menu Groups
                    MenuSection(
                      title: "Profil",
                      items: [
                        MenuItemData(icon: Icons.person_outline, text: "Edit Profil", onTap: ()=> context.go(AppRoutes.editProfile)),
                        MenuItemData(icon: Icons.notifications_none, text: "Notifikasi" , onTap: ()=> context.go('/editprofil')),
                        MenuItemData(icon: Icons.vpn_key_outlined, text: "Ubah Password" , onTap: ()=> _showChangePasswordModal(context), ),
                      ],
                      brandColor: brandColor,
                    ),
                    const SizedBox(height: 20),
                    MenuSection(
                      title: "Bantuan",
                      items: [
                        MenuItemData(icon: Icons.support_agent, text: "Pusat Bantuan" , onTap: ()=> context.go('/editprofil')),
                      ],
                      brandColor: brandColor,
                    ),
                    const SizedBox(height: 20),
                    MenuSection(
                      title: "Lainnya",
                      items: [
                        MenuItemData(icon: Icons.info_outline, text: "Tentang Aplikasi" , onTap: () => context.go('/about'),),
                        MenuItemData(icon: Icons.logout, text: "Keluar" , onTap: ()=> context.go(AppRoutes.login)),
                      ],
                      brandColor: brandColor,
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


  // --- FUNGSI UNTUK MENAMPILKAN POP-UP UBAH PASSWORD ---
  void _showChangePasswordModal(BuildContext context) {
    final TextEditingController newPassController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    final Color brandColor = const Color(0xFFE55B5B);

    // Variabel state lokal untuk pop-up ini saja
    bool obscureNew = true;
    bool obscureConfirm = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        // 1. TAMBAHKAN STATEFULBUILDER DI SINI
        // 'setModalState' adalah kunci untuk me-refresh tampilan pop-up
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

                  // 2. Input Password Baru (Kirim state dan fungsi ubahnya)
                  _buildPasswordInput(
                    label: "Password Baru",
                    controller: newPassController,
                    isObscure: obscureNew,
                    onToggle: () {
                      // Gunakan setModalState, BUKAN setState biasa
                      setModalState(() {
                        obscureNew = !obscureNew;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  // 3. Input Konfirmasi Password
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password berhasil diubah!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
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

  // --- Helper Widget yang Diupdate ---
  // Sekarang menerima parameter isObscure dan onToggle
  Widget _buildPasswordInput({
    required String label,
    required TextEditingController controller,
    required bool isObscure,          // Data: Apakah sedang tersembunyi?
    required VoidCallback onToggle,   // Aksi: Apa yang terjadi saat mata diklik?
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscure, // Gunakan variabel dynamic
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE55B5B)),
            ),
            // Tombol Mata
            suffixIcon: IconButton(
              icon: Icon(
                // Ganti icon berdasarkan status
                isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle, // Panggil fungsi toggle saat diklik
            ),
          ),
        ),
      ],
    );
  }

  // --- Sub-widgets for the page structure ---

  Widget _buildCustomHeader(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check_box_outlined, color: color, size: 30),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("E-", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16, height: 1)),
                Text("VENTURE", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16, height: 1)),
              ],
            )
          ],
        ),
        Icon(Icons.notifications_outlined, color: color, size: 28),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              // Placeholder image
              image: NetworkImage('https://i.pravatar.cc/300'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daffa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "daffaprawira@students.usu.ac.id",
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// REUSABLE WIDGETS (The Clean Component)
// ==========================================

// 1. Data Class: Defines what a menu item looks like
class MenuItemData {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  MenuItemData({
    required this.icon,
    required this.text,
    required this.onTap, // Tambahan: parameter opsional
  });
}

// 2. The Menu Section Widget
class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;
  final Color brandColor;

  const MenuSection({
    super.key,
    required this.title,
    required this.items,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
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
                        size: 22
                    ),
                    minLeadingWidth: 20,
                    title: Row(
                      children: [
                        Container(
                          height: 24,
                          width: 1,
                          color: Colors.black12,
                        ),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),

                    // --- BAGIAN INI YANG DIPERBAIKI ---
                    onTap: item.onTap,
                    // ----------------------------------
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.only(left: 55, right: 16), // Saya ubah jadi 55 lagi biar rapi
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