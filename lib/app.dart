import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

class ParentChildDiagnosisApp extends StatelessWidget {
  const ParentChildDiagnosisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '親子コンディション診断',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // 日本語ロケールを明示的に指定（中国語グリフ混入を防ぐ）
      locale: const Locale('ja', 'JP'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const HomeScreen(),
    );
  }
}
