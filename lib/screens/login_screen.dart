// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   // Méthode pour gérer la connexion
//   Future<void> _handleLogin() async {
//     if (!_validateInputs()) return;

//     setState(() => _isLoading = true);
    
//     // Simuler un appel API
//     await Future.delayed(const Duration(seconds: 2));
    
//     if (mounted) {
//       setState(() => _isLoading = false);
//       Navigator.pushReplacementNamed(context, '/dashboard');
//     }
//   }

//   bool _validateInputs() {
//     if (_phoneController.text.isEmpty || !_phoneController.text.contains('@')) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez entrer votre numero de telephone')),
//       );
//       return false;
//     }
    
//     if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
//       );
//       return false;
//     }
    
//     return true;
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//           child: AutofillGroup(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Logo et titre
//                 Center(
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.local_gas_station_rounded,
//                         size: 80,
//                         color: colors.primary,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Fuel Card',
//                         style: theme.textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: colors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // Titre section
//                 Text(
//                   'Connexion',
//                   style: theme.textTheme.headlineMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Accédez à votre compte',
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     color: colors.onSurface.withOpacity(0.7),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Champ Email
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(
//                     labelText: 'Numéro de téléphone',
//                     hintText: '+227 96 12 34 56',
//                     prefixIcon: const Icon(Icons.email_outlined),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: colors.outline),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: colors.outline),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   autofillHints: const [AutofillHints.email],
//                   inputFormatters: [
//                     FilteringTextInputFormatter.deny(RegExp(r'\s')),
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty || !value.contains('@')) {
//                       return 'numero invalide';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Champ Mot de passe
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Mot de passe',
//                     hintText: '••••••••',
//                     prefixIcon: const Icon(Icons.lock_outlined),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword 
//                             ? Icons.visibility_outlined 
//                             : Icons.visibility_off_outlined,
//                       ),
//                       onPressed: () {
//                         setState(() => _obscurePassword = !_obscurePassword);
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: colors.outline),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: colors.outline),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                   obscureText: _obscurePassword,
//                   textInputAction: TextInputAction.done,
//                   autofillHints: const [AutofillHints.password],
//                   onFieldSubmitted: (_) => _handleLogin(),
//                 ),
//                 const SizedBox(height: 8),

//                 // Mot de passe oublié
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/forgot-password');
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: colors.primary,
//                     ),
//                     child: const Text('Mot de passe oublié ?'),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Bouton de connexion
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _handleLogin,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: colors.primary,
//                       foregroundColor: colors.onPrimary,
//                       minimumSize: const Size(double.infinity, 56),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Text(
//                             'Se connecter',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Séparateur
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: colors.outline.withOpacity(0.3),
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Ou',
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: colors.onSurface.withOpacity(0.6),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         color: colors.outline.withOpacity(0.3),
//                         thickness: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),

//                 // Boutons de connexion sociale
//                 // SizedBox(
//                 //   width: double.infinity,
//                 //   child: OutlinedButton.icon(
//                 //     onPressed: () {}, // Ajouter la logique Google
//                 //     icon: Image.asset(
//                 //       'assets/images/google_logo.png',
//                 //       width: 24,
//                 //       height: 24,
//                 //     ),
//                 //     label: const Text('Continuer avec Google'),
//                 //     style: OutlinedButton.styleFrom(
//                 //       foregroundColor: colors.onSurface,
//                 //       side: BorderSide(color: colors.outline),
//                 //       minimumSize: const Size(double.infinity, 56),
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(12),
//                 //       ),
//                 //       padding: const EdgeInsets.symmetric(vertical: 16),
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(height: 16),

//                 // Option d'inscription
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Nouveau client ? ',
//                       style: theme.textTheme.bodyLarge,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/register');
//                       },
//                       style: TextButton.styleFrom(
//                         foregroundColor: colors.primary,
//                       ),
//                       child: const Text('Créer un compte'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '/data/database_helper.dart';
import '../main.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final dbHelper = DatabaseHelper.instance;
    final user = await dbHelper.loginUser(email, password);

    setState(() => _isLoading = false);

    if (user != null) {
      Provider.of<AppState>(context, listen: false)
          .setUserData(user.id, user.name, user.email);
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email ou mot de passe incorrect'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
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
      return 'Veuillez entrer votre mot de passe';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: FadeInUp(
            duration: const Duration(milliseconds: 300),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Text(
                      'Se connecter',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Connectez-vous pour gérer vos cartes carburant',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Adresse email',
                        hintText: 'exemple@email.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      validator: _validatePassword,
                      onFieldSubmitted: (_) => _login(context),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _login(context),
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
                                'Se connecter',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: colors.primary,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Pas de compte ? ',
                            style: theme.textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: 'S\'inscrire',
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
      ),
    );
  }
}