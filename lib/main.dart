import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/diagnosis_provider.dart';
import 'providers/subscription_provider.dart';
import 'providers/history_provider.dart';
import 'providers/ad_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Phase 2以降: await Firebase.initializeApp();

  final authProvider = AuthProvider();
  await authProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosisProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AdProvider()),
      ],
      child: const ParentChildDiagnosisApp(),
    ),
  );
}
