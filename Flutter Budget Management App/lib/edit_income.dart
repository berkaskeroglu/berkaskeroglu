import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'income.dart';
import 'user_provider.dart';

class EditIncomePage extends StatefulWidget {
  final Income income;

  EditIncomePage({required this.income});

  @override
  _EditIncomePageState createState() => _EditIncomePageState();
}

class _EditIncomePageState extends State<EditIncomePage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.income.amount.toString());
    _categoryController = TextEditingController(text: widget.income.category);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _saveIncome() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final DateTime now = DateTime.now();
    final DateTime saveDate = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

    Income updatedIncome = Income(
      id: widget.income.id,
      uid: widget.income.uid,
      category: _categoryController.text,
      amount: double.parse(_amountController.text),
      date: saveDate,
    );

    final url = Uri.parse('http://10.0.2.2:5229/api/Expenses/${widget.income.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "id": updatedIncome.id,
      "uid": updatedIncome.uid,
      "incomeAmount": updatedIncome.amount,
      "category": updatedIncome.category,
      "date": updatedIncome.date.toIso8601String(),
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        userProvider.updateIncome(updatedIncome);
        Navigator.pop(context);
      } else {
        print('Failed to update income: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Income'),
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
              onPressed: _saveIncome,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
