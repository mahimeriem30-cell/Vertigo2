import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'C\'est quoi Vertigo ?',
      'answer':
          'Vertigo est une application qui te permet de récupérer des paniers surprises à prix réduit chez des commerçants locaux à Oran et ses alentours. Tu sauves de la nourriture et tu fais des économies !',
      'expanded': false,
    },
    {
      'question': 'Comment réserver un panier ?',
      'answer':
          'C\'est simple ! Parcours les paniers disponibles, clique sur celui qui t\'intéresse, puis appuie sur "Réserver ce panier". Tu recevras une confirmation et tu n\'auras plus qu\'à te rendre au commerce aux horaires indiqués.',
      'expanded': false,
    },
    {
      'question': 'Comment savoir quand mon panier est prêt ?',
      'answer':
          'Tu recevras une notification dès que ton panier est prêt à être récupéré. Tu peux aussi suivre l\'état de ta commande dans l\'onglet "Commandes".',
      'expanded': false,
    },
    {
      'question': 'Comment payer ?',
      'answer':
          'Tu peux payer en espèces directement au commerce lors de la récupération, ou via CIB/EDAHABIA ou BaridiMob. Configure ta méthode de paiement dans Profil → Paiement.',
      'expanded': false,
    },
    {
      'question': 'Puis-je annuler ma réservation ?',
      'answer':
          'Oui, tu peux annuler ta réservation jusqu\'à 30 minutes avant l\'heure de récupération. Au-delà, l\'annulation n\'est plus possible.',
      'expanded': false,
    },
    {
      'question': 'Que contient un panier surprise ?',
      'answer':
          'Les paniers contiennent les invendus du jour du commerçant. Tu ne sais pas exactement ce qu\'il y a dedans, mais la valeur est toujours bien supérieure au prix payé !',
      'expanded': false,
    },
    {
      'question': 'Comment contacter un commerçant ?',
      'answer':
          'Tu peux voir l\'adresse du commerce dans la page détail du panier. Pour toute question, contacte notre support via ce formulaire.',
      'expanded': false,
    },
    {
      'question': 'Comment signaler un problème ?',
      'answer':
          'Si tu as un problème avec une commande, contacte-nous directement via l\'email support@vertigo.dz ou via le chat de l\'application.',
      'expanded': false,
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
          'Aide & FAQ',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: VertigoTheme.textDark,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3D1A), Color(0xFF3A7A32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comment on peut t\'aider ? 💚',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Retrouve toutes les réponses ici',
                          style: GoogleFonts.poppins(
                            color: Colors.white60,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('🤝', style: TextStyle(fontSize: 40)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Questions fréquentes',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: VertigoTheme.textDark,
              ),
            ),

            const SizedBox(height: 12),

            // FAQ accordéon
            ...List.generate(_faqs.length, (index) {
              final faq = _faqs[index];
              final isExpanded = faq['expanded'] as bool;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isExpanded
                        ? VertigoTheme.primaryGreen.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        faq['question'] as String,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: VertigoTheme.textDark,
                        ),
                      ),
                      trailing: AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: isExpanded
                              ? VertigoTheme.primaryGreen
                              : VertigoTheme.textGrey,
                        ),
                      ),
                      onTap: () => setState(
                          () => _faqs[index]['expanded'] = !isExpanded),
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          faq['answer'] as String,
                          style: GoogleFonts.poppins(
                            color: VertigoTheme.textGrey,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Contact support
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
              child: Column(
                children: [
                  const Text('📧', style: TextStyle(fontSize: 36)),
                  const SizedBox(height: 8),
                  Text(
                    'Tu n\'as pas trouvé ta réponse ?',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: VertigoTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Contacte-nous à support@vertigo.dz',
                    style: GoogleFonts.poppins(
                      color: VertigoTheme.textGrey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VertigoTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Contacter le support',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}