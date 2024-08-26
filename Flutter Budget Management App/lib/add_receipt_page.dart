import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'expense.dart';
import 'user_provider.dart';

class AddReceiptPage extends StatefulWidget {
  final double totalAmount;

  AddReceiptPage({required this.totalAmount});

  @override
  _AddReceiptPageState createState() => _AddReceiptPageState();
}

class _AddReceiptPageState extends State<AddReceiptPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _costController;
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _costController = TextEditingController(text: widget.totalAmount.toString());
  }

  @override
  void dispose() {
    _costController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      final DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
      final url = Uri.parse('http://10.0.2.2:5229/api/Expenses');
      final headers = {'Content-Type': 'application/json'};
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final body = jsonEncode({
        "uid": userProvider.uid,
        "expenseAmount": double.parse(_costController.text),
        "category": _categoryController.text,
        "date": date.toIso8601String(),
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Form submitted successfully');
          userProvider.addExpense(Expense(
            id: jsonDecode(response.body)['id'],
            uid: userProvider.uid!,
            amount: double.parse(_costController.text),
            category: _categoryController.text,
            date: date,
          ));
          Navigator.pop(context);
        } else {
          print('Failed to submit form: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cost';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
