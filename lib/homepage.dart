import 'package:app/rapport.dart';
import 'package:flutter/material.dart';
import 'package:app/gestion_budget.dart';
import 'package:app/rapport.dart';
import 'package:app/navigate.dart';

class MyHomePage extends StatefulWidget {
  final GestionnaireBudget gestionnaireBudget;

  MyHomePage({required this.gestionnaireBudget});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController categorieController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CashFlow Manager',style: TextStyle(fontWeight: FontWeight.w300),),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF8f9fed),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                NavigationUtils.navigateToHomePage(context);
              },
            ),
             ListTile(
              title: Text('Login'),
              onTap: () {
                NavigationUtils.navigateToLoginPage(context);
              },
            ),
             ListTile(
              title: Text('Sign Up'),
              onTap: () {
                NavigationUtils.navigateToSignUpPage(context);
              },
            ),
            ListTile(
              title: Text('Rapport'),
              onTap: () {
                NavigationUtils.navigateToRapportPage(context);
              },
            ),
             ListTile(
              title: Text('Déconnexion'),
              onTap: () {
                NavigationUtils.navigateToLogoutPage(context);
              },
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Budget: ${widget.gestionnaireBudget.budget.amount.toString()} FCFA',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: <Widget>[
                _buildActionButton('Enregistrer une dépense', Icons.add_circle,
                    () => _enregistrerDepense(context)),
                _buildActionButton('Ajouter de l\'argent', Icons.attach_money,
                    () => _ajouterArgent(context)),
                /*  _buildActionButton('Budget restant', Icons.money_off,
                    () => widget.gestionnaireBudget.afficherBudgetRestant()),*/
                _buildActionButton('Rapport des Transactions', Icons.list,
                    () => _afficherToutesDepenses(context)),
                _buildActionButton('Dépenses par catégorie', Icons.category,
                    () => _afficherDepensesParCategorie(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData iconData, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
          elevation: 4,
          child: SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, size: 40, color: Color(0xFF6a7de6)),
                SizedBox(height: 8),
                Text(label, textAlign: TextAlign.center),
              ],
            ),
          )),
    );
  }

  void _enregistrerDepense(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Utilisez des TextEditingController pour obtenir les valeurs des champs de texte

        return AlertDialog(
          title: Text('Enregistrer une dépense'),
          content: Column(
            children: [
              TextField(
                controller: categorieController,
                decoration: InputDecoration(labelText: 'Catégorie'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: montantController,
                decoration: InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != DateTime.now()) {
                        dateController.text =
                            pickedDate.toLocal().toString().split(' ')[0];
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Ajoutez le code pour enregistrer la dépense ici
                String categorie = categorieController.text;
                String description = descriptionController.text;
                double? montant = double.tryParse(montantController.text);
                String date = dateController.text;

                if (montant != null) {
                  // Utilisez la fonction d'enregistrement de dépense de GestionnaireBudget
                  widget.gestionnaireBudget.enregistrerDepense(
                    description,
                    categorie,
                    montant,
                    DateTime.parse(date),
                  );
                  // Rafraîchissez l'interface en appelant setState
                  setState(() {});
                }

                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _ajouterArgent(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Utilisez un TextEditingController pour obtenir la valeur du champ de texte
        TextEditingController montantController = TextEditingController();

        return AlertDialog(
          title: Text(
            'Ajouter de l\'argent au budget',
            style: TextStyle(fontSize: 16),
          ),
          content: TextField(
            controller: montantController,
            decoration: InputDecoration(labelText: 'Montant'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                double? montant = double.tryParse(montantController.text);
                if (montant != null) {
                  widget.gestionnaireBudget.ajouterArgent(montant);
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _afficherToutesDepenses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mytransactions(
          gestionnaireBudget: widget.gestionnaireBudget,
        ),
      ),
    );
  }

  void _afficherDepensesParCategorie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Utilisez un TextEditingController pour obtenir la valeur du champ de texte
        TextEditingController categorieController = TextEditingController();

        return AlertDialog(
          title: Text('Afficher les dépenses par catégorie'),
          content: Column(
            children: [
              TextField(
                controller: categorieController,
                decoration: InputDecoration(labelText: 'Catégorie'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Ajoutez le code pour afficher les dépenses par catégorie ici
                  String categorie = categorieController.text;
                  List<Transaction> depensesParCategorie = widget
                      .gestionnaireBudget
                      .afficherDepensesParCategorie(categorie);

                  // Afficher les dépenses dans la boîte de dialogue
                  for (Transaction transaction in depensesParCategorie) {
                    print(
                        "${transaction.description} - ${transaction.amount} - ${transaction.date}");
                  }
                },
                child: Text('Afficher'),
              ),
            ],
          ),
        );
      },
    );
  }
}
