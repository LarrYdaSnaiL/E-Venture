import 'package:eventure/api/database_service.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventure/widgets/app_header.dart';
import 'package:eventure/widgets/app_scaffold.dart';
import '../../models/event_model.dart';
import '../../navigation/app_router.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  final Color primaryColor = const Color(0xFFD64A53);

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('events/$eventId');

    return AppScaffold(
      body: SafeArea(
        child: StreamBuilder<DatabaseEvent>(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final raw = snapshot.data?.snapshot.value;
            if (raw == null || raw is! Map) {
              return const Center(child: Text('Event tidak ditemukan'));
            }

            final map = Map<String, dynamic>.from(raw);
            final event = EventModel.fromJson(map);
            final price = (map['price'] as String?) ?? 'Gratis';

            final tags = event.tags
                .split(',')
                .map((t) => t.trim())
                .where((t) => t.isNotEmpty)
                .toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHeader(),
                  _buildBannerSection(context, event),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.organizerName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (tags.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: tags
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5E5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      tag,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFFD64F5C),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        const SizedBox(height: 20),
                        _buildSectionTitle("Deskripsi Event"),
                        _buildInfoContainer(
                          height: 120,
                          child: SingleChildScrollView(
                            child: Text(
                              event.description,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      price,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event.isOnline
                                          ? 'Mode: Online'
                                          : 'Mode: Offline',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async => {
                                          await DatabaseService()
                                              .registerForEvent(
                                                eventId,
                                                await AuthProvider()
                                                    .currentUser(),
                                              ),
                                        },
                                        child: const Text("RSVP"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 6.0),
                                    child: Text(
                                      "Lokasi Acara",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  if (!event.isOnline)
                                    InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () =>
                                          _openLocationInMaps(context, event),
                                      child: _buildInfoContainer(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Alamat:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              cleanAddress(
                                                event.locationAddress,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(
                                                  Icons.map,
                                                  size: 14,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Lihat di Google Maps",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    _buildInfoContainer(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Acara Online",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            event.onlineLink ?? '-',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle("Waktu diselenggarakan"),
                        _buildInfoContainer(
                          child: Text(_buildDateTimeLabel(event)),
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle("FAQ"),
                        _buildInfoContainer(
                          height: 100,
                          child: const Text(
                            "Q: Apakah acara ini gratis?\n"
                            "A: Lihat informasi harga di kotak RSVP.\n\n"
                            "Q: Apakah dapat sertifikat?\n"
                            "A: Tergantung kebijakan penyelenggara.",
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context, EventModel event) {
    final bannerUrl = event.bannerUrl;
    final avatarUrl = event.photoUrl;

    final timeLabel = "${event.startTime} - ${event.endTime} WIB";

    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: bannerUrl != null && bannerUrl.isNotEmpty
                    ? NetworkImage(bannerUrl)
                    : const NetworkImage(
                            'https://via.placeholder.com/800x400/E55B5B/FFFFFF?text=Banner+Event',
                          )
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(height: 180, color: const Color(0xFF2C1F38).withAlpha(80)),
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    event.eventType.toUpperCase(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              onTap: () => context.go(AppRoutes.home),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 185,
            right: 20,
            child: Text(
              event.isOnline ? "Online\n$timeLabel" : "Offline\n$timeLabel",
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : const NetworkImage(
                        'https://via.placeholder.com/200x200/E55B5B/FFFFFF?text=Foto',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildInfoContainer({required Widget child, double? height}) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
        color: Colors.pink.withAlpha(2),
      ),
      child: child,
    );
  }

  String _buildDateTimeLabel(EventModel event) {
    String dateLabel = event.eventDay;
    try {
      final parsed = DateTime.parse(event.eventDay);
      dateLabel = DateFormat('EEEE, dd MMMM yyyy').format(parsed);
    } catch (_) {}
    return "$dateLabel\n${event.startTime} - ${event.endTime} WIB";
  }

  String cleanAddress(String raw) {
    return raw.replaceAll(",,", ",").replaceAll(RegExp(r',$'), "").trim();
  }

  Future<void> _openLocationInMaps(
    BuildContext context,
    EventModel event,
  ) async {
    if (event.isOnline) return;

    final lat = event.locationLat;
    final lng = event.locationLng;
    final address = cleanAddress(event.locationAddress);

    Uri uri;
    if (lat != null && lng != null) {
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );
    } else {
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
      );
    }

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka Google Maps')),
      );
    }
  }
}
