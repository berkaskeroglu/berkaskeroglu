import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'expense.dart';
import 'user_provider.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;

  EditExpensePage({required this.expense});

  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.expense.amount.toString());
    _categoryController = TextEditingController(text: widget.expense.category);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _saveExpense() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final DateTime now = DateTime.now();
    final DateTime saveDate = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

    Expense updatedExpense = Expense(
      id: widget.expense.id,
      uid: widget.expense.uid,
      category: _categoryController.text,
      amount: double.parse(_amountController.text),
      date: saveDate,
    );

    final url = Uri.parse('http://10.0.2.2:5229/api/Expenses/${widget.expense.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "id": updatedExpense.id,
      "uid": updatedExpense.uid,
      "expenseAmount": updatedExpense.amount,
      "category": updatedExpense.category,
      "date": updatedExpense.date.toIso8601String(),
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        userProvider.updateExpense(updatedExpense);
        Navigator.pop(context);
      } else {
        print('Failed to update expense: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveExpense,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
