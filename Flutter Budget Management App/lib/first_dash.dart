import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mybudgetapp/balance_page.dart';
import 'package:mybudgetapp/expense.dart';
import 'package:mybudgetapp/expense_record.dart';
import 'package:mybudgetapp/income.dart';
import 'package:mybudgetapp/income_records.dart';
import 'package:mybudgetapp/user_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';


class firstDashWidget extends StatefulWidget {
  
  const firstDashWidget({super.key});
  

  @override
  State<firstDashWidget> createState() =>
      _firstDashWidgetState();
      
}

class _firstDashWidgetState extends State<firstDashWidget>
    with TickerProviderStateMixin {


  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    late List<Income> incomes;
    late List<Expense> expenses;

    final userProvider = Provider.of<UserProvider>(context);
    incomes = userProvider.incomes;
    expenses = userProvider.expenses;
    final totalIncome = incomes.fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense = expenses.fold(0.0, (sum, item) => sum + item.amount);
    final totalBalance = (totalIncome - totalExpense);


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  constraints: BoxConstraints(
                    maxWidth: 1370,
                  ),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome.',
                                        style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF15161E),
                                              fontSize: 24,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          'Here is the montly budget data.',
                                          style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF606A85),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(77, 200, 199, 212),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Color(0xFF15161E),
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.account_box,
                                            color: Color(0xFF15161E),
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 12),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.45,
                                        height: 120,
                                        constraints: BoxConstraints(
                                          maxWidth: 270,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0,
                                                2,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE5E7EB),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 16, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => incomeRecordsWidget(),
                                                ),
                                              );
                                            },
                                            child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 6, 0),
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .upLong,
                                                  color: Color(0xFF4A714B),
                                                  size: 30,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Total Incomes',
                                                      style: TextStyle(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            color: Color(
                                                                0xFF606A85),
                                                            fontSize: 13,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        4,
                                                                        0),
                                                            child: Text(
                                                              totalIncome.toStringAsFixed(2),
                                                              style: TextStyle(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: Color(
                                                                        0xFF15161E),
                                                                    fontSize:
                                                                        30,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
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
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 12),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.45,
                                        height: 120,
                                        constraints: BoxConstraints(
                                          maxWidth: 270,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0,
                                                2,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE5E7EB),
                                            width: 1,
                                          ),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => expenseRecordsWidget(),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 6, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .upLong,
                                                    color: Color(0xFFB22D2D),
                                                    size: 30,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Total Expenses',
                                                        style: TextStyle(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              color: Color(
                                                                  0xFF606A85),
                                                              fontSize: 13,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          4,
                                                                          0),
                                                              child: Text(
                                                                totalExpense.toStringAsFixed(2),
                                                                style: TextStyle(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: Color(
                                                                          0xFF15161E),
                                                                      fontSize:
                                                                          30,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
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
                                    ),
                                  ]
                                      .map((widget) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: widget,
                                      )).toList(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),

                          
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.sizeOf(context).width * 0.95, 
                                        constraints: BoxConstraints(
                                          maxWidth: () {
                                            final width = MediaQuery.sizeOf(context).width;
                                            if (width < 600.0) {
                                              return 700.0;
                                            } else if (width < 800.0) {
                                              return 900.0;
                                            } else if (width < 1200.0) {
                                              return 450.0;
                                            } else {
                                              return 1000.0;
                                            }
                                          }(),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0,
                                                2,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE5E7EB),
                                            width: 2,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 8),
                                                      child: Text(
                                                        'Budget Overview',
                                                        style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Color(
                                                                  0xFF15161E),
                                                              fontSize: 24,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Your Balance',
                                                                style: TextStyle(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      color: Color(
                                                                          0xFF606A85),
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              SizedBox(height: 4),
                                                              Text(
                                                                totalBalance.toStringAsFixed(2),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: Color(
                                                                          0xFF15161E),
                                                                      fontSize:
                                                                          36,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => BalancePageWidget(), 
                                                                ),
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Color(0xFF747D8C),
                                                              iconColor: Colors.white,
                                                              foregroundColor: Colors.white,
                                                              minimumSize: Size(100, 36),
                                                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                              elevation: 3,
                                                              textStyle: TextStyle(
                                                                fontFamily: 'Plus Jakarta Sans',
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            child: Text('Check Records'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 2,
                                                      thickness: 2,
                                                      color: Color(0xFFE5E7EB),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 12, 0, 12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Monthly Balance Goal',
                                                                  style: TextStyle(
                                                                        fontFamily:
                                                                            'Plus Jakarta Sans',
                                                                        color: Color(
                                                                            0xFF606A85),
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                SizedBox(height: 4),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                        (totalBalance / 10000*100).toStringAsFixed(2) + '%',
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            ' \$10,000',
                                                                        style: TextStyle(
                                                                              fontFamily: 'Plus Jakarta Sans',
                                                                              color: Color(0xFF606A85),
                                                                              fontSize: 16,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      )
                                                                    ],
                                                                    style: TextStyle(
                                                                          fontFamily:
                                                                              'Outfit',
                                                                          color:
                                                                              Color(0xFF15161E),
                                                                          fontSize:
                                                                              36,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: 4),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      LinearPercentIndicator(
                                                                    percent:
                                                                        0.64,
                                                                    width: 260,
                                                                    lineHeight:
                                                                        12,
                                                                    animation:
                                                                        true,
                                                                    animateFromLastPercent:
                                                                        true,
                                                                    progressColor:
                                                                        Color(
                                                                            0xFF4B4B4B),
                                                                    backgroundColor:
                                                                        Color(
                                                                            0x4D9489F5),
                                                                    barRadius: Radius
                                                                        .circular(
                                                                            16),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 4),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Remaining amount: ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              '\$' + (10000 - totalBalance).toStringAsFixed(2) ,
                                                                          style: TextStyle(
                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                color: Color(0xFF15161E),
                                                                                fontSize: 14,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        )
                                                                      ],
                                                                      style: TextStyle(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF606A85),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              print('Button pressed ...');
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.white,
                                                              iconColor: Color(0xFF15161E),
                                                              minimumSize: Size(80, 36),
                                                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                              side: BorderSide(
                                                                color: Color(0xFFE5E7EB),
                                                                width: 2,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                              elevation: 0,
                                                              textStyle: TextStyle(
                                                                fontFamily: 'Plus Jakarta Sans',
                                                                fontSize: 14,
                                                                letterSpacing: 0,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            child: Text('Edit Goal'),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 2,
                                                      thickness: 2,
                                                      color: Color(0xFFE5E7EB),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 12, 0, 0),
                                                      child: Text(
                                                        'Top Incomes/Expenses',
                                                        style: TextStyle(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              color: Color(
                                                                  0xFF606A85),
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                   // color: Color(0xFFF1F4F8)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 10.0),

                                                    child: Align(

                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                      Flexible(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1, 0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.28,
                                                            height: 119,
                                                            decoration: BoxDecoration(
                                                             // color: Color(0xFFF5F7F8),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          12),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xFFF92C35),
                                                                          Color(
                                                                              0xFFAD455C)
                                                                        ],
                                                                        stops: [
                                                                          0,
                                                                          1
                                                                        ],
                                                                        begin: AlignmentDirectional(
                                                                            0,
                                                                            -1),
                                                                        end: AlignmentDirectional(
                                                                            0,
                                                                            1),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFF5F6369),
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.shopping_bag,
                                                                      color: Color(0xFFF1F4F8),
                                                                      size: 24,
                                                                    ),

                                                                  ),
                                                                  SizedBox(height: 4),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            8,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Shopping',
                                                                      style: TextStyle(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF15161E),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 4),
                                                                  Text(
                                                                    '\$599',
                                                                    style: TextStyle(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              Color(0xFF606A85),
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1, 0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.28,
                                                            height: 119,
                                                            decoration: BoxDecoration(
                                                             // color: Color(0xFFF1F4F8),
                                                            ),

                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          12),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                        colors: [
                                                                          Color(0xFF33A527), 
                                                                          Color(0xFF39D2C0), 
                                                                        ],
                                                                        stops: [0, 1],
                                                                        begin: AlignmentDirectional.topStart,
                                                                        end: AlignmentDirectional.bottomEnd,
                                                                      ),
                                                                      shape: BoxShape.circle,
                                                                      border: Border.all(
                                                                        color: Color(0xFF5F6369),
                                                                        width: 2,
                                                                      ),
                                                                    ),

                                                                    child: Icon(
                                                                      Icons.shopping_bag,
                                                                      color: Color(0xFFF1F4F8),
                                                                      size: 24,
                                                                    ),

                                                                  ),
                                                                  SizedBox(height:4),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            8,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'From Dad',
                                                                      style: TextStyle(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF15161E),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height:4),
                                                                  Text(
                                                                    '\$599',
                                                                    style: TextStyle(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              Color(0xFF606A85),
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ],
                                                                    
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1, 0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.28,
                                                            height: 119,
                                                            decoration: BoxDecoration(
                                                             //color: Color(0xFFF1F4F8), 
                                                            ),

                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          12),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                        colors: [
                                                                          Color(0xFF33A527), 
                                                                          Color(0xFF39D2C0), 
                                                                        ],
                                                                        stops: [0, 1],
                                                                        begin: AlignmentDirectional.topStart,
                                                                        end: AlignmentDirectional.bottomEnd,
                                                                      ),
                                                                      shape: BoxShape.circle,
                                                                      border: Border.all(
                                                                        color: Color(0xFF5F6369),
                                                                        width: 2,
                                                                      ),
                                                                    ),

                                                                    child: Icon(
                                                                      Icons.shopping_bag,
                                                                      color: Color(0xFFF1F4F8),
                                                                      size: 24,
                                                                    ),

                                                                  ),
                                                                  SizedBox(height:4),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            8,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Salary',
                                                                      style: TextStyle(
                                                                            fontFamily:
                                                                                'Plus Jakarta Sans',
                                                                            color:
                                                                                Color(0xFF15161E),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height:4),
                                                                  Text(
                                                                    '\$599',
                                                                    style: TextStyle(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              Color(0xFF606A85),
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ],
                                                                    
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ),                                       
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width * 0.95, 
                                        height: 120,
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.sizeOf(context).width < 600
                                            ? 700.0
                                            : MediaQuery.sizeOf(context).width < 900
                                                ? 900.0
                                                : MediaQuery.sizeOf(context).width < 1200
                                                    ? 450.0
                                                    : 1000.0,

                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0,
                                                2,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE5E7EB),
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Your Car Goal:',
                                                      style: TextStyle(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            color: Color(
                                                                0xFF606A85),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      4, 4, 0),
                                                          child: Text(
                                                            '\$14,204',
                                                            style: TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF15161E),
                                                                  fontSize: 36,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              
                                                CircularPercentIndicator(
                                                  percent: 0.55,
                                                  radius: 45,
                                                  lineWidth: 8,
                                                  animation: true,
                                                  animateFromLastPercent: true,
                                                  progressColor:
                                                      Color(0xFF747D8C),
                                                  backgroundColor:
                                                      Color(0x4D9489F5),
                                                  center: Text(
                                                    '55%',
                                                    style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF15161E),
                                                          fontSize: 24,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                                  // .divide(SizedBox(width: 16))
                                  // .addToStart(SizedBox(width: 16))
                                  // .addToEnd(SizedBox(width: 16)),
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
