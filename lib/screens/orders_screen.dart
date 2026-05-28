import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/dummy_data.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedTab = 0; // 0 = En cours, 1 = Historique

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VertigoTheme.creamBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Text(
                'Mes Commandes 🧺',
                style: GoogleFonts.fredoka(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: VertigoTheme.primaryGreen,
                ),
              ),
            ),

            // Tabs
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  _buildTab('En cours', 0),
                  const SizedBox(width: 12),
                  _buildTab('Historique', 1),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _selectedTab == 0
                  ? _buildActiveOrder()
                  : _buildHistory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? VertigoTheme.primaryGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? VertigoTheme.primaryGreen
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : VertigoTheme.textGrey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveOrder() {
    final basket = DummyData.baskets[0];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Carte commande active
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Numéro commande
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: VertigoTheme.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '● COMMANDE #VR-4821',
                        style: GoogleFonts.poppins(
                          color: VertigoTheme.primaryGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Titre statut
                Text(
                  'En chemin 🛵',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: VertigoTheme.primaryGreen,
                  ),
                ),

                const SizedBox(height: 16),

                // Info panier
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        basket.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            basket.store.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: VertigoTheme.textDark,
                            ),
                          ),
                          Text(
                            '${basket.title} · 1x',
                            style: GoogleFonts.poppins(
                              color: VertigoTheme.textGrey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${basket.discountedPrice.toStringAsFixed(0)} DA',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: VertigoTheme.primaryGreen,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${basket.originalPrice.toStringAsFixed(0)} DA',
                                style: GoogleFonts.poppins(
                                  color: VertigoTheme.textGrey,
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Timeline
                Text(
                  'Timeline',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: VertigoTheme.textDark,
                  ),
                ),
                const SizedBox(height: 16),

                _buildTimeline(),

                const SizedBox(height: 24),

                // Bouton confirmer réception
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '✅ Réception confirmée ! Bon appétit 🎉',
                            style: GoogleFonts.poppins(),
                          ),
                          backgroundColor: VertigoTheme.primaryGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VertigoTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirmer la réception',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
  final steps = [
    {'label': 'Commande passée', 'time': '17:42', 'done': true},
    {'label': 'Restaurant accepté', 'time': '17:46', 'done': true},
    {'label': 'Panier en préparation', 'time': '18:10', 'done': true},
    {'label': '🎉 Prêt à récupérer !', 'time': '18:22', 'done': true, 'active': true},
  ];

  return Column(
    children: List.generate(steps.length, (index) {
      final step = steps[index];
      final isDone = step['done'] as bool;
      final isActive = step['active'] == true;
      final isLast = index == steps.length - 1;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDone
                      ? isActive
                          ? VertigoTheme.primaryGreen
                          : VertigoTheme.primaryGreen.withOpacity(0.6)
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check : Icons.circle_outlined,
                  color: isDone ? Colors.white : Colors.grey.shade400,
                  size: 16,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 36,
                  color: VertigoTheme.primaryGreen.withOpacity(0.4),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step['label'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive
                          ? VertigoTheme.primaryGreen
                          : VertigoTheme.textDark,
                    ),
                  ),
                  Text(
                    step['time'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: VertigoTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }),
  );
}

  Widget _buildHistory() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: DummyData.baskets.length,
      itemBuilder: (context, index) {
        final basket = DummyData.baskets[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  basket.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      basket.store.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: VertigoTheme.textDark,
                      ),
                    ),
                    Text(
                      basket.title,
                      style: GoogleFonts.poppins(
                        color: VertigoTheme.textGrey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${basket.discountedPrice.toStringAsFixed(0)} DA',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: VertigoTheme.primaryGreen,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: VertigoTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '✅ Reçu',
                  style: GoogleFonts.poppins(
                    color: VertigoTheme.primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}