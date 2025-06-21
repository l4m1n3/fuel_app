import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/custom_card.dart';
import 'package:animate_do/animate_do.dart'; // For animations

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Transaction transaction =
        ModalRoute.of(context)!.settings.arguments as Transaction;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Détails de la transaction',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Retour',
          // semanticLabel: 'Retour à l\'écran précédent',
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: CustomCard(
                  elevation: 4,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Station Name
                      _buildDetailRow(
                        context,
                        icon: Icons.local_gas_station,
                        label: 'Station',
                        value: transaction.stationName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Amount
                      _buildDetailRow(
                        context,
                        icon: Icons.monetization_on,
                        label: 'Montant',
                        value: '${transaction.amount} XOF',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: transaction.amount > 0
                              ? Colors.green
                              : theme.colorScheme.error,
                        ),
                        semanticsLabel: 'Montant de ${transaction.amount} XOF',
                      ),
                      const SizedBox(height: 16),
                      // Date
                      _buildDetailRow(
                        context,
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: transaction.date,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      // Fuel Type
                      _buildDetailRow(
                        context,
                        icon: Icons.oil_barrel,
                        label: 'Carburant',
                        value: transaction.fuelType,
                        style: theme.textTheme.titleMedium,
                        trailing: Container(
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
                      ),
                      if (transaction.status != null) ...[
                        const SizedBox(height: 16),
                        // Status
                        _buildDetailRow(
                          context,
                          icon: Icons.info,
                          label: 'Statut',
                          value: transaction.status!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: transaction.status == 'Terminé'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      // Report Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Haptic feedback (requires `flutter_haptic` package)
                            // HapticFeedback.mediumImpact();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Problème signalé'),
                                backgroundColor: theme.colorScheme.error,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.report_problem),
                          label: const Text('Signaler un problème'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onError,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    TextStyle? style,
    Widget? trailing,
    String? semanticsLabel,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 24,
            semanticLabel: label,
          ),
        ),
        const SizedBox(width: 16),
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
                style: style ?? theme.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                semanticsLabel: semanticsLabel ?? value,
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing,
        ],
      ],
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
