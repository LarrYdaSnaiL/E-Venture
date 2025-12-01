import 'package:flutter/material.dart';
import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  // Warna utama sesuai desain (Merah/Pink)
  final Color primaryColor = const Color(0xFFD64A53);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Global
              const AppHeader(),

              // 2. Banner & Profile Section
              _buildBannerSection(context),

              // 3. Konten Utama
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul & Penyelenggara
                    const Text(
                      "Level Up with Lenovo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Masketir Project",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Deskripsi Event
                    _buildSectionTitle("Deskripsi Event"),
                    _buildInfoContainer(
                      height: 120, // Tinggi fix seperti di gambar
                      child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Baris: RSVP Box (Kiri) & Peta (Kanan)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kotak RSVP & Harga
                        Expanded(
                          flex: 4, // Rasio lebar
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100, // Samakan tinggi dengan peta
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Gratis",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 0),
                                        ),
                                        onPressed: () {
                                          // Action RSVP
                                        },
                                        child: const Text("RSVP"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Kotak Peta (Lokasi)
                        Expanded(
                          flex: 6, // Peta lebih lebar sedikit
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6.0),
                                child: Text("Lokasi Acara", style: TextStyle(fontSize: 14)),
                              ),
                              Container(
                                height: 75, // Tinggi visual peta
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    // Placeholder Maps
                                    image: NetworkImage('https://picsum.photos/300/150'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Waktu Diselenggarakan
                    _buildSectionTitle("Waktu diselenggarakan"),
                    _buildInfoContainer(
                      child: const Text("Jumat, 26 September 2025\n09.00 s.d 11.30 WIB"),
                    ),

                    const SizedBox(height: 16),

                    // FAQ
                    _buildSectionTitle("FAQ"),
                    _buildInfoContainer(
                      height: 100,
                      child: const Text(
                        "Q: Apakah acara ini gratis?\nA: Ya, acara ini 100% gratis.\nQ: Apakah dapat sertifikat?\nA: Ya, e-certificate akan dikirim via email.",
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Bagian Banner & Header ---
  Widget _buildBannerSection(BuildContext context) {
    return SizedBox(
      height: 240, // Tinggi total area banner
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gambar Banner Gelap
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/400'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay gelap
          Container(
            height: 180,
            color: const Color(0xFF2C1F38).withOpacity(0.8), // Warna ungu tua gelap sesuai gambar
          ),

          // Teks di dalam Banner
          const Positioned(
            top: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Code. Create. Inspire:",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Level Up with Lenovo",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Info kecil di banner
                Text("WORKSHOP", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("Jumat, 26 September 2025", style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
          ),

          // Tombol Back (Kotak Merah)
          Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
            ),
          ),

          // Info Lokasi Text Floating (Kanan Bawah Banner)
          const Positioned(
            top: 185, // Sedikit di bawah banner
            right: 20,
            child: Text(
              "Taman Astaka Pancing\n17.00 WIB",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),

          // Avatar Bulat
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
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Judul Section Kecil ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  // --- Helper: Kotak Info dengan Border Merah ---
  Widget _buildInfoContainer({required Widget child, double? height}) {
    return Container(
      width: double.infinity,
      height: height, // Bisa null jika ingin height otomatis (wrap content)
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor), // Border merah
        borderRadius: BorderRadius.circular(12),
        color: Colors.pink.withOpacity(0.02), // Sedikit tint pink background (opsional)
      ),
      child: child,
    );
  }
}