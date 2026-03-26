import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_string.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/theme_manager.dart';
import 'package:emr_application/core/providers/auth_provider.dart';
import 'package:emr_application/core/providers/appointment_provider.dart';
import 'package:emr_application/feature/view/login_page.dart';
import 'package:emr_application/feature/view/dashboard_page.dart' as dashboard;
import 'package:emr_application/feature/view/consultation_screen.dart'
    as consultations;
import 'package:emr_application/feature/view/booking_appointment.dart';
import 'package:emr_application/feature/view/no_chat.dart';
import 'package:emr_application/feature/view/chat.dart';
import 'package:emr_application/feature/view/past_consultation.dart';
import 'package:emr_application/feature/view/consultation_details.dart';
import 'package:emr_application/feature/report/report.dart';
import 'package:emr_application/feature/report/no_report.dart';
import 'package:emr_application/feature/view/profile.dart';
import 'package:emr_application/feature/view/medication_upcomming.dart';
import 'package:emr_application/feature/view/open_chat.dart';
import 'package:emr_application/feature/view/settings_page.dart';
import 'package:emr_application/feature/view/notifications_screen.dart';
import 'package:emr_application/feature/view/videochat.dart';

import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final themeManager = ThemeManager();
  await themeManager.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeManager),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()..fetchAppointments()),
      ],
      child: const EMRApp(),
    ),
  );
}

class ZoomVideoSdkProvider extends StatefulWidget {
  const ZoomVideoSdkProvider({super.key});

  @override
  State<ZoomVideoSdkProvider> createState() => _ZoomVideoSdkProviderState();
}

class _ZoomVideoSdkProviderState extends State<ZoomVideoSdkProvider> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initZoom();
  }

  Future<void> _initZoom() async {
    try {
      var zoom = ZoomVideoSdk();
      InitConfig initConfig = InitConfig(
        domain: "zoom.us",
        enableLog: true,
      );
      await zoom.initSdk(initConfig);
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Zoom Initialization Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const Videochat();
  }
}

class EMRApp extends StatelessWidget {
  const EMRApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access themeManager via Provider
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeManager.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.black),
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const dashboard.DashboardPage(),
        '/dashboard': (context) => const dashboard.DashboardPage(),
        '/booking': (context) => const BookAppointmentScreen(),
        '/no_chat': (context) => const NoChatPage(),
        '/chat': (context) => const ChatPage(),
        '/consultation_details': (context) => const ConsultationDetailsScreen(),
        '/past-consultation': (context) => const PastConsultationsScreen(),
        '/upcoming-consultation': (context) =>
            const consultations.ConsultationsScreen(),
        '/report': (context) => const ReportsScreen(),
        '/no_report': (context) => const NoReportScreen(),
        '/profile': (context) => const ProfilePage(),
        '/medication_upcoming': (context) => const MedicationScreen(),
        '/open_chat': (context) => const OpenChatPage(),
        '/settings': (context) => const SettingsPage(),
        '/notifications': (context) => const NotificationsScreen(),
        '/zoom_meeting': (context) => const ZoomVideoSdkProvider(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkLoginStatus();

    if (!mounted) return;

    if (authProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.applogo,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
