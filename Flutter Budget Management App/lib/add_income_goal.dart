import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybudgetapp/user_provider.dart';
import 'package:provider/provider.dart';

import 'income_goal.dart';

class AddIncomeGoalPage extends StatefulWidget {
  @override
  _AddIncomeGoalPageState createState() => _AddIncomeGoalPageState();
  
}

class _AddIncomeGoalPageState extends State<AddIncomeGoalPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _incomeGoalController;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _incomeGoalController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    _incomeGoalController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if(_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      final DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
      final url = Uri.parse('http://10.0.2.2:5229/api/IncomeGoals');
      final headers = {'Content-Type': 'application/json'};
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final body = jsonEncode({
        "uid": userProvider.uid,
        "goal": double.parse(_incomeGoalController.text),
        "date": _dateController.text,
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Form submitted successfully');
          userProvider.addIncomeGoal(IncomeGoal(
            id: jsonDecode(response.body)['id'],
            uid: userProvider.uid!,
            amount: double.parse(_incomeGoalController.text),
            date: _dateController.text,
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
        title: Text("Add Income Goal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _incomeGoalController,
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
                controller: _dateController,
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