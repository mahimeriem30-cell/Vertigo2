import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0;

  final List<Map<String, dynamic>> _methods = [
    {
      'label': 'Paiement à la récupération',
      'subtitle': 'Payer en espèces au commerce',
      'icon': Icons.payments_outlined,
      'color': VertigoTheme.primaryGreen,
    },
    {
      'label': 'CIB / EDAHABIA',
      'subtitle': 'Carte bancaire algérienne',
      'icon': Icons.credit_card_outlined,
      'color': Colors.blue,
    },
    {
      'label': 'BaridiMob',
      'subtitle': 'Paiement mobile Algérie Poste',
      'icon': Icons.phone_android_outlined,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VertigoTheme.creamBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back,
                color: VertigoTheme.textDark, size: 20),
          ),
        ),
        title: Text(
          'Paiement',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: VertigoTheme.textDark,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Méthode de paiement',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: VertigoTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),

            // Méthodes
            ...List.generate(_methods.length, (index) {
              final method = _methods[index];
              final isSelected = _selectedMethod == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedMethod = index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? VertigoTheme.primaryGreen
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (method['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          method['icon'] as IconData,
                          color: method['color'] as Color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['label'] as String,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: VertigoTheme.textDark,
                              ),
                            ),
                            Text(
                              method['subtitle'] as String,
                              style: GoogleFonts.poppins(
                                color: VertigoTheme.textGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? VertigoTheme.primaryGreen
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          color: isSelected
                              ? VertigoTheme.primaryGreen
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 14)
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),

            // Info sécurité
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: VertigoTheme.primaryGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security_outlined,
                      color: VertigoTheme.primaryGreen, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tes paiements sont sécurisés et cryptés.',
                      style: GoogleFonts.poppins(
                        color: VertigoTheme.primaryGreen,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bouton sauvegarder
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '✅ Méthode de paiement sauvegardée !',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: VertigoTheme.primaryGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: VertigoTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Sauvegarder',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}