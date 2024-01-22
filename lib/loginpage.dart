import 'package:flutter/material.dart';
import 'package:app/gestion_budget.dart';
import 'package:app/homepage.dart';
import 'package:app/signUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/navigate.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          gestionnaireBudget: GestionnaireBudget(0),
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MysignUpPage()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _handleSignIn() async {
  String email = emailController.text;
  String password = passwordController.text;

  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print('User signed in: ${credential.user?.uid}');

    // Afficher un SnackBar de succès
    _showSnackBar('Sign-in successful!');

    // Si la connexion est réussie, naviguer vers la page d'accueil
    _navigateToHomePage();
  } on FirebaseAuthException catch (e) {
    print('Error during sign-in: ${e.message}'); // Afficher l'erreur détaillée
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      // Afficher un SnackBar d'erreur
      _showSnackBar('Invalid email or password');
    
    } else {
      // Gérer d'autres erreurs si nécessaire
      _showSnackBar('Invalid email or password');
    }
  } catch (e) {
    print('Unexpected error: $e');
    // Gérer d'autres erreurs non liées à FirebaseAuthException
    _showSnackBar('Unexpected error occurred');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logall.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 40,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 350,
                height: 40,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _handleSignIn();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5f75cb),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  _navigateToSignUp();
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(color: Color(0xFF484df0), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
