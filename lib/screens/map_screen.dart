// import 'package:flutter/material.dart';
// import '../data/static_data.dart';
// import '../models/station.dart';
// import '../widgets/custom_card.dart';
// import 'package:animate_do/animate_do.dart'; // For animations

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//          automaticallyImplyLeading: false, // ⬅️ Supprime la flèche retour
//         title: const Text(
//           'Stations Services',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back),
//         //   onPressed: () => Navigator.pop(context),
//         //   tooltip: 'Retour',
//         //   // semanticLabel: 'Retour à l\'écran précédent',
//         // ),
//         actions: [
//           IconButton(
//             icon: Semantics(
//               label: 'Notifications',
//               child: const Icon(Icons.notifications_outlined),
//             ),
//             onPressed: () {
//               // TODO: Implement notification functionality
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content:
//                       const Text('Notifications en cours de développement'),
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               );
//             },
//             tooltip: 'Notifications',
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               itemCount: StaticData.stations.length,
//               itemBuilder: (context, index) {
//                 final Station station = StaticData.stations[index];
//                 return FadeInUp(
//                   duration: Duration(milliseconds: 300 + (index * 100)),
//                   child: _buildStationCard(context, station),
//                 );
//               },
//               physics: const BouncingScrollPhysics(),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(context),
//     );
//   }

//   Widget _buildStationCard(BuildContext context, Station station) {
//     final theme = Theme.of(context);
//     return CustomCard(
//       elevation: 2,
//       padding: const EdgeInsets.all(0),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {
//           // Haptic feedback (requires `flutter_haptic` package)
//           // HapticFeedback.lightImpact();
//           _showStationDialog(context, station);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Station Icon
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primaryContainer,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.local_gas_station,
//                   color: theme.colorScheme.primary,
//                   size: 24,
//                   semanticLabel: 'Station service',
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Station Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       station.name,
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       semanticsLabel: station.name,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       station.address,
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: theme.colorScheme.onSurfaceVariant,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Wrap(
//                       spacing: 8,
//                       children: station.fuelTypes.map((fuel) {
//                         return Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: _getFuelTypeColor(fuel),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             fuel,
//                             style: theme.textTheme.labelSmall?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               // Location Icon
//               Icon(
//                 Icons.location_on,
//                 color: Colors.amber.shade700,
//                 size: 24,
//                 semanticLabel: 'Emplacement',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showStationDialog(BuildContext context, Station station) {
//     final theme = Theme.of(context);
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Text(
//             station.name,
//             style: theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDialogRow(
//                   context,
//                   icon: Icons.location_on,
//                   label: 'Adresse',
//                   value: station.address,
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDialogRow(
//                   context,
//                   icon: Icons.map,
//                   label: 'Coordonnées',
//                   value: '(${station.latitude}, ${station.longitude})',
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDialogRow(
//                   context,
//                   icon: Icons.oil_barrel,
//                   label: 'Carburants',
//                   value: station.fuelTypes.join(', '),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 'Fermer',
//                 style: TextStyle(color: theme.colorScheme.onSurface),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // TODO: Implement navigation to external map
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: const Text(
//                         'Navigation vers la station en cours de développement'),
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 );
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Naviguer'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDialogRow(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           icon,
//           color: theme.colorScheme.primary,
//           size: 20,
//           semanticLabel: label,
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: theme.textTheme.labelLarge?.copyWith(
//                   color: theme.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: theme.textTheme.bodyMedium,
//                 overflow: TextOverflow.clip,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBottomNavBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return NavigationBar(
//       selectedIndex: 2,
//       onDestinationSelected: (index) {
//         if (index == 0) Navigator.pushNamed(context, '/dashboard');
//         if (index == 1) Navigator.pushNamed(context, '/history');
//         if (index == 3) Navigator.pushNamed(context, '/profile');
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

//   Color _getFuelTypeColor(String type) {
//     switch (type) {
//       case 'Essence':
//         return Colors.orange.shade600;
//       case 'Diesel':
//         return Colors.blue.shade600;
//       default:
//         return Colors.grey.shade600;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fuel_card_app/data/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../database_helper.dart';
import '../models/station.dart';
import '../widgets/custom_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    final dbHelper = DatabaseHelper.instance;
    final loadedStations = await dbHelper.getStations();
    setState(() {
      stations = loadedStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Stations Services',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
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
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (stations.isEmpty) {
              return _buildEmptyState(context);
            }
            return RefreshIndicator(
              onRefresh: _loadStations,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: stations.length,
                itemBuilder: (context, index) {
                  final Station station = stations[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: _buildStationCard(context, station),
                  );
                },
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildStationCard(BuildContext context, Station station) {
    final theme = Theme.of(context);
    return CustomCard(
      elevation: 2,
      padding: const EdgeInsets.all(0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _showStationDialog(context, station);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_gas_station,
                  color: theme.colorScheme.primary,
                  size: 24,
                  semanticLabel: 'Station service',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      semanticsLabel: station.name,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      station.address,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: station.fuelTypes.map((fuel) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getFuelTypeColor(fuel),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            fuel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.amber.shade700,
                size: 24,
                semanticLabel: 'Emplacement',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStationDialog(BuildContext context, Station station) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            station.name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogRow(
                  context,
                  icon: Icons.location_on,
                  label: 'Adresse',
                  value: station.address,
                ),
                const SizedBox(height: 12),
                _buildDialogRow(
                  context,
                  icon: Icons.map,
                  label: 'Coordonnées',
                  value: '(${station.latitude}, ${station.longitude})',
                ),
                const SizedBox(height: 12),
                _buildDialogRow(
                  context,
                  icon: Icons.oil_barrel,
                  label: 'Carburants',
                  value: station.fuelTypes.join(', '),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Fermer',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            ElevatedButton(
              onPressed: () => _launchNavigation(context, station.latitude, station.longitude),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Naviguer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchNavigation(BuildContext context, double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
        Navigator.pop(context); // Ferme la boîte de dialogue après lancement
      } else {
        throw 'Impossible d\'ouvrir l\'application de navigation';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $e'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildDialogRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 20,
          semanticLabel: label,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: 2,
      onDestinationSelected: (index) {
        if (index == 0) Navigator.pushNamed(context, '/');
        if (index == 1) Navigator.pushNamed(context, '/history');
        if (index == 3) Navigator.pushNamed(context, '/profile');
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

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_gas_station_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune station trouvée',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Les stations disponibles apparaîtront ici',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Color _getFuelTypeColor(String type) {
    switch (type) {
      case 'Essence':
        return Colors.orange.shade600;
      case 'Diesel':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}