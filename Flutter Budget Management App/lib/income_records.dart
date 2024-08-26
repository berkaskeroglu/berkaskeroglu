import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mybudgetapp/edit_income.dart';
import 'package:mybudgetapp/start_api.dart';
import 'package:mybudgetapp/user_provider.dart';
import 'package:provider/provider.dart';

import 'income.dart';


class incomeRecordsWidget extends StatefulWidget {
  @override
  State<incomeRecordsWidget> createState() => _incomeRecordsWidgetState(incomes: []);
}

class _incomeRecordsWidgetState extends State<incomeRecordsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Income> incomes;
  _incomeRecordsWidgetState({required this.incomes});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
    
    
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final List<Income> incomes = userProvider.incomes;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF14181B),
              size: 30,
            ),
            iconSize: 60, 
            padding: EdgeInsets.all(0), 
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
          title: const Text(
            'Income History',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF14181B),
              fontSize: 18,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: IncomeListWidget(incomes: incomes),
      ),
    );
  }
}

List<Income> filterIncomesByMonth(List<Income> incomes, DateTime startDate, DateTime endDate) {
  return incomes.where((income) =>
    income.date.isAfter(startDate) && income.date.isBefore(endDate))
    .toList();
}

DateTime getStartOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getStartOfLastMonth(DateTime date) {
  DateTime firstDayOfMonth = getStartOfMonth(date);
  return DateTime(firstDayOfMonth.year, firstDayOfMonth.month - 1, 1);
}

DateTime getEndOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
}

class IncomeListWidget extends StatelessWidget {
  
  
  late List<Income> incomes;

  IncomeListWidget({required this.incomes});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    incomes = userProvider.incomes;
    DateTime now = DateTime.now();
    DateTime startOfMonth = getStartOfMonth(now);
    DateTime startOfLastMonth = getStartOfLastMonth(now);
    DateTime endOfLastMonth = getEndOfMonth(startOfLastMonth);

    List<Income> thisMonthIncomes = filterIncomesByMonth(incomes, startOfMonth, getEndOfMonth(now));
    List<Income> lastMonthIncomes = filterIncomesByMonth(incomes, startOfLastMonth, endOfLastMonth);

    return ListView(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text(
            'This Month',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF57636C),
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ...thisMonthIncomes.map((income) => _buildIncomeItem(context, income)).toList(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text(
            'Last Month',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF57636C),
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ...lastMonthIncomes.map((income) => _buildIncomeItem(context, income)).toList(),
      ],
    );
  }

  Widget _buildIncomeItem(BuildContext context, Income income) {
    return GestureDetector(
    onLongPress: () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditIncomePage(income: income),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () {
                    _deleteIncome(context, income);
                    
                  },
                ),
              ],
            ),
          );
        },
      );
    },
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 1),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFF1F4F8),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(0.0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    income.category,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF14181B),
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '${income.date.month}/${income.date.day}/${income.date.year}',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '\$${income.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 22,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}

Future<void> _deleteIncome(BuildContext context, Income income) async {
  final apiBaseUrl = getApiBaseUrl();
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final url = Uri.parse('$apiBaseUrl/api/Incomes/${income.id}');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      userProvider.removeIncome(income);
      print('Item deleted successfully');
    } else {
      print('Failed to delete item: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}