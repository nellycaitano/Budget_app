import 'package:flutter/material.dart';
import 'package:app/gestion_budget.dart';
import 'package:app/navigate.dart';

class Mytransactions extends StatelessWidget {
  final GestionnaireBudget gestionnaireBudget;

  Mytransactions({required this.gestionnaireBudget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapport des Transactions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
        children: [
          Image.asset(
            'images/depenses.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
         /* SizedBox(height: 20),
          Text(
            'Budget : ${gestionnaireBudget.budget.amount} FCFA',
            style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w200),
          ),*/
        ],
      ),
    ),
          SizedBox(height: 20),
           Expanded(
            child: ListView.builder(
              itemCount: gestionnaireBudget.transactions.length,
              itemBuilder: (context, index) {
                final transaction = gestionnaireBudget.transactions[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      '${transaction.description}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Montant: ${transaction.amount} FCFA\nDate: ${transaction.date}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
