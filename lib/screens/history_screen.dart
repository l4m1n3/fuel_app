import 'package:flutter/material.dart';
import 'package:fuel_card_app/main.dart';
import 'package:provider/provider.dart';
import '../data/static_data.dart';
import '../models/transaction.dart';
import '../widgets/custom_card.dart';
import 'package:animate_do/animate_do.dart'; // For animations

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedFilter = 'all';
  String selectedFuelType = 'all';

  List<Transaction> getFilteredTransactions(int selectedCardId) {
    var transactions = StaticData.transactions
        .where((t) => t.fuelCardId == selectedCardId)
        .toList();

    if (selectedFilter == 'month') {
      transactions =
          transactions.where((t) => t.date.contains('05/2025')).toList();
    } else if (selectedFilter == 'quarter') {
      transactions =
          transactions.where((t) => t.date.contains('2025')).toList();
    }

    if (selectedFuelType != 'all') {
      transactions =
          transactions.where((t) => t.fuelType == selectedFuelType).toList();
    }

    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = Provider.of<AppState>(context);
    final transactions = getFilteredTransactions(appState.selectedCardId);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Historique des pleins',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Semantics(
              label: 'Filtrer les transactions',
              child: const Icon(Icons.filter_alt_outlined),
            ),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrer',
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Summary Header
                FadeInDown(
                  duration: const Duration(milliseconds: 300),
                  child: _buildSummaryHeader(context, transactions),
                ),
                // Transactions List
                Expanded(
                  child: transactions.isEmpty
                      ? _buildEmptyState(context)
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return FadeInUp(
                              duration:
                                  Duration(milliseconds: 300 + (index * 100)),
                              child:
                                  _buildTransactionCard(context, transaction),
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                        ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildSummaryHeader(
      BuildContext context, List<Transaction> transactions) {
    final theme = Theme.of(context);
    final total = transactions.fold(0.0, (sum, t) => sum + t.amount);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${transactions.length} pleins',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                semanticsLabel: '${transactions.length} transactions',
              ),
              const SizedBox(height: 4),
              Text(
                'Filtre: ${_getFilterLabel(selectedFilter)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)} XOF',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                semanticsLabel: 'Total de ${total.toStringAsFixed(0)} XOF',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(BuildContext context, Transaction transaction) {
    final theme = Theme.of(context);
    final isRefill = transaction.amount > 0;

    return CustomCard(
      padding: const EdgeInsets.all(0),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(
          context,
          '/transaction_detail',
          arguments: transaction,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isRefill
                      ? Colors.green.withOpacity(0.1)
                      : theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isRefill ? Icons.local_gas_station : Icons.credit_card,
                  color: isRefill ? Colors.green : theme.colorScheme.error,
                  size: 24,
                  semanticLabel: isRefill ? 'Recharge' : 'Paiement',
                ),
              ),
              const SizedBox(width: 16),
              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.stationName,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          transaction.date,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getFuelTypeColor(transaction.fuelType),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            transaction.fuelType,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Amount and Chevron
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transaction.amount} XOF',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isRefill ? Colors.green : theme.colorScheme.error,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun historique trouvé',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos pleins apparaîtront ici',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() {
              selectedFilter = 'all';
              selectedFuelType = 'all';
            }),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Réinitialiser les filtres'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      selectedIndex: 1,
      onDestinationSelected: (index) {
        if (index == 0) Navigator.pushNamed(context, '/dashboard');
        if (index == 2) Navigator.pushNamed(context, '/map');
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

  void _showFilterDialog(BuildContext context) {
    String tempFilter = selectedFilter;
    String tempFuelType = selectedFuelType;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filtrer l\'historique'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterSection(
                      context,
                      'Période',
                      tempFilter,
                      ['all', 'month', 'quarter'],
                      (value) => setDialogState(() => tempFilter = value),
                    ),
                    const Divider(),
                    _buildFilterSection(
                      context,
                      'Type de carburant',
                      tempFuelType,
                      ['all', 'Essence', 'Diesel'],
                      (value) => setDialogState(() => tempFuelType = value),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Annuler',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = tempFilter;
                      selectedFuelType = tempFuelType;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Appliquer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    String selectedValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...options.map((value) {
          return RadioListTile<String>(
            title: Text(
              _getFilterLabel(value),
              style: theme.textTheme.bodyMedium,
            ),
            value: value,
            groupValue: selectedValue,
            onChanged: (value) {
              onChanged(value!);
              // Haptic feedback (add `flutter_haptic` package if desired)
              // HapticFeedback.lightImpact();
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            dense: true,
            activeColor: theme.colorScheme.primary,
          );
        }),
      ],
    );
  }

  String _getFilterLabel(String value) {
    switch (value) {
      case 'all':
        return 'Toutes périodes';
      case 'month':
        return 'Dernier mois';
      case 'quarter':
        return 'Dernier trimestre';
      case 'Essence':
        return 'Essence';
      case 'Diesel':
        return 'Diesel';
      default:
        return value;
    }
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
