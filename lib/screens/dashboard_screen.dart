// import 'package:flutter/material.dart';
// import 'package:fuel_card_app/main.dart';
// import 'package:provider/provider.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import '../data/static_data.dart';
// import '../models/fuel_card.dart';
// import '../models/transaction.dart';
// import '../widgets/custom_card.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;
//     final appState = Provider.of<AppState>(context);

//     final selectedCard = StaticData.fuelCards.firstWhere(
//       (card) => card.id == appState.selectedCardId,
//       orElse: () => StaticData.fuelCards[0],
//     );

//     final recentTransactions = StaticData.transactions
//         .where((t) => t.fuelCardId == selectedCard.id)
//         .take(3)
//         .toList();

//     return Scaffold(
//       backgroundColor: theme.colorScheme.onPrimary,
//       appBar: AppBar(
//         title: const Text('Tableau de bord'),
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//         centerTitle: true,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Badge(
//               smallSize: 8,
//               child: const Icon(Icons.notifications_outlined),
//             ),
//             onPressed: () => Navigator.pushNamed(context, '/notifications'),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await Future.delayed(const Duration(seconds: 1));
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               _buildCardSelector(context, appState, theme, selectedCard),
//               const SizedBox(height: 24),
//               _buildBalanceCard(context, theme, colors, selectedCard),
//               const SizedBox(height: 24),
//               _buildQuickActions(context, theme, recentTransactions),
//               const SizedBox(height: 32),
//               _buildTransactionsSection(context, theme, recentTransactions),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(context, 0),
//     );
//   }

//   Widget _buildCardSelector(BuildContext context, AppState appState,
//       ThemeData theme, FuelCard selectedCard) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<int>(
//           isExpanded: true,
//           value: appState.selectedCardId,
//           icon: const Icon(Icons.arrow_drop_down),
//           style: theme.textTheme.titleMedium,
//           dropdownColor: theme.cardColor,
//           items: StaticData.fuelCards.map((FuelCard card) {
//             return DropdownMenuItem<int>(
//               value: card.id,
//               child: Row(
//                 children: [
//                   Icon(Icons.credit_card, color: theme.primaryColor, size: 20),
//                   const SizedBox(width: 12),
//                   Text(
//                     '•••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
//                     style: theme.textTheme.titleMedium,
//                   ),
//                   if (card.id == selectedCard.id)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: theme.primaryColor.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           'Active',
//                           style: theme.textTheme.labelSmall?.copyWith(
//                             color: theme.primaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           }).toList(),
//           onChanged: (value) => appState.setSelectedCard(value!),
//         ),
//       ),
//     );
//   }

//   Widget _buildBalanceCard(BuildContext context, ThemeData theme,
//       ColorScheme colors, FuelCard card) {
//     return CustomCard(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'SOLDE DISPONIBLE',
//                 style: theme.textTheme.labelLarge?.copyWith(
//                   color: colors.onSurface.withOpacity(0.6),
//                 ),
//               ),
//               Icon(Icons.credit_card, color: theme.primaryColor),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             '${card.balance.toStringAsFixed(0)} XOF',
//             style: theme.textTheme.headlineMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.primaryColor,
//             ),
//           ),
//           const SizedBox(height: 16),
//           LinearProgressIndicator(
//             value: card.balance / 100000,
//             backgroundColor: colors.surfaceContainerHighest,
//             color: theme.primaryColor,
//             minHeight: 6,
//             borderRadius: BorderRadius.circular(3),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Limite: 100 000 XOF',
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   color: colors.onSurface.withOpacity(0.6),
//                 ),
//               ),
//               Text(
//                 '${(card.balance / 100000 * 100).toStringAsFixed(0)}% utilisé',
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   color: colors.onSurface.withOpacity(0.6),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickActions(
//       BuildContext context, ThemeData theme, List<Transaction> recentTransactions) {
//     return Column(
//       children: [
//         Text(
//           'Actions rapides',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildActionButton(context, Icons.add, 'Recharger', '/topup'),
//             _buildActionButton(context, Icons.swap_horiz, 'Transférer', null,
//                 onTap: () => _showTransferBottomSheet(context)),
//             _buildActionButton(context, Icons.qr_code, 'Payer', '/qr_scanner'),
//             _buildActionButton(context, Icons.receipt, 'Factures', null, onTap: () {
//               if (recentTransactions.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                       content: Text('Aucune transaction disponible pour générer un PDF')),
//                 );
//                 return;
//               }
//               Navigator.pushNamed(
//                 context,
//                 '/transaction_detail',
//                 arguments: recentTransactions.first,
//               );
//             }),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(
//       BuildContext context, IconData icon, String label, String? route,
//       {VoidCallback? onTap}) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onTap ?? (route != null ? () => Navigator.pushNamed(context, route) : null),
//       child: Column(
//         children: [
//           Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: theme.colorScheme.primary.withOpacity(0.2),
//                 width: 1,
//               ),
//             ),
//             child: Icon(icon, color: theme.primaryColor),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: theme.textTheme.labelMedium?.copyWith(
//               color: theme.colorScheme.onSurface,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showTransferBottomSheet(BuildContext context) {
//     final theme = Theme.of(context);
//     final formKey = GlobalKey<FormState>();
//     final amountController = TextEditingController();
//     final appState = Provider.of<AppState>(context, listen: false);
//     final selectedCard = StaticData.fuelCards.firstWhere(
//       (card) => card.id == appState.selectedCardId,
//       orElse: () => StaticData.fuelCards[0],
//     );

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 16,
//             right: 16,
//             top: 16,
//           ),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Transférer',
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: amountController,
//                   decoration: InputDecoration(
//                     labelText: 'Montant (XOF)',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer un montant';
//                     }
//                     final amount = double.tryParse(value);
//                     if (amount == null || amount <= 0) {
//                       return 'Veuillez entrer un montant valide';
//                     }
//                     if (amount > selectedCard.balance) {
//                       return 'Montant supérieur au solde disponible (${selectedCard.balance.toStringAsFixed(0)} XOF)';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final amount = double.parse(amountController.text);
//                         final cardIndex = StaticData.fuelCards.indexWhere(
//                             (card) => card.id == selectedCard.id);
//                         if (cardIndex != -1) {
//                           StaticData.fuelCards[cardIndex] = FuelCard(
//                             id: selectedCard.id,
//                             cardNumber: selectedCard.cardNumber,
//                             balance: selectedCard.balance - amount,
//                             userId: selectedCard.userId,
//                           );
//                           appState.notifyListeners();
//                         }
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Transfert de $amount XOF effectué avec succès')),
//                         );
//                         Navigator.pop(context);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text('Confirmer le transfert'),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTransactionsSection(
//       BuildContext context, ThemeData theme, List<Transaction> transactions) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Dernières transactions',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pushNamed(context, '/history'),
//               child: const Text('Voir tout'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         transactions.isEmpty
//             ? _buildEmptyState(context)
//             : Column(
//                 children: [
//                   ...transactions.map((transaction) =>
//                       _buildTransactionItem(context, transaction)),
//                   const SizedBox(height: 16),
//                   OutlinedButton(
//                     onPressed: () => Navigator.pushNamed(context, '/history'),
//                     style: OutlinedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 48),
//                     ),
//                     child: const Text('Voir toutes les transactions'),
//                   ),
//                 ],
//               ),
//       ],
//     );
//   }

//   Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
//     final theme = Theme.of(context);
//     final isCredit = transaction.amount > 0;

//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//           color: theme.dividerColor.withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isCredit
//                 ? Colors.green.withOpacity(0.1)
//                 : theme.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             isCredit ? Icons.arrow_downward : Icons.arrow_upward,
//             color: isCredit ? Colors.green : theme.primaryColor,
//             size: 20,
//           ),
//         ),
//         title: Text(
//           transaction.stationName,
//           style: theme.textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         subtitle: Text(
//           transaction.date,
//           style: theme.textTheme.bodySmall,
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${transaction.amount.abs()} XOF',
//               style: theme.textTheme.bodyLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: isCredit ? Colors.green : null,
//               ),
//             ),
//             if (transaction.status != null)
//               Text(
//                 transaction.status!,
//                 style: theme.textTheme.labelSmall?.copyWith(
//                   color: transaction.status == 'Terminé'
//                       ? Colors.green
//                       : Colors.orange,
//                 ),
//               ),
//           ],
//         ),
//         onTap: () => Navigator.pushNamed(
//           context,
//           '/transaction_detail',
//           arguments: transaction,
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 40),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 48,
//             color: theme.disabledColor,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Aucune transaction récente',
//             style: theme.textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Vos transactions apparaîtront ici',
//             style: theme.textTheme.bodySmall?.copyWith(
//               color: theme.disabledColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
//     return NavigationBar(
//       selectedIndex: currentIndex,
//       onDestinationSelected: (index) {
//         if (index == 1) Navigator.pushNamed(context, '/history');
//         if (index == 2) Navigator.pushNamed(context, '/map');
//         if (index == 3) Navigator.pushNamed(context, '/profile');
//       },
//       destinations: const [
//         NavigationDestination(
//           icon: Icon(Icons.home_outlined),
//           selectedIcon: Icon(Icons.home),
//           label: 'Accueil',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.history_outlined),
//           selectedIcon: Icon(Icons.history),
//           label: 'Historique',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.map_outlined),
//           selectedIcon: Icon(Icons.map),
//           label: 'Carte',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.person_outlined),
//           selectedIcon: Icon(Icons.person),
//           label: 'Profil',
//         ),
//       ],
//     );
//   }
// }

// class QRScannerScreen extends StatefulWidget {
//   const QRScannerScreen({super.key});

//   @override
//   State<QRScannerScreen> createState() => _QRScannerScreenState();
// }

// class _QRScannerScreenState extends State<QRScannerScreen> {
//   final MobileScannerController controller = MobileScannerController();
//   bool isScanning = true;
//   bool isFlashOn = false;

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scanner QR Code'),
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             onDetect: (capture) {
//               if (isScanning) {
//                 final List<Barcode> barcodes = capture.barcodes;
//                 if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
//                   setState(() {
//                     isScanning = false;
//                   });
//                   _handleScannedData(context, barcodes.first.rawValue!);
//                 }
//               }
//             },
//             scanWindow: Rect.fromCenter(
//               center: MediaQuery.of(context).size.center(Offset.zero),
//               width: 250,
//               height: 250,
//             ),
//           ),
//           // Superposition personnalisée pour le cadre de scan
//           _buildScanOverlay(context, theme),
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     isFlashOn = !isFlashOn;
//                   });
//                   controller.toggleTorch();
//                 },
//                 child: Text(isFlashOn ? 'Désactiver Flash' : 'Activer Flash'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildScanOverlay(BuildContext context, ThemeData theme) {
//     final size = MediaQuery.of(context).size;
//     const scanWindowSize = 250.0;
//     final scanWindow = Rect.fromCenter(
//       center: size.center(Offset.zero),
//       width: scanWindowSize,
//       height: scanWindowSize,
//     );

//     return Stack(
//       children: [
//         // Superposition sombre à l'extérieur de la fenêtre de scan
//         Container(
//           color: Colors.black.withOpacity(0.5),
//         ),
//         // Fenêtre de scan transparente
//         Positioned.fromRect(
//           rect: scanWindow,
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: theme.primaryColor,
//                 width: 10,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         // Coins de la fenêtre de scan
//         _buildCorner(scanWindow.left, scanWindow.top, theme, isTopLeft: true),
//         _buildCorner(scanWindow.right, scanWindow.top, theme, isTopRight: true),
//         _buildCorner(scanWindow.left, scanWindow.bottom, theme, isBottomLeft: true),
//         _buildCorner(scanWindow.right, scanWindow.bottom, theme, isBottomRight: true),
//       ],
//     );
//   }

//   Widget _buildCorner(double x, double y, ThemeData theme,
//       {bool isTopLeft = false,
//       bool isTopRight = false,
//       bool isBottomLeft = false,
//       bool isBottomRight = false}) {
//     const cornerLength = 30.0;
//     const cornerWidth = 10.0;

//     return Positioned(
//       left: isTopRight || isBottomRight ? x - cornerWidth : x,
//       top: isBottomLeft || isBottomRight ? y - cornerWidth : y,
//       child: CustomPaint(
//         size: const Size(cornerLength, cornerLength),
//         painter: _CornerPainter(
//           color: theme.primaryColor,
//           isTopLeft: isTopLeft,
//           isTopRight: isTopRight,
//           isBottomLeft: isBottomLeft,
//           isBottomRight: isBottomRight,
//         ),
//       ),
//     );
//   }

//   void _handleScannedData(BuildContext context, String code) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Code QR scanné : $code')),
//     );
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pop(context);
//     });
//   }
// }

// class _CornerPainter extends CustomPainter {
//   final Color color;
//   final bool isTopLeft;
//   final bool isTopRight;
//   final bool isBottomLeft;
//   final bool isBottomRight;

//   _CornerPainter({
//     required this.color,
//     this.isTopLeft = false,
//     this.isTopRight = false,
//     this.isBottomLeft = false,
//     this.isBottomRight = false,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 10
//       ..style = PaintingStyle.stroke;

//     final path = Path();

//     if (isTopLeft) {
//       path.moveTo(0, size.height / 2);
//       path.lineTo(0, 0);
//       path.lineTo(size.width / 2, 0);
//     } else if (isTopRight) {
//       path.moveTo(size.width / 2, 0);
//       path.lineTo(size.width, 0);
//       path.lineTo(size.width, size.height / 2);
//     } else if (isBottomLeft) {
//       path.moveTo(0, size.height / 2);
//       path.lineTo(0, size.height);
//       path.lineTo(size.width / 2, size.height);
//     } else if (isBottomRight) {
//       path.moveTo(size.width / 2, size.height);
//       path.lineTo(size.width, size.height);
//       path.lineTo(size.width, size.height / 2);
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
import 'package:flutter/material.dart';
import 'package:fuel_card_app/data/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import '../database_helper.dart';
import '../models/fuel_card.dart';
import '../models/transaction.dart';
import '../widgets/custom_card.dart';
import '../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<FuelCard> fuelCards = [];
  List<Transaction> recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dbHelper = DatabaseHelper.instance;
    final cards = await dbHelper.getFuelCards();
    final appState = Provider.of<AppState>(context, listen: false);
    final selectedCardId = appState.selectedCardId ?? cards[0].id;

    final transactions = await dbHelper.getTransactions(selectedCardId);
    setState(() {
      fuelCards = cards;
      recentTransactions = transactions.take(3).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appState = Provider.of<AppState>(context);

    if (fuelCards.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final selectedCard = fuelCards.firstWhere(
      (card) => card.id == appState.selectedCardId,
      orElse: () => fuelCards[0],
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Badge(
              smallSize: 8,
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildCardSelector(context, appState, theme, selectedCard),
              const SizedBox(height: 24),
              _buildBalanceCard(context, theme, colors, selectedCard),
              const SizedBox(height: 24),
              _buildQuickActions(context, theme, recentTransactions),
              const SizedBox(height: 32),
              _buildTransactionsSection(context, theme, recentTransactions),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, 0),
    );
  }

  Widget _buildCardSelector(
      BuildContext context, AppState appState, ThemeData theme, FuelCard selectedCard) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: appState.selectedCardId,
          icon: const Icon(Icons.arrow_drop_down),
          style: theme.textTheme.titleMedium,
          dropdownColor: theme.cardColor,
          items: fuelCards.map((FuelCard card) {
            return DropdownMenuItem<int>(
              value: card.id,
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: theme.primaryColor, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    '•••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                    style: theme.textTheme.titleMedium,
                  ),
                  if (card.id == selectedCard.id)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Active',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) async {
            appState.setSelectedCard(value!);
            final transactions = await DatabaseHelper.instance.getTransactions(value);
            setState(() {
              recentTransactions = transactions.take(3).toList();
            });
          },
        ),
      ),
    );
  }

  Widget _buildBalanceCard(
      BuildContext context, ThemeData theme, ColorScheme colors, FuelCard card) {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SOLDE DISPONIBLE',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
              Icon(Icons.credit_card, color: theme.primaryColor),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${card.balance.toStringAsFixed(0)} XOF',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: card.balance / 100000,
            backgroundColor: colors.surfaceContainerHighest,
            color: theme.primaryColor,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limite: 100 000 XOF',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                '${(card.balance / 100000 * 100).toStringAsFixed(0)}% utilisé',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
      BuildContext context, ThemeData theme, List<Transaction> recentTransactions) {
    return Column(
      children: [
        Text(
          'Actions rapides',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(context, Icons.add, 'Recharger', '/topup'),
            _buildActionButton(context, Icons.swap_horiz, 'Transférer', null,
                onTap: () => _showTransferBottomSheet(context)),
            _buildActionButton(context, Icons.qr_code, 'Payer', '/qr_scanner'),
            _buildActionButton(context, Icons.receipt, 'Factures', null, onTap: () {
              if (recentTransactions.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Aucune transaction disponible pour générer un PDF')),
                );
                return;
              }
              Navigator.pushNamed(
                context,
                '/transaction_detail',
                arguments: recentTransactions.first,
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, String? route,
      {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap ?? (route != null ? () => Navigator.pushNamed(context, route) : null),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(icon, color: theme.primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _showTransferBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    final amountController = TextEditingController();
    final appState = Provider.of<AppState>(context, listen: false);
    final selectedCard = fuelCards.firstWhere(
      (card) => card.id == appState.selectedCardId,
      orElse: () => fuelCards[0],
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transférer',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Montant (XOF)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un montant';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Veuillez entrer un montant valide';
                    }
                    if (amount > selectedCard.balance) {
                      return 'Montant supérieur au solde disponible (${selectedCard.balance.toStringAsFixed(0)} XOF)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final amount = double.parse(amountController.text);
                        final updatedCard = FuelCard(
                          id: selectedCard.id,
                          cardNumber: selectedCard.cardNumber,
                          balance: selectedCard.balance - amount,
                          userId: selectedCard.userId,
                        );

                        await DatabaseHelper.instance.updateFuelCard(updatedCard);
                        await DatabaseHelper.instance.insertTransaction(Transaction(
                          id: 0,
                          fuelCardId: selectedCard.id,
                          stationName: 'Transfert',
                          amount: -amount,
                          date: DateTime.now().toIso8601String(),
                          status: 'Terminé', fuelType: '',
                        ));

                        await _loadData();
                        appState.notifyListeners();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Transfert de $amount XOF effectué avec succès')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Confirmer le transfert'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionsSection(
      BuildContext context, ThemeData theme, List<Transaction> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dernières transactions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/history'),
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        transactions.isEmpty
            ? _buildEmptyState(context)
            : Column(
                children: [
                  ...transactions.map((transaction) =>
                      _buildTransactionItem(context, transaction)),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Voir toutes les transactions'),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
    final theme = Theme.of(context);
    final isCredit = transaction.amount > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCredit
                ? Colors.green.withOpacity(0.1)
                : theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: isCredit ? Colors.green : theme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          transaction.stationName,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          transaction.date,
          style: theme.textTheme.bodySmall,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${transaction.amount.abs()} XOF',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCredit ? Colors.green : null,
              ),
            ),
            if (transaction.status != null)
              Text(
                transaction.status!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: transaction.status == 'Terminé'
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          '/transaction_detail',
          arguments: transaction,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: theme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune transaction récente',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Vos transactions apparaîtront ici',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index == 1) Navigator.pushNamed(context, '/history');
        if (index == 2) Navigator.pushNamed(context, '/map');
        if (index == 3) Navigator.pushNamed(context, '/profile');
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Accueil',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: 'Historique',
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: 'Carte',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outlined),
          selectedIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool isScanning = true;
  bool isFlashOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR Code'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (isScanning) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  setState(() {
                    isScanning = false;
                  });
                  _handleScannedData(context, barcodes.first.rawValue!);
                }
              }
            },
            scanWindow: Rect.fromCenter(
              center: MediaQuery.of(context).size.center(Offset.zero),
              width: 250,
              height: 250,
            ),
          ),
          _buildScanOverlay(context, theme),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                  controller.toggleTorch();
                },
                child: Text(isFlashOn ? 'Désactiver Flash' : 'Activer Flash'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanOverlay(BuildContext context, ThemeData theme) {
    final size = MediaQuery.of(context).size;
    const scanWindowSize = 250.0;
    final scanWindow = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: scanWindowSize,
      height: scanWindowSize,
    );

    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Positioned.fromRect(
          rect: scanWindow,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        _buildCorner(scanWindow.left, scanWindow.top, scanWindowSize, theme, isTopLeft: true),
        _buildCorner(scanWindow.right, scanWindow.top, scanWindowSize, theme, isRight: true),
        _buildCorner(scanWindow.left, scanWindow.bottom, scanWindowSize, theme, isBottomLeft: true),
        _buildCorner(scanWindow.right, scanWindow.bottom, scanWindowSize, theme, isBottomRight: true),
      ],
    );
  }

  Widget _buildCorner(double x, double y, double size, ThemeData theme,
      {bool isTopLeft = false, bool isRight = false, bool isBottomLeft = false, bool isBottomRight = false}) {
    const cornerLength = 20.0;
    return Positioned(
      left: isRight || isBottomRight ? x - cornerLength : x,
      top: isBottomLeft || isBottomRight ? y - cornerLength : y,
      child: Container(
        width: cornerLength,
        height: cornerLength,
        decoration: BoxDecoration(
          border: Border(
            top: isTopLeft || isRight
                ? BorderSide(color: theme.primaryColor, width: 3)
                : BorderSide.none,
            left: isTopLeft || isBottomLeft
                ? BorderSide(color: theme.primaryColor, width: 3)
                : BorderSide.none,
            right: isRight || isBottomRight
                ? BorderSide(color: theme.primaryColor, width: 3)
                : BorderSide.none,
            bottom: isBottomLeft || isBottomRight
                ? BorderSide(color: theme.primaryColor, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _handleScannedData(BuildContext context, String code) async {
    final appState = Provider.of<AppState>(context, listen: false);
    final selectedCard = (await DatabaseHelper.instance.getFuelCards())
        .firstWhere((card) => card.id == appState.selectedCardId);

    const amount = 10000.0;
    if (selectedCard.balance >= amount) {
      final updatedCard = FuelCard(
        id: selectedCard.id,
        cardNumber: selectedCard.cardNumber,
        balance: selectedCard.balance - amount,
        userId: selectedCard.userId,
      );

      await DatabaseHelper.instance.updateFuelCard(updatedCard);
      await DatabaseHelper.instance.insertTransaction(Transaction(
        id: 0,
        fuelCardId: selectedCard.id,
        stationName: 'Station QR',
        amount: -amount,
        date: DateTime.now().toIso8601String(),
        status: 'Terminé', fuelType: '',  // Assuming fuelType is a String
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paiement de $amount XOF via QR code : $code')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solde insuffisant')),
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isScanning = true;
      });
      Navigator.pop(context);
    });
  }
}