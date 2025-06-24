// // import 'package:flutter/material.dart';
// // import 'package:fuel_card_app/screens/register_screen.dart';
// // import 'package:provider/provider.dart';
// // import 'screens/login_screen.dart';
// // import 'screens/dashboard_screen.dart';
// // import 'screens/history_screen.dart';
// // import 'screens/map_screen.dart';
// // import 'screens/transaction_detail_screen.dart';
// // import 'screens/profile_screen.dart';

// // void main() {
// //   runApp(
// //     MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(create: (_) => AppState()),
// //       ],
// //       child: MyApp(),
// //     ),
// //   );
// // }

// // class AppState extends ChangeNotifier {
// //   int _selectedCardId = 1;
// //   final String _userName = 'Amadou Diallo'; // Static user data
// //   final String _email = 'amadou.diallo@example.com'; // Static user data

// //   int get selectedCardId => _selectedCardId;
// //   String get userName => _userName;
// //   String get email => _email;

// //   void setSelectedCard(int cardId) {
// //     _selectedCardId = cardId;
// //     notifyListeners();
// //   }

// //   void setUserData(String name, String email) {}
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Fuel Card App',
// //       theme: ThemeData(
// //         primaryColor: Color(0xFF1E3A8A), // Bleu pétrole
// //         scaffoldBackgroundColor: Color(0xFFF5F5DC), // Beige désert
// //         colorScheme: ColorScheme.fromSwatch().copyWith(
// //           secondary: Color(0xFFF59E0B), // Orange sable
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Color(0xFF4B5EAA)), // Gris anthracite
// //         ),
// //       ),
// //       initialRoute: '/dashboard',
// //       routes: {
// //         '/login': (context) => LoginScreen(),
// //         '/register': (context) => RegisterScreen(),
// //         '/dashboard': (context) => DashboardScreen(),
// //         '/history': (context) => HistoryScreen(),
// //         '/map': (context) => MapScreen(),
// //         '/transaction_detail': (context) => TransactionDetailScreen(),
// //         '/profile': (context) => ProfileScreen(),
// //         '/qr_scanner': (context) => const QRScannerScreen(),
// //         // '/pay':(context)=>
// //       },
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'screens/dashboard_screen.dart';

// // void main() {
// //   runApp(const FuelCardApp());
// // }

// // class FuelCardApp extends StatelessWidget {
// //   const FuelCardApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (_) => AppState(),
// //       child: MaterialApp(
// //         title: 'Fuel Card App',
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //           useMaterial3: true,
// //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
// //           cardColor: Colors.white,
// //         ),
// //         initialRoute: '/',
// //         routes: {
// //           '/': (context) => const DashboardScreen(),
// //           '/notifications': (context) => const Placeholder(),
// //           '/topup': (context) => const Placeholder(),
// //           '/qr_scanner': (context) => const QRScannerScreen(),
// //           '/history': (context) => const Placeholder(),
// //           '/map': (context) => const Placeholder(),
// //           '/profile': (context) => const Placeholder(),
// //           '/transaction_detail': (context) => const Placeholder(),
// //         },
// //       ),
// //     );
// //   }
// // }

// // class AppState with ChangeNotifier {
// //   int? _selectedCardId;

// //   int? get selectedCardId => _selectedCardId;

// //   void setSelectedCard(int cardId) {
// //     _selectedCardId = cardId;
// //     notifyListeners();
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:fuel_card_app/data/database_helper.dart';
// import 'package:fuel_card_app/screens/edit_profile_screen.dart';
// import 'package:provider/provider.dart';
// import 'screens/dashboard_screen.dart';
// import 'screens/history_screen.dart';
// import 'screens/map_screen.dart';
// import 'screens/profile_screen.dart';
// import 'screens/transaction_detail_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppState(),
//       child: MaterialApp(
//         title: 'Fuel App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSwatch(
//             primarySwatch: Colors.blue,
//             accentColor: Colors.amber,
//             backgroundColor: Colors.grey[100],
//           ),
//           // cardTheme: CardTheme(
//           //   elevation: 4,
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(12),
//           //   ),
//           // ),
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const DashboardScreen(),
//           '/history': (context) => const HistoryScreen(),
//           '/map': (context) => const MapScreen(),
//           '/profile': (context) => const ProfileScreen(),
//           '/transaction_detail': (context) => const TransactionDetailScreen(),
//           '/edit_profile': (context) => const EditProfileScreen(),
//           '/login': (context) => const Scaffold(
//                 body: Center(child: Text('Écran de connexion (placeholder)')),
//               ),
//         },
//       ),
//     );
//   }
// }

// class AppState extends ChangeNotifier {
//   int? _selectedCardId;
//   int? _userId;
//   String _userName = '';
//   String _userEmail = '';

//   int? get selectedCardId => _selectedCardId;
//   int? get userId => _userId;
//   String get userName => _userName;
//   String get userEmail => _userEmail;

//   AppState() {
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final dbHelper = DatabaseHelper.instance;
//     final user = await dbHelper.getUser(1); // ID utilisateur par défaut
//     if (user != null) {
//       _userId = user.id;
//       _userName = user.name;
//       _userEmail = user.email;
//       notifyListeners();
//     }
//   }

//   void setSelectedCard(int cardId) {
//     _selectedCardId = cardId;
//     notifyListeners();
//   }

//   void updateUser({required String name, required String email}) {
//     _userName = name;
//     _userEmail = email;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/transaction_detail_screen.dart';
import 'screens/edit_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Fuel App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            accentColor: Colors.amber,
            backgroundColor: Colors.grey[100],
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/': (context) => const DashboardScreen(),
          '/history': (context) => const HistoryScreen(),
          '/map': (context) => const MapScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/transaction_detail': (context) => const TransactionDetailScreen(),
          '/edit_profile': (context) => const EditProfileScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/qr_scanner': (context) => const QRScannerScreen(),
        },
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  int? _selectedCardId;
  int? _userId;
  String _userName = '';
  String _userEmail = '';
  bool _isLoggedIn = false;

  int? get selectedCardId => _selectedCardId;
  int? get userId => _userId;
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isLoggedIn => _isLoggedIn;

  void setUserData(int userId, String name, String email) {
    _userId = userId;
    _userName = name;
    _userEmail = email;
    _isLoggedIn = true;
    notifyListeners();
  }

  void setSelectedCard(int cardId) {
    _selectedCardId = cardId;
    notifyListeners();
  }

  void updateUser({required String name, required String email}) {
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _userId = null;
    _userName = '';
    _userEmail = '';
    _selectedCardId = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}