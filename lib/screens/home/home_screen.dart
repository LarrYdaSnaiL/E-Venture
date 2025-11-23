import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/event_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Tersedia',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFD64F5C),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                EventCard(
                  imageUrl: 'assets/images/placeholder_eventcard.jpg',
                  eventName: 'Penerapan Sistem Manajemen Mutu ISO 9001 yang Efektif untuk Organisasi',
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
    );
  }
}
