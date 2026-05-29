import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/transitions.dart';
import 'splash_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptTerms = false;
  bool _isStudent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Remplis tous les champs obligatoires !',
              style: GoogleFonts.poppins()),
          backgroundColor: VertigoTheme.salmonRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Les mots de passe ne correspondent pas !',
              style: GoogleFonts.poppins()),
          backgroundColor: VertigoTheme.salmonRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Accepte les conditions d\'utilisation !',
              style: GoogleFonts.poppins()),
          backgroundColor: VertigoTheme.salmonRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      FadeRoute(page: const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VertigoTheme.creamBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  bottom: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushReplacement(
                            FadeRoute(page: const SplashScreen()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Image.asset('assets/logo.png',
                          height: 80, fit: BoxFit.contain),
                      const SizedBox(height: 12),
                      Text(
                        'Créer un compte 🎉',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rejoins la communauté Vertigo',
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  _buildField('Nom complet *', _nameController,
                      Icons.person_outline,
                      hint: 'Ton prénom et nom'),
                  const SizedBox(height: 16),

                  _buildField('Email *', _emailController,
                      Icons.email_outlined,
                      hint: 'ton@email.com',
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),

                  _buildField('Téléphone', _phoneController,
                      Icons.phone_outlined,
                      hint: '+213 555 123 456',
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),

                  _buildPasswordField(
                      'Mot de passe *',
                      _passwordController,
                      _obscurePassword,
                      () => setState(
                          () => _obscurePassword = !_obscurePassword)),
                  const SizedBox(height: 16),

                  _buildPasswordField(
                      'Confirmer le mot de passe *',
                      _confirmPasswordController,
                      _obscureConfirm,
                      () => setState(
                          () => _obscureConfirm = !_obscureConfirm)),

                  const SizedBox(height: 20),

                  // Statut étudiant
                  GestureDetector(
                    onTap: () =>
                        setState(() => _isStudent = !_isStudent),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isStudent
                            ? VertigoTheme.primaryGreen.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _isStudent
                              ? VertigoTheme.primaryGreen
                              : Colors.grey.shade200,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text('🎓',
                              style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Je suis étudiant(e)',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: _isStudent
                                        ? VertigoTheme.primaryGreen
                                        : VertigoTheme.textDark,
                                  ),
                                ),
                                Text(
                                  '-10% supplémentaire sur tous les paniers',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: VertigoTheme.textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _isStudent
                                  ? VertigoTheme.primaryGreen
                                  : Colors.transparent,
                              border: Border.all(
                                color: _isStudent
                                    ? VertigoTheme.primaryGreen
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: _isStudent
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Conditions
                  GestureDetector(
                    onTap: () =>
                        setState(() => _acceptTerms = !_acceptTerms),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _acceptTerms
                                ? VertigoTheme.primaryGreen
                                : Colors.transparent,
                            border: Border.all(
                              color: _acceptTerms
                                  ? VertigoTheme.primaryGreen
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _acceptTerms
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 16)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'J\'accepte les ',
                                  style: GoogleFonts.poppins(
                                      color: VertigoTheme.textGrey,
                                      fontSize: 13),
                                ),
                                TextSpan(
                                  text: 'conditions d\'utilisation',
                                  style: GoogleFonts.poppins(
                                    color: VertigoTheme.primaryGreen,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    decoration:
                                        TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VertigoTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Créer mon compte 🚀',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushReplacement(
                        SlideRightRoute(page: const LoginScreen()),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Déjà un compte ? ',
                              style: GoogleFonts.poppins(
                                  color: VertigoTheme.textGrey,
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: 'Se connecter',
                              style: GoogleFonts.poppins(
                                color: VertigoTheme.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: VertigoTheme.textDark,
                fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade400, fontSize: 14),
              prefixIcon:
                  Icon(icon, color: VertigoTheme.primaryGreen),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscure,
    VoidCallback onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: VertigoTheme.textDark,
                fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: const Icon(Icons.lock_outline,
                  color: VertigoTheme.primaryGreen),
              suffixIcon: GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: VertigoTheme.textGrey,
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}