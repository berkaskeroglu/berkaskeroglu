import 'package:flutter/material.dart';
import 'package:mybudgetapp/user_provider.dart';
import 'package:provider/provider.dart';

import 'expense.dart';
import 'income.dart';


class BalancePageWidget extends StatefulWidget {
  BalancePageWidget({super.key});
  final List<Income> incomes = [];
  final List<Expense> expenses = [];

  @override
  State<BalancePageWidget> createState() => _BalancePageWidgetState(expenses: [], incomes: []);
}

class _BalancePageWidgetState extends State<BalancePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Income> incomes;
  late  List<Expense> expenses;
  _BalancePageWidgetState({required this.expenses, required this.incomes});
  

  @override
  void initState() {
    super.initState();
    expenses = [];
    incomes = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final List<Income> incomes = userProvider.incomes;
    final List<Expense> expenses = userProvider.expenses;
    final List<Map<String, dynamic>> combinedList = [
      ...incomes.map((i) => {'type': 'income', 'category': i.category, 'amount': i.amount, 'date': i.date}),
      ...expenses.map((e) => {'type': 'expense', 'category': e.category, 'amount': e.amount, 'date': e.date}),
    ];

    combinedList.sort((a, b) => b['date'].compareTo(a['date']));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF4B4B4B),
        automaticallyImplyLeading: false,
        leading: IconButton(
          // borderColor: Colors.transparent,
          // borderRadius: 30,
          // buttonSize: 46,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 46,
          color: Colors.transparent,
        ),
        
        
        title: Text(
          'Balance Detail',
          style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4B4B4B),
                      Color(0xFF5B5B5B),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x32171717),
                      offset: Offset(
                        0.0,
                        2,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Balance.',
                                  style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                        fontSize: 36,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Text(
                                '\$25,000',
                                
                                //'${userProvider.balanceSum}',
                                style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 36,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 4),
                              child: Text(
                                'this month',
                                style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xB3FFFFFF),
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'new month in 3 days',
                              style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child: Text(
                                    'Total Spent',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xB3FFFFFF),
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ),
                                Text(
                                  '\$2,502',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                        fontSize: 24,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 500,
                  child: ListView.builder(
                  itemCount: combinedList.length,
                  itemBuilder: (context, index) {
                    final item = combinedList[index];
                    final type = item['type'] as String;
                    final category = item['category'] as String;
                    final amount = item['amount'] as double;
                    final date = item['date'] as DateTime;

                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x35000000),
                              offset: Offset(0.0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFF1F4F8),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: type == 'income' ? Color(0x4C33A527) : Color(0x4CFF4C4C),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      type == 'income' ? Icons.add_circle_outline : Icons.remove_circle_outline,
                                      color: type == 'income' ? Color(0xFF50CE41) : Color(0xFFCE5050),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                        child: Text(
                                          type == 'income' ? 'Income' : 'Expense',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${amount.toStringAsFixed(2)}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF14181B),
                                        fontSize: 22,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                      child: Text(
                                        '${date.day}-${date.month}-${date.year}',
                                        textAlign: TextAlign.end,
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    
    );
  }
}
