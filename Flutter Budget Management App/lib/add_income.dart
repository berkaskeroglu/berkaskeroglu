import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybudgetapp/income.dart';
import 'package:mybudgetapp/user_provider.dart';
import 'package:provider/provider.dart';

class AddIncomePage extends StatefulWidget {
  @override
  _AddIncomePageState createState() => _AddIncomePageState();
  
}

class _AddIncomePageState extends State<AddIncomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _incomeController;
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _incomeController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if(_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      final DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
      final url = Uri.parse('http://10.0.2.2:5229/api/Incomes');
      final headers = {'Content-Type': 'application/json'};
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final body = jsonEncode({
        "uid": userProvider.uid,
        "incomeAmount": double.parse(_incomeController.text),
        "category": _categoryController.text,
        "date": date.toIso8601String(),
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Form submitted successfully');
          userProvider.addIncome(Income(
            id: jsonDecode(response.body)['id'],
            uid: userProvider.uid!,
            amount: double.parse(_incomeController.text),
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
      appBar: AppBar (
        title: Text("Add Income"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _incomeController,
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
        )
      )
    );
  }
  
}