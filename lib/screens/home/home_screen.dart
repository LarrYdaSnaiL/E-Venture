import 'package:eventure/api/database_service.dart';
import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/event_card.dart';
import '../event/create_event_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color? get primaryColor => const Color(0xFFD64A53);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 40 - 12) / 2;

    return AppScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeader(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Row(
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
                        child: CustomButton(text: "Cari", onPressed: () => {}),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: 80,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),

                        StreamBuilder<DatabaseEvent>(
                          stream: DatabaseService().getAllEventsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Terjadi kesalahan saat memuat event.",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.red),
                                ),
                              );
                            }

                            final data = snapshot.data?.snapshot.value;

                            if (data == null) {
                              return const Center(
                                child: Text(
                                  "Belum ada event tersedia",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }

                            final Map<dynamic, dynamic> raw =
                                data as Map<dynamic, dynamic>;
                            final events = raw.values.toList();

                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                for (var e in events)
                                  SizedBox(
                                    width: cardWidth,
                                    child: EventCard(
                                      imageUrl:
                                          (e['bannerUrl'] ?? '') as String,
                                      eventName:
                                          (e['title'] ?? 'Tanpa Nama')
                                              as String,
                                      eventType:
                                          (e['eventType'] ?? '-') as String,
                                      price: (e['price'] ?? 'Gratis') as String,
                                      tags: (e['tags'] as String? ?? "")
                                          .split(",")
                                          .map((tag) => tag.trim())
                                          .where((tag) => tag.isNotEmpty)
                                          .toList(),
                                      showButton: false,
                                      onCardPressed: () => context.go(
                                        AppRoutes.eventDetail.replaceFirst(
                                          ':eventId',
                                          e['id'] as String,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 20,
              right: 20,
              child: SizedBox(
                width: 56,
                height: 56,
                child: FloatingActionButton(
                  onPressed: () {
                    context.go(AppRoutes.createEvent);
                  },
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: Icon(Icons.add, color: primaryColor, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
