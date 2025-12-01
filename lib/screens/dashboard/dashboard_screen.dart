import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../../widgets/event_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // dummy data dulu, nanti bisa diganti list dari Firebase
    final events = [
      {
        'image': 'assets/images/placeholder_eventcard.jpg',
        'name':
            'Penerapan Sistem Manajemen Mutu ISO 9001 yang Efektif untuk Organisasi',
        'type': 'Technology',
        'price': 'Gratis',
        'tags': ['SQA', 'Digital', 'Tech'],
      },
      {
        'image': 'assets/images/placeholder_eventcard.jpg',
        'name': 'Workshop UI/UX Design untuk Aplikasi Mobile',
        'type': 'Design',
        'price': 'Rp 25.000',
        'tags': ['UI/UX', 'Mobile', 'Design'],
      },
      {
        'image': 'assets/images/placeholder_eventcard.jpg',
        'name': 'Seminar Cloud Computing untuk Mahasiswa',
        'type': 'Technology',
        'price': 'Gratis',
        'tags': ['Cloud', 'AWS', 'GCP'],
      },
      {
        'image': 'assets/images/placeholder_eventcard.jpg',
        'name': 'Pelatihan Public Speaking untuk Pemula',
        'type': 'Softskill',
        'price': 'Rp 10.000',
        'tags': ['Softskill', 'Speaking'],
      },
    ];

    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search + button
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: CustomTextField(
                            hintText: "Cari Event...",
                            icon: Icons.search,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: CustomButton(text: "Cari", onPressed: () {}),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // GRID 2 KOLOM
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        // atur proporsi tinggi:lebar card
                        childAspectRatio: 0.72,
                      ),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final e = events[index];
                        return EventCard(
                          imageUrl: e['image'] as String,
                          eventName: e['name'] as String,
                          eventType: e['type'] as String,
                          price: e['price'] as String,
                          tags: (e['tags'] as List<String>),
                          showButton: true,
                          onButtonPressed: () {

                          },
                        );
                      },
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
}
