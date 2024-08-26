import 'package:flutter/material.dart';



class GoalWidget extends StatefulWidget {
  const GoalWidget({super.key});

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF15161E),
              size: 30,
            ),
            iconSize: 60,
          ),
          title: Text(
            'Monthly Goal',
            style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF15161E),
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Align(
          alignment: AlignmentDirectional(0, -1),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 570,
            ),
            decoration: BoxDecoration(),
            child: Align(
              alignment: AlignmentDirectional(0, -1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                      child: Text(
                        'June\'s Goal',
                        style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF606A85),
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Text(
                        '\$5,201.02',
                        style:
                            TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF15161E),
                                  fontSize: 57,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF15161E),
                              textStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0,
                              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              side: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(0, 40), 
                            ),
                            child: Text('Delete Goal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6F61EF),
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3,
                              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(0, 40),
                            ),
                            child: Text('Edit'),
                          ),
                        ].map((widget) => Padding(
                          padding: EdgeInsets.only(right: 16), 
                          child: widget,
                        )).toList(),
                      ),
                    

                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Container(
                            width: 100,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'April\'s Goal',
                                        style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          'Successful',
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
                                  Text(
                                    '\$5,212.00',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF15161E),
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Container(
                            width: 100,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'May\'s Goal',
                                        style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          'Failed',
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
                                  Text(
                                    '\$2,502.20',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF15161E),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}