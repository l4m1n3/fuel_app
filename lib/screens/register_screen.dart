// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   void _register(BuildContext context) {
//     final name = _nameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Les mots de passe ne correspondent pas')),
//       );
//       return;
//     }

//     // Update AppState with static user data
//     Provider.of<AppState>(context, listen: false).setUserData(name, email);

//     // Navigate to dashboard
//     Navigator.pushReplacementNamed(context, '/dashboard');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Center(
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.local_gas_station,
//                       size: 80,
//                       color: isDarkMode ? Colors.white : Color(0xFF1E3A8A),
//                       semanticLabel: 'Logo Fuel Card',
//                     ),
//                     Text(
//                       'Fuel Card',
//                       style: theme.textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E3A8A),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Titre
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 500),
//                 child: Text(
//                   'Créer un compte',
//                   style: theme.textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E3A8A),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 600),
//                 child: Text(
//                   'Inscrivez-vous pour gérer vos cartes carburant',
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     color: theme.colorScheme.onSurface.withOpacity(0.6),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),

//               // Champ Nom
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 700),
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Nom complet',
//                     prefixIcon: Icon(Icons.person_outline, semanticLabel: 'Nom'),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   keyboardType: TextInputType.name,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Champ Email
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 800),
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Adresse email',
//                     prefixIcon: Icon(Icons.email_outlined, semanticLabel: 'Email'),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Champ Mot de passe
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 900),
//                 child: TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Mot de passe',
//                     prefixIcon: Icon(Icons.lock_outlined, semanticLabel: 'Mot de passe'),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
//                         semanticLabel: _obscurePassword ? 'Afficher le mot de passe' : 'Masquer le mot de passe',
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   obscureText: _obscurePassword,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Champ Confirmation Mot de passe
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 1000),
//                 child: TextField(
//                   controller: _confirmPasswordController,
//                   decoration: InputDecoration(
//                     labelText: 'Confirmer le mot de passe',
//                     prefixIcon: Icon(Icons.lock_outlined, semanticLabel: 'Confirmer le mot de passe'),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
//                         semanticLabel: _obscureConfirmPassword ? 'Afficher la confirmation' : 'Masquer la confirmation',
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   obscureText: _obscureConfirmPassword,
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Bouton d'inscription
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 1100),
//                 child: ElevatedButton(
//                   onPressed: () => _register(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF1E3A8A), // Bleu pétrole
//                     foregroundColor: Colors.white,
//                     minimumSize: const Size(double.infinity, 56),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'S’inscrire',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Retour à la connexion
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 1200),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Déjà un compte ? ',
//                       style: theme.textTheme.bodyLarge,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/login');
//                       },
//                       child: Text(
//                         'Se connecter',
//                         style: TextStyle(color: Color(0xFFF59E0B)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Simulation de traitement asynchrone
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Provider.of<AppState>(context, listen: false).setUserData(name, email);
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom';
    }
    if (value.length < 3) {
      return 'Nom trop court';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (value.length < 8) {
      return '8 caractères minimum';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo et titre de l'application
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_gas_station_rounded,
                          size: 80,
                          color: colors.primary,
                          semanticLabel: 'Logo Fuel Card',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fuel Card',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Titre section
                  Text(
                    'Créer un compte',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Inscrivez-vous pour gérer vos cartes carburant',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Champ Nom complet
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom complet',
                      hintText: 'Jean Dupont',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    validator: _validateName,
                  ),
                  const SizedBox(height: 20),

                  // Champ Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Adresse email',
                      hintText: 'exemple@email.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: _validateEmail,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Champ Mot de passe
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword 
                              ? Icons.visibility_outlined 
                              : Icons.visibility_off_outlined,
                          semanticLabel: _obscurePassword 
                              ? 'Afficher le mot de passe' 
                              : 'Masquer le mot de passe',
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _validatePassword,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16),
                    child: Text(
                      'Minimum 8 caractères',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Champ Confirmation mot de passe
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword 
                              ? Icons.visibility_outlined 
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _validateConfirmPassword,
                    onFieldSubmitted: (_) => _register(context),
                  ),
                  const SizedBox(height: 24),

                  // Bouton d'inscription
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () => _register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'S\'inscrire',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Séparateur
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colors.outline.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Ou',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colors.outline.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Bouton de connexion sociale
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton.icon(
                  //     onPressed: () {}, // Ajouter la logique Google
                  //     icon: Image.asset(
                  //       'assets/images/google_logo.png',
                  //       width: 24,
                  //       height: 24,
                  //     ),
                  //     label: const Text('Continuer avec Google'),
                  //     style: OutlinedButton.styleFrom(
                  //       foregroundColor: colors.onSurface,
                  //       side: BorderSide(color: colors.outline),
                  //       minimumSize: const Size(double.infinity, 56),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(vertical: 16),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),

                  // Lien vers la connexion
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: colors.primary,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Déjà un compte ? ',
                          style: theme.textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: 'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}