import 'dart:convert';
import 'dart:io' show Platform; // Platform kontrolü için

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'expense.dart';
import 'income.dart';
import 'user_provider.dart';

String getApiBaseUrl() {
  if (kIsWeb) {
    return 'http://localhost:5229';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:5229';
  } else {
    return 'http://localhost:5229'; // Diğer platformlar için localhost kullanımı
  }
}


Future<void> fetchExpensesByUid(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final uid = userProvider.uid;

  if (uid == null) {
    print('UID is null, cannot fetch expenses.');
    return;
  }

  final apiBaseUrl = getApiBaseUrl();

  try {
    final response = await http.get(Uri.parse('$apiBaseUrl/api/Expenses/uid/$uid'));

    if (response.statusCode == 200) {
      final List<dynamic> expenseJson = json.decode(response.body);
      print('Fetched Expenses: $expenseJson');  
      List<Expense> expenses = expenseJson.map((json) => Expense.fromJson(json)).toList();
      userProvider.setExpenses(expenses);
    } else {
      print('Failed to load expenses. Status code: ${response.statusCode}, Response: ${response.body}, uid: $uid');
      throw Exception('Failed to load expenses');
    }
  } catch (error) {
    print('Error fetching expenses: $error');
  }
}


Future<void> setUserAndFetchExpenses(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userProvider.setUser(
      user.uid,
      user.email ?? '',
      user.displayName ?? '',
      user.photoURL ?? '',
    );
    await fetchExpensesByUid(context);
  }
}

Future<void> fetchIncomesByUid(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final uid = userProvider.uid;

  if (uid == null) {
    print('UID is null, cannot fetch incomes.');
    return;
  }
  final apiBaseUrl = getApiBaseUrl();

  try {
    final response = await http.get(Uri.parse('$apiBaseUrl/api/Incomes/uid/$uid'));

    if (response.statusCode == 200) {
      final List<dynamic> incomeJson = json.decode(response.body);
      print('Fetched Incomes: $incomeJson');
      List<Income> incomes = incomeJson.map((json) => Income.fromJson(json)).toList();
      userProvider.setIncomes(incomes);
    } else {
      print('Failed to load incomes. Status code: ${response.statusCode}, Response: ${response.body}, uid: $uid');
      throw Exception('Failed to load incomes');
    }
  } catch (error) {
    print('Error fetching incomes : $error');
  }
}


Future<void> setUserAndFetchIncomes(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userProvider.setUser(
      user.uid,
      user.email ?? '',
      user.displayName ?? '',
      user.photoURL ?? '',
    );
    await fetchIncomesByUid(context);
  }
}

Future<void> _deleteExpense(BuildContext context, dynamic item) async {
  final apiBaseUrl = getApiBaseUrl();
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final url = Uri.parse('$apiBaseUrl/api/Expenses/${item.id}');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      userProvider.removeExpense(item);
      print('Item deleted successfully');
    } else {
      print('Failed to delete item: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}

Future<void> _deleteIncome(BuildContext context, dynamic item) async {
  final apiBaseUrl = getApiBaseUrl();
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final url = Uri.parse('$apiBaseUrl/api/Incomes/${item.id}');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      userProvider.removeIncome(item);
      print('Item deleted successfully');
    } else {
      print('Failed to delete item: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
