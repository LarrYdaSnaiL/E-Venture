import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/event_card.dart';
import '../event/create_event_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color? get primaryColor => const Color(0xFFD64A53);

  @override
  Widget build(BuildContext context) {
    // 1. Ambil lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    // 2. Hitung lebar kartu agar pas 2 kolom
    // Rumus: (Lebar Layar - Total Padding Horizontal - Spacing) / 2
    // Padding Kiri (20) + Kanan (20) = 40
    // Spacing antar kartu = 12
    final double cardWidth = (screenWidth - 40 - 12) / 2;

    return AppScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- BAGIAN FIXED ---
                const AppHeader(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          hintText: "Cari Event...",
                          icon: Icons.search,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          text: "Cari",
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                ),

                // --- BAGIAN SCROLLABLE ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),

                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            // 3. Bungkus setiap EventCard dengan SizedBox selebar cardWidth
                            SizedBox(
                              width: cardWidth,
                              child: EventCard(
                                imageUrl: 'assets/images/placeholder_eventcard.jpg',
                                eventName: 'Penerapan Sistem Manajemen Mutu ISO 9001',
                                eventType: 'Technology',
                                price: 'Gratis',
                                tags: const ['SQA', 'Digital', 'Tech'],
                                showButton: false,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: EventCard(
                                imageUrl: 'assets/images/placeholder_eventcard.jpg',
                                eventName: 'Workshop UI/UX Design Fundamental',
                                eventType: 'Design',
                                price: 'Rp 50.000',
                                tags: const ['UI/UX', 'Creative'],
                                showButton: false,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: EventCard(
                                imageUrl: 'assets/images/placeholder_eventcard.jpg',
                                eventName: 'Belajar Flutter Dasar',
                                eventType: 'Coding',
                                price: 'Gratis',
                                tags: const ['Mobile', 'Dart'],
                                showButton: false,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: EventCard(
                                imageUrl: 'assets/images/placeholder_eventcard.jpg',
                                eventName: 'Seminar Bisnis Digital',
                                eventType: 'Business',
                                price: 'Rp 100.000',
                                tags: const ['Marketing', 'Bisnis'],
                                showButton: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // FAB
            Positioned(
              bottom: 20,
              right: 20,
              child: SizedBox(
                width: 56,
                height: 56,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateEventScreen()),
                    );
                  },
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
