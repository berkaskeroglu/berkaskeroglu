import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mybudgetapp/add_income_goal.dart';
import 'package:mybudgetapp/balance_page.dart';
import 'package:mybudgetapp/goal.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'first_dash.dart';
import 'login_page.dart';
import 'start_api.dart';
import 'user_provider.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  auth = FirebaseAuth.instanceFor(app: app);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? const MainScreen()
          : const LoginPage(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    firstDashWidget(),
    GoalWidget(),
    //expenseRecordsWidget(),
    AddIncomeGoalPage(),
    //HomePage(), bu sayfada api bilgileri var
    //incomeRecordsWidget(),
    BalancePageWidget(),
    
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setUserAndFetchExpenses(context);
      setUserAndFetchIncomes(context);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'B',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'C',
          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
