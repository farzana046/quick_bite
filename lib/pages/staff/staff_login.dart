import 'package:flutter/material.dart';
import 'package:quick_bite/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StaffLoginPage extends StatefulWidget {
  const StaffLoginPage({super.key});

  @override
  State<StaffLoginPage> createState() => _StaffLoginPageState();
}

class _StaffLoginPageState extends State<StaffLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> _signIn() async {
    try {
      // Sign in with email & password
      await _authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      // Get current signed-in email
      final sessionEmail = _authService.getCurrentUserEmail();
      if (sessionEmail == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get user session')),
        );
        return;
      }

      // Check if the email exists in the staff table
      final staffResponse = await _supabase
          .from('staff')
          .select()
          .eq('email', sessionEmail)
          .maybeSingle();

      if (staffResponse == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are not authorized as staff')),
        );
        return;
      }

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully as staff')),
      );

      // Navigate to staff home (create a StaffHomePage for this route)
      Navigator.pushReplacementNamed(context, '/staff-home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), 
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // QuickBite Text
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quick',
                        style: TextStyle(
                          color: Color(0xFFEA580C), 
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Bite',
                        style: TextStyle(
                          color: Color(0xFF1F2937), 
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Staff Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937), 
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to your staff account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4B5563), 
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB), 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login button (ash color)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B5563), 
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Back to Role Selection
                SizedBox(
                  width: double.infinity,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/role-select');
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith(
                          (states) => states.contains(MaterialState.hovered)
                              ? const Color(0xFFF9FAFB) // ash hover
                              : null,
                        ),
                      ),
                      child: const Text(
                        'Back to Role Selection',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF1F2937), 
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}