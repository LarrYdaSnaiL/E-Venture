import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    Row(
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

                    SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        EventCard(
                          imageUrl: 'assets/images/placeholder_eventcard.jpg',
                          eventName:
                              'Penerapan Sistem Manajemen Mutu ISO 9001 yang Efektif untuk Organisasi',
                          eventType: 'Technology',
                          price: 'Gratis',
                          tags: ['SQA', 'Digital', 'Tech'],
                          showButton: false,
                        ),
                        EventCard(
                          imageUrl: 'assets/images/placeholder_eventcard.jpg',
                          eventName:
                              'Penerapan Sistem Manajemen Mutu ISO 9001 yang Efektif untuk Organisasi',
                          eventType: 'Technology',
                          price: 'Gratis',
                          tags: ['SQA', 'Digital', 'Tech'],
                          showButton: false,
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
}
