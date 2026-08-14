import 'package:firebase_core/firebase_core.dart';
import 'package:AgentServe/data/maps/google_maps_initializer.dart';
import 'package:AgentServe/presentation/home_screen.dart';
import 'package:AgentServe/presentation/auth/login_screen.dart';
import 'package:AgentServe/presentation/auth/email_verification_screen.dart';
import 'package:AgentServe/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:AgentServe/application/workflow_orchestrator.dart';
import 'package:AgentServe/data/agent/platform_service.dart';
import 'package:AgentServe/data/repositories/provider_repository_impl.dart';
import 'package:AgentServe/data/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  preloadGoogleMaps();
  await LocalNotificationService.initialize();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("No .env file found. Please create one with GEMINI_API_KEY.");
  }

  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final mapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  final geminiModel = dotenv.env['GEMINI_MODEL'] ?? '';
  final geminiEnabled = dotenv.env['GEMINI_ENABLED']?.toLowerCase() != 'false';

  final agentService = AgentServePlatformService(
    apiKey,
    model: geminiModel,
    useGeminiForIntent: geminiEnabled,
  );
  final providerRepository = ProviderRepository(mapsApiKey);

  runApp(
    ProviderScope(
      overrides: [
        agentServePlatformProvider.overrideWithValue(agentService),
        providerRepositoryProvider.overrideWithValue(providerRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'AgentServe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: authState.user == null
          ? const LoginScreen()
          : (!authState.user!.emailVerified
              ? const EmailVerificationScreen()
              : const HomeScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
