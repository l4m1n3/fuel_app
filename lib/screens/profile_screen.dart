// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';
// import '../data/static_data.dart';
// import '../widgets/custom_card.dart';
// import 'package:animate_do/animate_do.dart'; // For animations

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

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
      
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200,
//               pinned: true,
//               // leading: IconButton(
//               //   icon: const Icon(Icons.arrow_back),
//               //   onPressed: () => Navigator.pop(context),
//               //   tooltip: 'Retour',
//               //   // semanticLabel: 'Retour à l\'écran précédent',
//               // ),
//               actions: [
//                 IconButton(
//                   icon: Semantics(
//                     label: 'Notifications',
//                     child: const Icon(Icons.notifications_outlined),
//                   ),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text('Notifications en cours de développement'),
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     );
//                   },
//                   tooltip: 'Notifications',
//                 ),
//               ],
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         theme.colorScheme.primary,
//                         theme.colorScheme.primaryContainer,
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 48,
//                           backgroundColor: theme.colorScheme.surface,
//                           child: Text(
//                             appState.userName.isNotEmpty
//                                 ? appState.userName[0].toUpperCase()
//                                 : 'U',
//                             style: theme.textTheme.headlineMedium?.copyWith(
//                               color: theme.colorScheme.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           appState.userName.isNotEmpty
//                               ? appState.userName
//                               : 'Utilisateur',
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             color: theme.colorScheme.onPrimary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           semanticsLabel: 'Nom d\'utilisateur',
//                         ),
//                         Text(
//                           appState.email.isNotEmpty
//                               ? appState.email
//                               : 'Aucun email',
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: theme.colorScheme.onPrimary.withOpacity(0.7),
//                           ),
//                           semanticsLabel: 'Email',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               backgroundColor: theme.colorScheme.primary,
//               elevation: 0,
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Profile Details
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 300),
//                       child: CustomCard(
//                         elevation: 4,
//                         padding: const EdgeInsets.all(0),
//                         child: Column(
//                           children: [
//                             _buildProfileItem(
//                               context,
//                               icon: Icons.person,
//                               label: 'Nom',
//                               value: appState.userName.isNotEmpty
//                                   ? appState.userName
//                                   : 'Non défini',
//                             ),
//                             const Divider(height: 1),
//                             _buildProfileItem(
//                               context,
//                               icon: Icons.email,
//                               label: 'Email',
//                               value: appState.email.isNotEmpty
//                                   ? appState.email
//                                   : 'Non défini',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     // Cards Section
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 400),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Mes Cartes',
//                             style: theme.textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           ...StaticData.fuelCards.map((card) => FadeInUp(
//                                 duration: const Duration(milliseconds: 500),
//                                 child: CustomCard(
//                                   elevation: 2,
//                                   padding: const EdgeInsets.all(0),
//                                   child: ListTile(
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 8),
//                                     leading: Icon(
//                                       Icons.credit_card,
//                                       color: theme.colorScheme.primary,
//                                       semanticLabel: 'Carte de carburant',
//                                     ),
//                                     title: Text(
//                                       'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
//                                       style:
//                                           theme.textTheme.titleMedium?.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     subtitle: Text(
//                                       'Solde: ${card.balance.toStringAsFixed(0)} XOF',
//                                       style: theme.textTheme.bodyMedium?.copyWith(
//                                         color:
//                                             theme.colorScheme.onSurfaceVariant,
//                                       ),
//                                     ),
//                                     trailing: card.id == appState.selectedCardId
//                                         ? Icon(
//                                             Icons.check_circle,
//                                             color: Colors.green,
//                                             semanticLabel: 'Carte sélectionnée',
//                                           )
//                                         : null,
//                                     onTap: () {
//                                       // Haptic feedback (requires `flutter_haptic` package)
//                                       // HapticFeedback.lightImpact();
//                                       appState.setSelectedCard(card.id);
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                           content: Text(
//                                               'Carte •••• ${card.cardNumber.substring(card.cardNumber.length - 4)} sélectionnée'),
//                                           behavior: SnackBarBehavior.floating,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     // Actions
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 600),
//                       child: Column(
//                         children: [
//                           CustomCard(
//                             elevation: 2,
//                             padding: const EdgeInsets.all(0),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               leading: Icon(
//                                 Icons.edit,
//                                 color: theme.colorScheme.primary,
//                                 semanticLabel: 'Modifier le profil',
//                               ),
//                               title: Text(
//                                 'Modifier le profil',
//                                 style: theme.textTheme.titleMedium,
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.amber.shade700,
//                                 semanticLabel: 'Aller à la modification',
//                               ),
//                               onTap: () {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: const Text(
//                                         'Fonctionnalité de modification en cours de développement'),
//                                     behavior: SnackBarBehavior.floating,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           CustomCard(
//                             elevation: 2,
//                             padding: const EdgeInsets.all(0),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               leading: Icon(
//                                 Icons.logout,
//                                 color: theme.colorScheme.error,
//                                 semanticLabel: 'Se déconnecter',
//                               ),
//                               title: Text(
//                                 'Se déconnecter',
//                                 style: theme.textTheme.titleMedium,
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.amber.shade700,
//                                 semanticLabel: 'Confirmer la déconnexion',
//                               ),
//                               onTap: () {
//                                 // Haptic feedback (requires `flutter_haptic` package)
//                                 // HapticFeedback.mediumImpact();
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     title: const Text('Déconnexion'),
//                                     content: const Text(
//                                         'Voulez-vous vraiment vous déconnecter ?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(context),
//                                         child: Text(
//                                           'Annuler',
//                                           style: TextStyle(
//                                               color: theme
//                                                   .colorScheme.onSurface),
//                                         ),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           Navigator.pushNamedAndRemoveUntil(
//                                             context,
//                                             '/login',
//                                             (route) => false,
//                                           );
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               theme.colorScheme.error,
//                                           foregroundColor:
//                                               theme.colorScheme.onError,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                         ),
//                                         child: const Text('Confirmer'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(context),
//     );
//   }

//   Widget _buildProfileItem(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       leading: Icon(
//         icon,
//         color: theme.colorScheme.primary,
//         semanticLabel: label,
//       ),
//       title: Text(
//         label,
//         style: theme.textTheme.labelLarge?.copyWith(
//           color: theme.colorScheme.onSurfaceVariant,
//         ),
//       ),
//       subtitle: Text(
//         value,
//         style: theme.textTheme.titleMedium?.copyWith(
//           fontWeight: FontWeight.w600,
//         ),
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   }

//   Widget _buildBottomNavBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return NavigationBar(
//       selectedIndex: 3,
//       onDestinationSelected: (index) {
//         if (index == 0) Navigator.pushNamed(context, '/dashboard');
//         if (index == 1) Navigator.pushNamed(context, '/history');
//         if (index == 2) Navigator.pushNamed(context, '/map');
//       },
//       backgroundColor: theme.colorScheme.surface,
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
import 'package:fuel_card_app/data/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
// import '../database_helper.dart';
import '../main.dart';
import '../models/fuel_card.dart';
import '../widgets/custom_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<FuelCard> fuelCards = [];

  @override
  void initState() {
    super.initState();
    _loadFuelCards();
  }

  Future<void> _loadFuelCards() async {
    final dbHelper = DatabaseHelper.instance;
    final cards = await dbHelper.getFuelCards();
    setState(() {
      fuelCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = Provider.of<AppState>(context);
    final selectedCard = fuelCards.isNotEmpty
        ? fuelCards.firstWhere(
            (card) => card.id == appState.selectedCardId,
            orElse: () => fuelCards[0],
          )
        : null;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              pinned: true,
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
                          appState.userEmail.isNotEmpty
                              ? appState.userEmail
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
                              value: appState.userEmail.isNotEmpty
                                  ? appState.userEmail
                                  : 'Non défini',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                          if (fuelCards.isEmpty)
                            _buildEmptyCardsState(context)
                          else
                            ...fuelCards.map((card) => FadeInUp(
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
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        'Solde: ${card.balance.toStringAsFixed(0)} XOF',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color:
                                              theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      trailing: card.id == appState.selectedCardId
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              semanticLabel:
                                                  'Carte sélectionnée',
                                            )
                                          : null,
                                      onTap: () {
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
                                Navigator.pushNamed(context, '/edit_profile');
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

  Widget _buildEmptyCardsState(BuildContext context) {
    final theme = Theme.of(context);
    return CustomCard(
      elevation: 2,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.credit_card_off_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'Aucune carte trouvée',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Ajoutez une carte pour commencer',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: 3,
      onDestinationSelected: (index) {
        if (index == 0) Navigator.pushNamed(context, '/');
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