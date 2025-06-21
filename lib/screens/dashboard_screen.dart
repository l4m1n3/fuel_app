// import 'package:flutter/material.dart';
// import 'package:fuel_card_app/main.dart';
// import 'package:provider/provider.dart';
// import '../data/static_data.dart';
// import '../models/fuel_card.dart';
// import '../models/transaction.dart';
// import '../widgets/custom_card.dart';
// import 'package:animate_do/animate_do.dart'; // For animations

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appState = Provider.of<AppState>(context);
//     final selectedCard = StaticData.fuelCards.firstWhere(
//       (card) => card.id == appState.selectedCardId,
//       orElse: () => StaticData.fuelCards[0],
//     );

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         title: const Text(
//           'Tableau de bord',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Semantics(
//               label: 'Notifications',
//               child: const Icon(Icons.notifications_outlined),
//             ),
//             onPressed: () {
//               // TODO: Implement notification functionality
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text('Notifications en cours de développement')),
//               );
//             },
//             tooltip: 'Notifications',
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Card Selector
//                     FadeInDown(
//                       duration: const Duration(milliseconds: 300),
//                       child:
//                           _buildCardSelector(context, appState, selectedCard),
//                     ),
//                     const SizedBox(height: 24),

//                     // Balance Card
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 300),
//                       child: _buildBalanceCard(context, selectedCard),
//                     ),
//                     const SizedBox(height: 24),

//                     // Quick Actions
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 400),
//                       child: _buildQuickActions(context),
//                     ),
//                     const SizedBox(height: 32),

//                     // Recent Transactions Header
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Dernières transactions',
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () =>
//                               Navigator.pushNamed(context, '/history'),
//                           child: Text(
//                             'Voir tout',
//                             style: theme.textTheme.labelLarge?.copyWith(
//                               color: theme.colorScheme.primary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),

//                     // Transactions List
//                     _buildTransactionsList(context, selectedCard),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(context),
//     );
//   }

//   Widget _buildCardSelector(
//       BuildContext context, AppState appState, FuelCard selectedCard) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainer,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<int>(
//           isExpanded: true,
//           value: appState.selectedCardId,
//           icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
//           items: StaticData.fuelCards.map((FuelCard card) {
//             return DropdownMenuItem<int>(
//               value: card.id,
//               child: Text(
//                 'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (value) {
//             appState.setSelectedCard(value!);
//             // Haptic feedback for better UX
//             // Note: Add `HapticFeedback.vibrate()` if `flutter_haptic` is included
//           },
//           dropdownColor: theme.colorScheme.surfaceContainerHigh,
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//     );
//   }

//   Widget _buildBalanceCard(BuildContext context, FuelCard selectedCard) {
//     final theme = Theme.of(context);
//     return CustomCard(
//       padding: const EdgeInsets.all(20),
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'SOLDE DISPONIBLE',
//                 style: theme.textTheme.labelLarge?.copyWith(
//                   color: theme.colorScheme.onSurfaceVariant,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               Icon(
//                 Icons.credit_card,
//                 color: theme.colorScheme.primary,
//                 semanticLabel: 'Icône de carte',
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             '${selectedCard.balance.toStringAsFixed(0)} XOF',
//             style: theme.textTheme.displaySmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.colorScheme.primary,
//             ),
//             semanticsLabel:
//                 'Solde de ${selectedCard.balance.toStringAsFixed(0)} XOF',
//           ),
//           const SizedBox(height: 16),
//           LinearProgressIndicator(
//             value: selectedCard.balance / 100000, // Adjust based on max balance
//             backgroundColor: theme.colorScheme.surfaceContainerHighest,
//             color: theme.colorScheme.primary,
//             borderRadius: BorderRadius.circular(4),
//             minHeight: 8,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickActions(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildActionButton(context, Icons.add, 'Recharger', () {
//           // TODO: Implement recharge functionality
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Recharge en cours de développement')),
//           );
//         }),
//         _buildActionButton(context, Icons.swap_horiz, 'Transférer', () {
//           // TODO: Implement transfer functionality
//         }),
//         _buildActionButton(context, Icons.qr_code, 'Payer', () {
//           // TODO: Implement payment functionality
//         }),
//         _buildActionButton(context, Icons.receipt, 'Factures', () {
//           // TODO: Implement invoices functionality
//         }),
//       ],
//     );
//   }

//   Widget _buildActionButton(
//       BuildContext context, IconData icon, String label, VoidCallback onTap) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             width: 64,
//             height: 64,
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primaryContainer,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: theme.colorScheme.shadow.withOpacity(0.1),
//                   blurRadius: 6,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Icon(icon, color: theme.colorScheme.primary, size: 28),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: theme.textTheme.labelMedium?.copyWith(
//               fontWeight: FontWeight.w500,
//               color: theme.colorScheme.onSurface,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTransactionsList(BuildContext context, FuelCard selectedCard) {
//     final recentTransactions = StaticData.transactions
//         .where((t) => t.fuelCardId == selectedCard.id)
//         .take(3)
//         .toList();

//     if (recentTransactions.isEmpty) {
//       return _buildEmptyState(context);
//     }

//     return SizedBox(
//       height: 200, // Fixed height for transactions list
//       child: ListView.builder(
//         itemCount: recentTransactions.length,
//         itemBuilder: (context, index) {
//           final transaction = recentTransactions[index];
//           return FadeInUp(
//             duration: Duration(milliseconds: 300 + (index * 100)),
//             child: _buildTransactionItem(context, transaction),
//           );
//         },
//         physics: const BouncingScrollPhysics(),
//       ),
//     );
//   }

//   Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
//     final theme = Theme.of(context);
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(vertical: 4),
//       leading: Container(
//         width: 48,
//         height: 48,
//         decoration: BoxDecoration(
//           color: theme.colorScheme.primaryContainer,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(
//           transaction.amount > 0 ? Icons.arrow_downward : Icons.arrow_upward,
//           color:
//               transaction.amount > 0 ? Colors.green : theme.colorScheme.primary,
//           semanticLabel: transaction.amount > 0
//               ? 'Transaction entrante'
//               : 'Transaction sortante',
//         ),
//       ),
//       title: Text(
//         transaction.stationName,
//         style: theme.textTheme.bodyLarge?.copyWith(
//           fontWeight: FontWeight.w600,
//         ),
//         overflow: TextOverflow.ellipsis,
//       ),
//       subtitle: Text(
//         transaction.date,
//         style: theme.textTheme.bodySmall?.copyWith(
//           color: theme.colorScheme.onSurfaceVariant,
//         ),
//       ),
//       trailing: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             '${transaction.amount} XOF',
//             style: theme.textTheme.bodyLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: transaction.amount > 0
//                   ? Colors.green
//                   : theme.colorScheme.error,
//             ),
//           ),
//           if (transaction.status != null)
//             Text(
//               transaction.status!,
//               style: theme.textTheme.bodySmall?.copyWith(
//                 color: transaction.status == 'Terminé'
//                     ? Colors.green
//                     : Colors.orange,
//               ),
//             ),
//         ],
//       ),
//       onTap: () => Navigator.pushNamed(
//         context,
//         '/transaction_detail',
//         arguments: transaction,
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final theme = Theme.of(context);
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 64,
//             color: theme.colorScheme.onSurfaceVariant,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Aucune transaction récente',
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Vos transactions apparaîtront ici',
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onSurfaceVariant,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavBar(BuildContext context) {
//     return NavigationBar(
//       selectedIndex: 0,
//       onDestinationSelected: (index) {
//         if (index == 1) Navigator.pushNamed(context, '/history');
//         if (index == 2) Navigator.pushNamed(context, '/map');
//         if (index == 3) Navigator.pushNamed(context, '/profile');
//       },
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       elevation: 8,
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
import 'package:flutter/material.dart';
import 'package:fuel_card_app/main.dart';
import 'package:provider/provider.dart';
import '../data/static_data.dart';
import '../models/fuel_card.dart';
import '../models/transaction.dart';
import '../widgets/custom_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appState = Provider.of<AppState>(context);

    final selectedCard = StaticData.fuelCards.firstWhere(
      (card) => card.id == appState.selectedCardId,
      orElse: () => StaticData.fuelCards[0],
    );

    final recentTransactions = StaticData.transactions
        .where((t) => t.fuelCardId == selectedCard.id)
        .take(3)
        .toList();

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
        onRefresh: () async {
          // Simuler un rafraîchissement des données
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Sélecteur de carte amélioré
              _buildCardSelector(context, appState, theme, selectedCard),
              const SizedBox(height: 24),

              // Carte de solde
              _buildBalanceCard(context, theme, colors, selectedCard),
              const SizedBox(height: 24),

              // Actions rapides
              _buildQuickActions(context, theme),
              const SizedBox(height: 32),

              // Section transactions
              _buildTransactionsSection(context, theme, recentTransactions),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, 0),
    );
  }

  Widget _buildCardSelector(BuildContext context, AppState appState,
      ThemeData theme, FuelCard selectedCard) {
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
          items: StaticData.fuelCards.map((FuelCard card) {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
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
          onChanged: (value) => appState.setSelectedCard(value!),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, ThemeData theme,
      ColorScheme colors, FuelCard card) {
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
            value: card.balance / 100000, // Ajustez selon votre logique
            backgroundColor: colors.surfaceVariant,
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

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
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
            _buildActionButton(
                context, Icons.swap_horiz, 'Transférer', '/transfer'),
            _buildActionButton(context, Icons.qr_code, 'Payer', '/pay'),
            _buildActionButton(context, Icons.receipt, 'Factures', '/invoices'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, String route) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
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
              style: TextButton.styleFrom(
                
              ),
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
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
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
