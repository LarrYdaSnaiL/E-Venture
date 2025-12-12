import 'package:eventure/api/database_service.dart';
import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import 'package:eventure/widgets/custom_button.dart';
import 'package:eventure/widgets/custom_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/event_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                        child: CustomButton(text: "Cari", onPressed: () {}),
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
                                      showButton: true,
                                      onButtonPressed: () {
                                        final id = (e['id'] as String?) ?? '';
                                        final title =
                                            (e['title'] as String?) ?? 'Event';
                                        if (id.isEmpty) return;
                                        _handleShowQr(context, id, title);
                                      },
                                      cardClickable: true,
                                      onCardPressed: () {
                                        final id = (e['id'] as String?) ?? '';
                                        if (id.isEmpty) return;
                                        context.go(
                                          AppRoutes.eventDetail.replaceFirst(
                                            ':eventId',
                                            id,
                                          ),
                                        );
                                      },
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
          ],
        ),
      ),
    );
  }

  Future<void> _handleShowQr(
    BuildContext context,
    String eventId,
    String title,
  ) async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final userId = await auth.currentUser(); // sesuaikan dengan AuthProvider

      if (userId == null || userId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan login terlebih dahulu')),
        );
        return;
      }

      final db = DatabaseService();
      final alreadyRegistered = await db.checkRegistered(eventId, userId);

      if (!alreadyRegistered) {
        await db.registerForEvent(eventId, userId);
      }

      final qrData = '$eventId|$userId';

      _showQrDialog(context, qrData, title, eventId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyiapkan QR. Coba lagi.')),
      );
    }
  }

  void _showQrDialog(
    BuildContext context,
    String qrData,
    String title,
    String eventId,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Kode QR Event",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  QrImageView(data: qrData, size: 220),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Event ID: $eventId",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Tutup"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
