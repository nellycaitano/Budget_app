


class Budget {
  double amount;

  Budget(this.amount);
}

class Transaction {
  String description;
  String category;
  double amount;
  DateTime date;

  Transaction(this.description, this.category, this.amount, this.date);
}

class GestionnaireBudget {
  Budget budget;
  List<Transaction> transactions = [];

  GestionnaireBudget(double initialBudget) : budget = Budget(initialBudget);

  void enregistrerDepense(
      String description, String category, double amount, DateTime date) {
    Transaction transaction = Transaction(description, category, amount, date);
    transactions.add(transaction);
    budget.amount -= amount;
  }
  
void ajouterArgent(double amount) {
  budget.amount += amount;
}


  void afficherBudgetRestant() {
    print("Reste du budget : ${budget.amount}");
  }

  void afficherToutesDepenses() {
    if (transactions.isEmpty) {
      print("Aucune dépense enregistrée.");
    } else {
      print("Liste de toutes les dépenses :");
      for (Transaction transaction in transactions) {
        print(
            "${transaction.description} - ${transaction.amount} - ${transaction.date}");
      }
    }
  }

   List<Transaction> afficherDepensesParCategorie(String category) {
    List<Transaction> depensesParCategorie = transactions
        .where((transaction) => transaction.category == category)
        .toList();
    return depensesParCategorie;
  }


  
}


