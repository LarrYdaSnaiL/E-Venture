import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk SystemNavigator.pop()
import 'package:go_router/go_router.dart';
import 'package:eventure/utils/toast_helper.dart'; // Import ToastHelper Anda

class ExitConfirmation extends StatefulWidget {
  final Widget child;

  const ExitConfirmation({super.key, required this.child});

  @override
  State<ExitConfirmation> createState() => _ExitConfirmationState();
}

class _ExitConfirmationState extends State<ExitConfirmation> {
  DateTime? _lastPressedAt; // Menyimpan waktu terakhir tombol back ditekan

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Kita tangani manual
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Cek apakah masih ada halaman sebelumnya di stack GoRouter
        if (GoRouter.of(context).canPop()) {
          // Jika ada, mundur saja seperti biasa
          GoRouter.of(context).pop();
          return;
        }

        // Jika sudah di root (tidak bisa mundur), jalankan logika "Double Tap to Exit"
        final now = DateTime.now();
        final difference = _lastPressedAt == null
            ? null
            : now.difference(_lastPressedAt!);

        // Jika ini tekanan pertama atau sudah lebih dari 2 detik sejak tekanan terakhir
        if (difference == null || difference > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          // Tampilkan Toast menggunakan helper Anda
          ToastHelper.showShortToast("Tekan sekali lagi untuk keluar");
        } else {
          // Jika ditekan lagi dalam waktu kurang dari 2 detik, tutup aplikasi
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
