import 'package:app/rapport.dart';
import 'package:app/signUpPage.dart';
import 'package:flutter/material.dart';
 import 'package:app/loginpage.dart';
 import 'package:app/gestion_budget.dart';
 import 'package:app/homepage.dart';
 import 'package:app/rapport.dart';




class NavigationUtils {
  static void navigateToHomePage(BuildContext context) {
     Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage(gestionnaireBudget: GestionnaireBudget(0),)));
  }

  static void navigateToLoginPage(BuildContext context) {
     Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  static void navigateToSignUpPage(BuildContext context) {
     Navigator.push(
        context, MaterialPageRoute(builder: (context) => MysignUpPage()));
  }

  static void navigateToLogoutPage(BuildContext context) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

   static void navigateToRapportPage(BuildContext context) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => Mytransactions(gestionnaireBudget: GestionnaireBudget(0),)));
  }

  static void logout(BuildContext context) {
    // Ajoutez ici le code pour gérer la déconnexion, par exemple,
    // vous pouvez effectuer des opérations de nettoyage ou de déconnexion
    // puis rediriger vers la page de connexion
    navigateToLogoutPage(context);
  }
}
