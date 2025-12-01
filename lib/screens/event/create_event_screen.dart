import 'package:flutter/material.dart';
import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
// Jika CustomTextField kamu mendukung border merah dan label luar, kamu bisa memakainya.
// Namun untuk presisi desain sesuai gambar (label di atas, border merah),
// saya menggunakan TextField standar yang dikustomisasi di sini.
import 'package:eventure/widgets/custom_textfield.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Warna sesuai desain (Merah/Pink)
  final Color primaryColor = const Color(0xFFD64A53);

  @override
  Widget build(BuildContext context) {
    // Menggunakan AppScaffold buatanmu
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header (Widget buatanmu)
            const AppHeader(),

            // 2. Konten Scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSection(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          _buildLabeledTextField("Nama Event"),
                          const SizedBox(height: 12),
                          _buildLabeledTextField("Nama Penyelenggara"),
                          const SizedBox(height: 12),
                          _buildFilePicker("Surat Keputusan", "SK.pdf"),
                          const SizedBox(height: 12),
                          _buildLabeledTextField("Deskripsi Event (Maks : 250 kata)", maxLines: 5),
                          const SizedBox(height: 12),
                          _buildLabeledTextField("Lokasi Acara"),
                          const SizedBox(height: 12),
                          _buildLabeledTextField("Waktu diselenggarakan"),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets Bagian Banner & Profile ---
  Widget _buildBannerSection() {
    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gambar Banner
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Gunakan aset kamu: AssetImage('assets/images/banner_placeholder.jpg')
                image: NetworkImage('https://picsum.photos/800/400'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Gelap
          Container(
            height: 180,
            color: Colors.black.withOpacity(0.4),
          ),
          // Teks di Banner
          const Positioned(
            right: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Code. Create. Inspire:",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Level Up with Lenovo",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Tombol Back Merah
          Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
            ),
          ),
          // Foto Profil Bulat
          Positioned(
            bottom: 0,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 50,
                // Gunakan aset kamu: AssetImage('assets/images/user_avatar.jpg')
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget: Input Field dengan Label ---
  Widget _buildLabeledTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widget: File Picker Custom ---
  Widget _buildFilePicker(String label, String fileNamePlaceholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  // TODO: Implement File Picker Logic
                },
                child: const Text("Pilih File"),
              ),
              const SizedBox(width: 12),
              Text(
                fileNamePlaceholder,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}