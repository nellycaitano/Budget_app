import 'package:app/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/navigate.dart';

class MysignUpPage extends StatefulWidget {
  const MysignUpPage({Key? key});

  @override
  State<MysignUpPage> createState() => _MysignUpPageState();
}

class _MysignUpPageState extends State<MysignUpPage> {
  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyLoginPage()),
    );
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleSignUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String username = usernameController.text;

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Enregistrez le reste des informations dans Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user?.uid)
          .set({
        'username': username,
        'email': email,
        // Ajoutez d'autres champs si nécessaire
      });

      print('User signed up: ${credential.user?.uid}');
      print('Username: $username');

      // Affichez un message de succès
      _showSnackBar('Registration successful');
      _navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _showSnackBar('Weak password. Please choose a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _showSnackBar('An account already exists for this email.');
      }
    } catch (e) {
      print(e);
      // Affichez un message d'erreur générique
      _showSnackBar('Registration failed. Please try again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 10),
      ),
    );
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
                'images/inscrip.jpg',
                width: 400,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Hi!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                'Create a new account',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 40,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  _handleSignUp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5f75cb),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
