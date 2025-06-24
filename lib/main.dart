import 'package:flutter/material.dart';
import 'package:fuel_card_app/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/map_screen.dart';
import 'screens/transaction_detail_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  int _selectedCardId = 1;
  final String _userName = 'Amadou Diallo'; // Static user data
  final String _email = 'amadou.diallo@example.com'; // Static user data

  int get selectedCardId => _selectedCardId;
  String get userName => _userName;
  String get email => _email;

  void setSelectedCard(int cardId) {
    _selectedCardId = cardId;
    notifyListeners();
  }

  void setUserData(String name, String email) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Card App',
      theme: ThemeData(
        primaryColor: Color(0xFF1E3A8A), // Bleu pétrole
        scaffoldBackgroundColor: Color(0xFFF5F5DC), // Beige désert
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFF59E0B), // Orange sable
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF4B5EAA)), // Gris anthracite
        ),
      ),
      initialRoute: '/dashboard',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/history': (context) => HistoryScreen(),
        '/map': (context) => MapScreen(),
        '/transaction_detail': (context) => TransactionDetailScreen(),
        '/profile': (context) => ProfileScreen(),
        '/qr_scanner': (context) => const QRScannerScreen(),
        // '/pay':(context)=>
      },
    );
  }
}