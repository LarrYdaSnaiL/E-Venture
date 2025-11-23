import 'package:eventure/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // --- Konsistensi Warna ---
  final Color _scaffoldBg = const Color(0xFFF9F5F6);
  final Color _brandColor = const Color(0xFFE55B5B);

  // --- Controllers untuk Input Text ---
  // (Nantinya ini akan diisi data asli dari database/API)
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data awal (Hardcoded untuk contoh saat ini)
    _nameController = TextEditingController(text: "Daffa");
    _emailController = TextEditingController(text: "daffaprawira@students.usu.ac.id");
    _phoneController = TextEditingController(text: "081234567890");
  }

  @override
  void dispose() {
    // Bersihkan controller agar tidak memakan memori
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5, // Sedikit bayangan agar terpisah dari background
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _brandColor),
          onPressed: () => context.go(AppRoutes.home), // yey
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          // Opsi tombol simpan di pojok kanan atas (opsional)
          TextButton(
            onPressed: _saveProfile,
            child: Text("Simpan", style: TextStyle(color: _brandColor, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // --- 1. Bagian Foto Profil ---
            _buildProfileImagePicker(),

            const SizedBox(height: 35),

            // --- 2. Form Input ---
            // Kita bungkus dalam Container putih agar rapi
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: "Nama Lengkap",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: "Email Address",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _phoneController,
                    label: "Nomor Telepon",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- 3. Tombol Simpan Utama ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brandColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FUNGSI LOGIKA (Dummy) ---
  void _saveProfile() {
    // Di sini nanti temanmu akan memasukkan logika simpan ke database.
    // Untuk sekarang, kita hanya tampilkan pesan sukses dan kembali.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Perubahan berhasil disimpan!")),
    );
    // Tutup keyboard jika terbuka
    FocusScope.of(context).unfocus();
    // Kembali ke halaman profil setelah jeda singkat
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) Navigator.pop(context);
    });
  }


  // --- WIDGET BUILDER HELPERS ---

  // Widget untuk Foto Profil dengan Ikon Kamera
  Widget _buildProfileImagePicker() {
    return Center(
      child: Stack(
        children: [
          // Foto Utama
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
              image: const DecorationImage(
                // Menggunakan gambar yang sama dengan halaman profil sebelumnya
                image: NetworkImage('https://i.pravatar.cc/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Tombol Kamera di pojok kanan bawah
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Buka Galeri/Kamera..."))
                );
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: _brandColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Reusable untuk Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 14
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey[400]),
            filled: true,
            fillColor: _scaffoldBg, // Warna latar input sedikit abu/pink
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none, // Hilangkan border default
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              // Saat diklik, border menyala warna brand
              borderSide: BorderSide(color: _brandColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}