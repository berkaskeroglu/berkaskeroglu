import 'package:flutter/material.dart';
import 'package:mybudgetapp/income.dart';

import 'expense.dart';
import 'income_goal.dart';


class UserProvider with ChangeNotifier {
  String? _uid;
  String? _email;
  String? _displayName;
  String? _photoURL;
  List<Expense> _expenses = [];
  List<Income> _incomes = [];
  List<IncomeGoal> _incomeGoals = [];

  String? get uid => _uid;
  String? get email => _email;
  String? get displayName => _displayName;
  String? get photoURL => _photoURL;
  List<Expense> get expenses => _expenses;
  List<Income> get incomes => _incomes;
  List<IncomeGoal> get incomeGoals => _incomeGoals;

  void setUser(String uid, String email, String displayName, String photoURL) {
    _uid = uid;
    _email = email;
    _displayName = displayName;
    _photoURL = photoURL;
    notifyListeners();
  }

  void calculateIncomeValuesSum() {
    _calculateIncomeValuesSum();
    notifyListeners();
  }

  void calculateExpenseValuesSum() {
    _calculateExpenseValuesSum();
    notifyListeners();
  }

  void clearUser() {
    _uid = null;
    _email = null;
    _displayName = null;
    _photoURL = null;
    _expenses = [];
    _incomes = [];
    _incomeGoals = [];
    notifyListeners();
  }

  void setExpenses(List<Expense> expenses) {
    _expenses = expenses;
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _expenses.removeWhere((e) => e.id == expense.id);
    notifyListeners();
  }

  void updateExpense(Expense updatedExpense) {
    int index = _expenses.indexWhere((expense) => expense.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  void addExpense(Expense expense) {
    expenses.add(expense);
    notifyListeners();
  }

  void _calculateExpenseSums() {
    Map<String, double> categorySums = {};
    for (var expense in _expenses) {
      if(!categorySums.containsKey(expense.category)) {
        categorySums[expense.category] = 0;
      }
      categorySums[expense.category] = categorySums[expense.category]! + expense.amount;
    }
    for(var expense in _expenses) {
      expense.expenseSum = categorySums[expense.category]!;
    }
  }

  void setIncomes(List<Income> incomes) {
    _incomes = incomes;
    notifyListeners();
  }
  void removeIncome(Income income) {
    _incomes.removeWhere((i) => i.id == income.id);
    notifyListeners();
  }

  void updateIncome(Income updatedIncome) {
    int index = _incomes.indexWhere((income) => income.id == updatedIncome.id);
    if (index != -1) {
      _incomes[index] = updatedIncome;
      notifyListeners();
    }
  }
  void addIncome(Income income) {
    incomes.add(income);
    notifyListeners();
  }

  void _calculateIncomeSums() {
    Map<String, double> categoryIncomeSums = {};
    for (var income in _incomes) {
      if(!categoryIncomeSums.containsKey(income.category)) {
        categoryIncomeSums[income.category] = 0;
      }
      categoryIncomeSums[income.category] = categoryIncomeSums[income.category]! + income.amount;
    }
    for(var income in _incomes) {
      income.incomeSum = categoryIncomeSums[income.category]!;
    }
  }

  void _calculateIncomeValuesSum() {
    double incomeValuesSum = 0;
    for (var income in _incomes) {
      incomeValuesSum += income.amount;
    }
    _incomeValuesSum = incomeValuesSum;
  }

  double _incomeValuesSum = 0;

  double get incomeValuesSum => _incomeValuesSum;

  void _calculateExpenseValuesSum() {
    double expenseValuesSum = 0;
    for (var expense in _expenses) {
      expenseValuesSum += expense.amount;
    }
    _expenseValuesSum = expenseValuesSum;
  }

  double _expenseValuesSum = 0;

  double get expenseValuesSum => _expenseValuesSum;

  List<Income> getLastFiveIncomes() {
    final sortedIncomes = List<Income>.from(_incomes);
    sortedIncomes.sort((a, b) => b.date.compareTo(a.date));
    return sortedIncomes.take(5).toList();
  }

  List<Expense> getLastFiveExpenses() {
    final sortedExpenses = List<Expense>.from(_expenses);
    sortedExpenses.sort((a, b) => b.date.compareTo(a.date));
    return sortedExpenses.take(5).toList();
  }

  void setIncomeGoals(List<IncomeGoal> incomeGoals) {
    _incomeGoals = incomeGoals;
    notifyListeners();
  }
  void removeIncomeGoal(IncomeGoal incomeGoal) {
    _incomeGoals.removeWhere((i) => i.id == incomeGoal.id);
    notifyListeners();
  }

  void updateIncomeGoal(IncomeGoal updatedIncomeGoal) {
    int index = _incomeGoals.indexWhere((incomeGoal) => incomeGoal.id == updatedIncomeGoal.id);
    if (index != -1) {
      _incomeGoals[index] = updatedIncomeGoal;
      notifyListeners();
    }
  }
  void addIncomeGoal(IncomeGoal incomeGoal) {
    incomeGoals.add(incomeGoal);
    notifyListeners();
  }

  
  double calculateBalance() {
    double expenseSums = expenseValuesSum;
    double incomeSums = incomeValuesSum;
    double balanceSum = incomeSums - expenseSums;
    // _balanceSum = balanceSum;
    return balanceSum;
  }
  //double _balanceSum = 0;
  double get balanceSum => calculateBalance();
}
