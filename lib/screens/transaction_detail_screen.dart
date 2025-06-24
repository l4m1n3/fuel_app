// import 'package:flutter/material.dart';
// import '../models/transaction.dart';
// import '../widgets/custom_card.dart';
// import 'package:animate_do/animate_do.dart'; // For animations

// class TransactionDetailScreen extends StatelessWidget {
//   const TransactionDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final Transaction transaction =
//         ModalRoute.of(context)!.settings.arguments as Transaction;

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         title: const Text(
//           'Détails de la transaction',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//           tooltip: 'Retour',
//           // semanticLabel: 'Retour à l\'écran précédent',
//         ),
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: FadeInUp(
//                 duration: const Duration(milliseconds: 300),
//                 child: CustomCard(
//                   elevation: 4,
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Station Name
//                       _buildDetailRow(
//                         context,
//                         icon: Icons.local_gas_station,
//                         label: 'Station',
//                         value: transaction.stationName,
//                         style: theme.textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       // Amount
//                       _buildDetailRow(
//                         context,
//                         icon: Icons.monetization_on,
//                         label: 'Montant',
//                         value: '${transaction.amount} XOF',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: transaction.amount > 0
//                               ? Colors.green
//                               : theme.colorScheme.error,
//                         ),
//                         semanticsLabel: 'Montant de ${transaction.amount} XOF',
//                       ),
//                       const SizedBox(height: 16),
//                       // Date
//                       _buildDetailRow(
//                         context,
//                         icon: Icons.calendar_today,
//                         label: 'Date',
//                         value: transaction.date,
//                         style: theme.textTheme.titleMedium,
//                       ),
//                       const SizedBox(height: 16),
//                       // Fuel Type
//                       _buildDetailRow(
//                         context,
//                         icon: Icons.oil_barrel,
//                         label: 'Carburant',
//                         value: transaction.fuelType,
//                         style: theme.textTheme.titleMedium,
//                         trailing: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: _getFuelTypeColor(transaction.fuelType),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             transaction.fuelType,
//                             style: theme.textTheme.labelSmall?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (transaction.status != null) ...[
//                         const SizedBox(height: 16),
//                         // Status
//                         _buildDetailRow(
//                           context,
//                           icon: Icons.info,
//                           label: 'Statut',
//                           value: transaction.status!,
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             color: transaction.status == 'Terminé'
//                                 ? Colors.green
//                                 : Colors.orange,
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 24),
//                       // Report Button
//                       Center(
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             // Haptic feedback (requires `flutter_haptic` package)
//                             // HapticFeedback.mediumImpact();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: const Text('Problème signalé'),
//                                 backgroundColor: theme.colorScheme.error,
//                                 behavior: SnackBarBehavior.floating,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                             );
//                           },
//                           icon: const Icon(Icons.report_problem),
//                           label: const Text('Signaler un problème'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: theme.colorScheme.error,
//                             foregroundColor: theme.colorScheme.onError,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     TextStyle? style,
//     Widget? trailing,
//     String? semanticsLabel,
//   }) {
//     final theme = Theme.of(context);
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: theme.colorScheme.primaryContainer,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             icon,
//             color: theme.colorScheme.primary,
//             size: 24,
//             semanticLabel: label,
//           ),
//         ),
//         const SizedBox(width: 16),
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
//                 style: style ?? theme.textTheme.titleMedium,
//                 overflow: TextOverflow.ellipsis,
//                 semanticsLabel: semanticsLabel ?? value,
//               ),
//             ],
//           ),
//         ),
//         if (trailing != null) ...[
//           const SizedBox(width: 8),
//           trailing,
//         ],
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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../models/transaction.dart';
import '../widgets/custom_card.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:io';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Récupère la transaction passée en argument
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
                      // Boutons d'action
                      Center(
                        child: Wrap(
                          spacing: 16,
                          children: [
                            // Bouton pour signaler un problème
                            ElevatedButton.icon(
                              onPressed: () {
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
                            // Bouton pour générer un PDF
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _generateTransactionPdf(context, transaction),
                              icon: const Icon(Icons.picture_as_pdf),
                              label: const Text('Générer PDF'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ],
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

  // Génère un PDF stylisé pour la transaction spécifiée
  Future<void> _generateTransactionPdf(
      BuildContext context, Transaction transaction) async {
    // Crée un nouveau document PDF avec le format A4
    final pdf = pw.Document();

    // Définit les styles pour le PDF
    final headerStyle = pw.TextStyle(
      fontSize: 24,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.blue800,
    );
    final labelStyle = pw.TextStyle(
      fontSize: 16,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.grey800,
    );
    final valueStyle = const pw.TextStyle(fontSize: 16, color: PdfColors.black);

    // Ajoute une page au PDF avec un design amélioré
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(color: PdfColors.blue, width: 5),
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // En-tête du reçu
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.blue100,
                    borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Text(
                    'Reçu de Transaction',
                    style: headerStyle,
                  ),
                ),
                pw.SizedBox(height: 20),
                // Tableau des détails de la transaction
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    _buildPdfTableRow('Station', transaction.stationName,
                        labelStyle, valueStyle),
                    _buildPdfTableRow('Montant',
                        '${transaction.amount.abs()} XOF', labelStyle, valueStyle),
                    _buildPdfTableRow('Date', transaction.date, labelStyle, valueStyle),
                    _buildPdfTableRow('Type de carburant', transaction.fuelType,
                        labelStyle, valueStyle),
                    if (transaction.status != null)
                      _buildPdfTableRow('Statut', transaction.status!, labelStyle,
                          valueStyle),
                  ],
                ),
                pw.SizedBox(height: 20),
                // Pied de page
                pw.Text(
                  'Généré le ${DateTime.now().toString().substring(0, 10)}',
                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Récupère le chemin du répertoire temporaire
    final outputDir = await getTemporaryDirectory();
    final filePath = '${outputDir.path}/transaction_${transaction.id}.pdf';
    final file = File(filePath);

    // Sauvegarde le PDF dans le fichier
    await file.writeAsBytes(await pdf.save());

    // Ouvre le fichier PDF
    try {
      await OpenFilex.open(filePath);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF généré et ouvert avec succès')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ouverture du PDF: $e')),
      );
    }
  }

  // Construit une ligne pour le tableau du PDF
  pw.TableRow _buildPdfTableRow(String label, String value, pw.TextStyle labelStyle,
      pw.TextStyle valueStyle) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(label, style: labelStyle),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value, style: valueStyle),
        ),
      ],
    );
  }
}