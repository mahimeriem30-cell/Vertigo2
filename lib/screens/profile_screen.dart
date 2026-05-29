import '../services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'my_info_screen.dart';
import 'address_screen.dart';
import 'payment_screen.dart';
import 'faq_screen.dart';
import 'package:provider/provider.dart';
import '../core/app_settings.dart';
import 'splash_screen.dart';
import '../core/transitions.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Utilisateur? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);

    final user = await ApiService.getProfile();

    setState(() {
      _user = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await ApiService.logout();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SplashScreen()),
        (route) => false,
      );
    }
  }

  void _showLanguagePicker(BuildContext context) {
    final settings = context.read<AppSettings>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Choisir la langue / Choose language',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: VertigoTheme.textDark,
                ),
              ),
              const SizedBox(height: 16),
              ...['Français', 'English'].map((lang) {
                final isSelected = settings.language == lang;
                return GestureDetector(
                  onTap: () {
                    settings.setLanguage(lang);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? VertigoTheme.primaryGreen.withOpacity(0.1)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? VertigoTheme.primaryGreen
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          lang == 'Français' ? '🇫🇷' : '🇬🇧',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          lang,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: isSelected
                                ? VertigoTheme.primaryGreen
                                : VertigoTheme.textDark,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(Icons.check_circle,
                              color: VertigoTheme.primaryGreen),
                      ],
                    ),
                  ),
<<<<<<< Updated upstream
                  child: Row(
                    children: [
                      Text(
                        lang == 'Français' ? '🇫🇷' : '🇬🇧',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        lang,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isSelected
                              ? VertigoTheme.primaryGreen
                              : VertigoTheme.textDark,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: VertigoTheme.primaryGreen,
                        ),
                    ],
=======
                );
              }).toList(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showStudentModal(BuildContext context) {
    final settings = context.read<AppSettings>();
    final idController =
        TextEditingController(text: settings.studentId);
    bool isStudent = settings.isStudent;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
>>>>>>> Stashed changes
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Statut étudiant 🎓',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: VertigoTheme.textDark,
                  ),
                ),
                const SizedBox(height: 16),

                // Toggle étudiant
                GestureDetector(
                  onTap: () =>
                      setModalState(() => isStudent = !isStudent),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isStudent
                          ? VertigoTheme.primaryGreen.withOpacity(0.1)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isStudent
                            ? VertigoTheme.primaryGreen
                            : Colors.grey.shade200,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text('🎓',
                            style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Je suis étudiant(e)',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: isStudent
                                      ? VertigoTheme.primaryGreen
                                      : VertigoTheme.textDark,
                                ),
                              ),
                              Text(
                                '-10% sur tous les paniers',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: VertigoTheme.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isStudent,
                          onChanged: (v) =>
                              setModalState(() => isStudent = v),
                          activeColor: VertigoTheme.primaryGreen,
                        ),
                      ],
                    ),
                  ),
                ),

                if (isStudent) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Numéro étudiant',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: VertigoTheme.textDark,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: VertigoTheme.creamBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: idController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'ex: 202437411019',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade400,
                            fontSize: 14),
                        prefixIcon: const Icon(
                            Icons.badge_outlined,
                            color: VertigoTheme.primaryGreen),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      settings.setStudent(isStudent,
                          id: idController.text);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isStudent
                                ? '✅ Statut étudiant activé !'
                                : 'Statut étudiant désactivé',
                            style: GoogleFonts.poppins(),
                          ),
                          backgroundColor: VertigoTheme.primaryGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VertigoTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: Text('Sauvegarder',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final t = settings.t;

    return Scaffold(
      backgroundColor: VertigoTheme.creamBg,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: VertigoTheme.primaryGreen,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
<<<<<<< Updated upstream
                    // Header
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1E3D1A), Color(0xFF3A7A32)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 46,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: Text(
                                  _user?.nom.isNotEmpty == true
                                      ? _user!.nom[0].toUpperCase()
                                      : 'M',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 42,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: VertigoTheme.salmonRed,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _user?.nom ?? 'Utilisateur',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
=======
                    // Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 46,
                          backgroundColor:
                              Colors.white.withOpacity(0.2),
                          child: Text(
                            settings.userName.isNotEmpty
                                ? settings.userName[0].toUpperCase()
                                : 'M',
                            style: GoogleFonts.fredoka(
                              fontSize: 42,
                              color: Colors.white,
>>>>>>> Stashed changes
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
<<<<<<< Updated upstream
                          Text(
                            _user?.email ?? 'email@example.com',
                            style: GoogleFonts.poppins(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStat('12', 'Paniers\nsauvés'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white24,
                              ),
                              _buildStat('3 240 DA', 'Économisé'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white24,
                              ),
                              _buildStat('18 kg', 'CO₂ évité'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Mon compte
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mon compte',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: VertigoTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildMenuCard([
                            _MenuItem(
                              icon: Icons.person_outline,
                              label: 'Mes informations',
                              color: VertigoTheme.primaryGreen,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyInfoScreen(),
                                ),
                              ),
                            ),
                            _MenuItem(
                              icon: Icons.location_on_outlined,
                              label: 'Mes adresses',
                              color: VertigoTheme.salmonRed,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddressScreen(),
                                ),
                              ),
                            ),
                            _MenuItem(
                              icon: Icons.payment_outlined,
                              label: 'Paiement',
                              color: VertigoTheme.accentYellow,
                              iconColor: VertigoTheme.textDark,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PaymentScreen(),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Préférences
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Préférences',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: VertigoTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildMenuCard([
                            _MenuItem(
                              icon: Icons.notifications_outlined,
                              label: 'Notifications',
                              color: Colors.purple,
                              trailing: Switch(
                                value: true,
                                onChanged: (_) {},
                                activeColor: VertigoTheme.primaryGreen,
                              ),
                            ),
                            _MenuItem(
                              icon: Icons.language_outlined,
                              label: 'Langue',
                              color: Colors.blue,
                              subtitle: context.watch<AppSettings>().language,
                              onTap: () => _showLanguagePicker(context),
                            ),
                          ]),
                        ],
                      ),
=======
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: const MyInfoScreen()),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: VertigoTheme.salmonRed,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      settings.userName,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      settings.userEmail,
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                    if (settings.isStudent) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: VertigoTheme.accentYellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '🎓 Étudiant · ${settings.studentId}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: VertigoTheme.textDark,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('12', t('baskets_saved')),
                        Container(
                            width: 1,
                            height: 40,
                            color: Colors.white24),
                        _buildStat('3 240 DA', t('saved')),
                        Container(
                            width: 1,
                            height: 40,
                            color: Colors.white24),
                        _buildStat('18 kg', 'CO₂ évité'),
                      ],
>>>>>>> Stashed changes
                    ),

                    const SizedBox(height: 20),

<<<<<<< Updated upstream
                    // Support
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Support',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: VertigoTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildMenuCard([
                            _MenuItem(
                              icon: Icons.help_outline,
                              label: 'Aide & FAQ',
                              color: Colors.orange,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FaqScreen(),
                                ),
                              ),
                            ),
                            _MenuItem(
                              icon: Icons.star_outline,
                              label: 'Noter l\'app',
                              color: VertigoTheme.accentYellow,
                              iconColor: VertigoTheme.textDark,
                              onTap: () =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '⭐ Merci pour ton soutien !',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor:
                                          VertigoTheme.primaryGreen,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                            ),
                            _MenuItem(
                              icon: Icons.share_outlined,
                              label: 'Partager Vertigo',
                              color: VertigoTheme.primaryGreen,
                              onTap: () =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '🔗 Lien copié !',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor:
                                          VertigoTheme.primaryGreen,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                            ),
                          ]),
                        ],
                      ),
                    ),
=======
              // Mon compte
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('my_account'),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: VertigoTheme.textDark)),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _MenuItem(
                        icon: Icons.person_outline,
                        label: t('my_info'),
                        color: VertigoTheme.primaryGreen,
                        onTap: () => Navigator.push(
                            context,
                            SlideRightRoute(
                                page: const MyInfoScreen())),
                      ),
                      _MenuItem(
                        icon: Icons.location_on_outlined,
                        label: t('my_addresses'),
                        color: VertigoTheme.salmonRed,
                        onTap: () => Navigator.push(
                            context,
                            SlideRightRoute(
                                page: const AddressScreen())),
                      ),
                      _MenuItem(
                        icon: Icons.payment_outlined,
                        label: t('payment'),
                        color: VertigoTheme.accentYellow,
                        iconColor: VertigoTheme.textDark,
                        onTap: () => Navigator.push(
                            context,
                            SlideRightRoute(
                                page: const PaymentScreen())),
                      ),
                      _MenuItem(
                        icon: Icons.school_outlined,
                        label: t('student_status'),
                        color: Colors.teal,
                        subtitle: settings.isStudent
                            ? settings.studentId
                            : null,
                        onTap: () =>
                            _showStudentModal(context),
                      ),
                    ]),
                  ],
                ),
              ),
>>>>>>> Stashed changes

                    const SizedBox(height: 20),

<<<<<<< Updated upstream
                    // Déconnexion
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: _logout,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: VertigoTheme.salmonRed,
                            side: const BorderSide(
                              color: VertigoTheme.salmonRed,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Se déconnecter',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Vertigo v1.0.0 · Made with 💚 in Oran',
                      style: GoogleFonts.poppins(
                        color: VertigoTheme.textGrey,
                        fontSize: 12,
=======
              // Préférences
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('preferences'),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: VertigoTheme.textDark)),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _MenuItem(
                        icon: Icons.notifications_outlined,
                        label: t('notifications'),
                        color: Colors.purple,
                        trailing: Switch(
                          value: true,
                          onChanged: (_) {},
                          activeColor: VertigoTheme.primaryGreen,
                        ),
                      ),
                      _MenuItem(
                        icon: Icons.language_outlined,
                        label: t('language'),
                        color: Colors.blue,
                        subtitle: settings.language,
                        onTap: () =>
                            _showLanguagePicker(context),
                      ),
                    ]),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Support
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('support'),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: VertigoTheme.textDark)),
                    const SizedBox(height: 12),
                    _buildMenuCard([
                      _MenuItem(
                        icon: Icons.help_outline,
                        label: t('help_faq'),
                        color: Colors.orange,
                        onTap: () => Navigator.push(
                            context,
                            SlideRightRoute(
                                page: const FaqScreen())),
                      ),
                      _MenuItem(
                        icon: Icons.star_outline,
                        label: t('rate_app'),
                        color: VertigoTheme.accentYellow,
                        iconColor: VertigoTheme.textDark,
                        onTap: () =>
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                          SnackBar(
                            content: Text('⭐ Merci !',
                                style: GoogleFonts.poppins()),
                            backgroundColor:
                                VertigoTheme.primaryGreen,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      _MenuItem(
                        icon: Icons.share_outlined,
                        label: t('share'),
                        color: VertigoTheme.primaryGreen,
                        onTap: () =>
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                          SnackBar(
                            content: Text('🔗 Lien copié !',
                                style: GoogleFonts.poppins()),
                            backgroundColor:
                                VertigoTheme.primaryGreen,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12)),
                          ),
                        ),
>>>>>>> Stashed changes
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
<<<<<<< Updated upstream
            ),
=======

              const SizedBox(height: 20),

              // Déconnexion
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushAndRemoveUntil(
                      FadeRoute(page: const SplashScreen()),
                      (route) => false,
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: VertigoTheme.salmonRed,
                      side: const BorderSide(
                          color: VertigoTheme.salmonRed),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(t('logout'),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Vertigo v1.0.0 · Made with 💚 in Oran',
                style: GoogleFonts.poppins(
                    color: VertigoTheme.textGrey, fontSize: 12),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
>>>>>>> Stashed changes
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
<<<<<<< Updated upstream
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Colors.white60, fontSize: 11),
        ),
=======
        Text(value,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        Text(label,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(color: Colors.white60, fontSize: 11)),
>>>>>>> Stashed changes
      ],
    );
  }

  Widget _buildMenuCard(List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor ?? item.color,
                    size: 20,
                  ),
                ),
                title: Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: VertigoTheme.textDark,
                  ),
                ),
                subtitle: item.subtitle != null
                    ? Text(
                        item.subtitle!,
                        style: GoogleFonts.poppins(
<<<<<<< Updated upstream
                          fontSize: 12,
                          color: VertigoTheme.textGrey,
                        ),
                      )
=======
                            fontSize: 12,
                            color: VertigoTheme.textGrey))
>>>>>>> Stashed changes
                    : null,
                trailing:
                    item.trailing ??
                    const Icon(
                      Icons.chevron_right,
                      color: VertigoTheme.textGrey,
                    ),
                onTap: item.onTap,
              ),
              if (!isLast)
                Divider(
                    height: 1,
                    indent: 56,
                    color: Colors.grey.shade100),
            ],
          );
        }),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final Color? iconColor;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
    this.iconColor,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}
