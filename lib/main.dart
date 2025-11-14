import 'package:eventure/navigation/app_router.dart';
import 'package:eventure/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp.router(
        title: 'E-Venture',
        routerConfig: createRouter(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
