// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';
// import '../data/static_data.dart';
// import '../models/fuel_card.dart';
// import '../widgets/custom_card.dart';

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appState = Provider.of<AppState>(context);
//     final selectedCard = StaticData.fuelCards.firstWhere(
//       (card) => card.id == appState.selectedCardId,
//       orElse: () => StaticData.fuelCards[0],
//     );

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             automaticallyImplyLeading: false, // ⬅️ Supprime la flèche retour
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text('', style: TextStyle(color: Colors.white)),
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF1E3A8A), Color(0xFF4B5EAA)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.white,
//                         child: Text(
//                           appState.userName.isNotEmpty
//                               ? appState.userName[0].toUpperCase()
//                               : '',
//                           style:
//                               TextStyle(fontSize: 32, color: Color(0xFF1E3A8A)),
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         appState.userName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         appState.email,
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             backgroundColor: Color(0xFF1E3A8A),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Profile Details
//                   CustomCard(
//                     child: Column(
//                       children: [
//                         _buildProfileItem(
//                           context,
//                           Icons.person,
//                           'Nom',
//                           appState.userName,
//                           theme,
//                         ),
//                         Divider(height: 1),
//                         _buildProfileItem(
//                           context,
//                           Icons.email,
//                           'Email',
//                           appState.email,
//                           theme,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Cards Section
//                   Text(
//                     'Mes Cartes',
//                     style: theme.textTheme.titleMedium
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   ...StaticData.fuelCards.map((card) => AnimatedOpacity(
//                         opacity: 1.0,
//                         duration: Duration(milliseconds: 500),
//                         child: CustomCard(
//                           child: ListTile(
//                             leading: Icon(Icons.credit_card,
//                                 color: theme.primaryColor),
//                             title: Text(
//                               'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
//                               style: theme.textTheme.bodyLarge
//                                   ?.copyWith(fontWeight: FontWeight.w500),
//                             ),
//                             subtitle: Text(
//                               'Solde: ${card.balance.toStringAsFixed(0)} XOF',
//                               style: theme.textTheme.bodySmall,
//                             ),
//                             trailing: card.id == appState.selectedCardId
//                                 ? Icon(Icons.check_circle, color: Colors.green)
//                                 : null,
//                             onTap: () {
//                               appState.setSelectedCard(card.id);
//                             },
//                           ),
//                         ),
//                       )),
//                   SizedBox(height: 16),
//                   // Actions
//                   CustomCard(
//                     child: ListTile(
//                       leading: Icon(Icons.edit, color: theme.primaryColor),
//                       title: Text('Modifier le profil',
//                           style: theme.textTheme.bodyLarge),
//                       trailing:
//                           Icon(Icons.arrow_forward, color: Color(0xFFF59E0B)),
//                       onTap: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content: Text(
//                                   'Fonctionnalité de modification non implémentée')),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   CustomCard(
//                     child: ListTile(
//                       leading: Icon(Icons.logout, color: Color(0xFFDC2626)),
//                       title: Text('Se déconnecter',
//                           style: theme.textTheme.bodyLarge),
//                       trailing:
//                           Icon(Icons.arrow_forward, color: Color(0xFFF59E0B)),
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Déconnexion'),
//                             content:
//                                 Text('Voulez-vous vraiment vous déconnecter ?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text('Annuler'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pushNamedAndRemoveUntil(
//                                     context,
//                                     '/login',
//                                     (route) => false,
//                                   );
//                                 },
//                                 child: Text('Confirmer',
//                                     style: TextStyle(color: Color(0xFFDC2626))),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: 3,
//         onDestinationSelected: (index) {
//           if (index == 0) Navigator.pushNamed(context, '/dashboard');
//           if (index == 1) Navigator.pushNamed(context, '/history');
//           if (index == 2) Navigator.pushNamed(context, '/map');
//         },
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.home_outlined),
//             selectedIcon: Icon(Icons.home),
//             label: 'Accueil',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.history_outlined),
//             selectedIcon: Icon(Icons.history),
//             label: 'Historique',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.map_outlined),
//             selectedIcon: Icon(Icons.map),
//             label: 'Carte',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.person_outlined),
//             selectedIcon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileItem(
//     BuildContext context,
//     IconData icon,
//     String label,
//     String value,
//     ThemeData theme,
//   ) {
//     return AnimatedOpacity(
//       opacity: 1.0,
//       duration: Duration(milliseconds: 500),
//       child: ListTile(
//         leading: Icon(icon, color: theme.primaryColor, semanticLabel: label),
//         title: Text(label,
//             style:
//                 theme.textTheme.labelMedium?.copyWith(color: Colors.grey[600])),
//         subtitle: Text(value,
//             style: theme.textTheme.bodyLarge
//                 ?.copyWith(fontWeight: FontWeight.w600)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../data/static_data.dart';
import '../models/fuel_card.dart';
import '../widgets/custom_card.dart';
import 'package:animate_do/animate_do.dart'; // For animations

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = Provider.of<AppState>(context);
    final selectedCard = StaticData.fuelCards.firstWhere(
      (card) => card.id == appState.selectedCardId,
      orElse: () => StaticData.fuelCards[0],
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   onPressed: () => Navigator.pop(context),
              //   tooltip: 'Retour',
              //   // semanticLabel: 'Retour à l\'écran précédent',
              // ),
              actions: [
                IconButton(
                  icon: Semantics(
                    label: 'Notifications',
                    child: const Icon(Icons.notifications_outlined),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Notifications en cours de développement'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  tooltip: 'Notifications',
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: theme.colorScheme.surface,
                          child: Text(
                            appState.userName.isNotEmpty
                                ? appState.userName[0].toUpperCase()
                                : 'U',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          appState.userName.isNotEmpty
                              ? appState.userName
                              : 'Utilisateur',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          semanticsLabel: 'Nom d\'utilisateur',
                        ),
                        Text(
                          appState.email.isNotEmpty
                              ? appState.email
                              : 'Aucun email',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary.withOpacity(0.7),
                          ),
                          semanticsLabel: 'Email',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: theme.colorScheme.primary,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Details
                    FadeInUp(
                      duration: const Duration(milliseconds: 300),
                      child: CustomCard(
                        elevation: 4,
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            _buildProfileItem(
                              context,
                              icon: Icons.person,
                              label: 'Nom',
                              value: appState.userName.isNotEmpty
                                  ? appState.userName
                                  : 'Non défini',
                            ),
                            const Divider(height: 1),
                            _buildProfileItem(
                              context,
                              icon: Icons.email,
                              label: 'Email',
                              value: appState.email.isNotEmpty
                                  ? appState.email
                                  : 'Non défini',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Cards Section
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mes Cartes',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...StaticData.fuelCards.map((card) => FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                child: CustomCard(
                                  elevation: 2,
                                  padding: const EdgeInsets.all(0),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    leading: Icon(
                                      Icons.credit_card,
                                      color: theme.colorScheme.primary,
                                      semanticLabel: 'Carte de carburant',
                                    ),
                                    title: Text(
                                      'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      'Solde: ${card.balance.toStringAsFixed(0)} XOF',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    trailing: card.id == appState.selectedCardId
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            semanticLabel: 'Carte sélectionnée',
                                          )
                                        : null,
                                    onTap: () {
                                      // Haptic feedback (requires `flutter_haptic` package)
                                      // HapticFeedback.lightImpact();
                                      appState.setSelectedCard(card.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)} sélectionnée'),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Actions
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          CustomCard(
                            elevation: 2,
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              leading: Icon(
                                Icons.edit,
                                color: theme.colorScheme.primary,
                                semanticLabel: 'Modifier le profil',
                              ),
                              title: Text(
                                'Modifier le profil',
                                style: theme.textTheme.titleMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: Colors.amber.shade700,
                                semanticLabel: 'Aller à la modification',
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Fonctionnalité de modification en cours de développement'),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomCard(
                            elevation: 2,
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              leading: Icon(
                                Icons.logout,
                                color: theme.colorScheme.error,
                                semanticLabel: 'Se déconnecter',
                              ),
                              title: Text(
                                'Se déconnecter',
                                style: theme.textTheme.titleMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: Colors.amber.shade700,
                                semanticLabel: 'Confirmer la déconnexion',
                              ),
                              onTap: () {
                                // Haptic feedback (requires `flutter_haptic` package)
                                // HapticFeedback.mediumImpact();
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: const Text('Déconnexion'),
                                    content: const Text(
                                        'Voulez-vous vraiment vous déconnecter ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text(
                                          'Annuler',
                                          style: TextStyle(
                                              color: theme
                                                  .colorScheme.onSurface),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (route) => false,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              theme.colorScheme.error,
                                          foregroundColor:
                                              theme.colorScheme.onError,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Text('Confirmer'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
        semanticLabel: label,
      ),
      title: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      subtitle: Text(
        value,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: 3,
      onDestinationSelected: (index) {
        if (index == 0) Navigator.pushNamed(context, '/dashboard');
        if (index == 1) Navigator.pushNamed(context, '/history');
        if (index == 2) Navigator.pushNamed(context, '/map');
      },
      backgroundColor: theme.colorScheme.surface,
      elevation: 8,
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