import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './SplashScreen.dart';
import './widgets/NewTransaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personal expenses',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(42, 42, 42, 1),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(25, 24, 24, 1),
            )),
      ),
      home: SplashScreen(),
    );
  }
}

const Mycolor1 = Color.fromRGBO(230, 245, 252, 1);
const Mycolor = Color.fromRGBO(230, 220, 245, 1);
const colortext = Color.fromRGBO(25, 24, 24, 1);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchcontroller = TextEditingController();
  final List<Transaction> _userTransaction = [
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't1', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't2', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't1', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't2', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't1', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't2', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't1', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't2', title: 'new Tshirt'),
  ];

  List<Transaction> _transactionFilter = [];

  @override
  initState() {
    _transactionFilter = _userTransaction;
    super.initState();
  }

  List<Transaction> get _recentTransactions {
    return _transactionFilter.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    final newTrx = Transaction(
        amount: amount,
        dateTime: chosenDate,
        id: DateTime.now().toString(),
        title: title);

    setState(() {
      _userTransaction.insert(0, newTrx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (() {}),
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _filterTransaction(String value) {
    final suggestions = _userTransaction.where((i) {
      return i.title.contains(value);
    }).toList();
    setState(() {
      _transactionFilter = suggestions;
    });
  }

  void _filterMonth() {
    final suggestions = _userTransaction.where((i) {
      return i.dateTime.isAfter(DateTime.now().subtract(Duration(days: 31)));
    }).toList();
    setState(() {
      _transactionFilter = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
        backgroundColor: const Color.fromRGBO(42, 42, 42, 1),
        elevation: 0,
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  width: constraints.maxWidth * 0.15,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: constraints.maxWidth * 0.8,
                  margin: EdgeInsets.only(
                    top: 35,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    controller: _searchcontroller,
                    onChanged: _filterTransaction,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        filled: true,
                        fillColor: Mycolor1,
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintStyle: new TextStyle(color: Colors.black38),
                        hintText: "Search"),
                  ),
                ),
              ],
            );
          },
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu ',
                style: Theme.of(context).textTheme.headline6,
              ),
              decoration: BoxDecoration(color: Mycolor1),
            ),
            ListTile(
              title: Text('The Most Expenses'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
            ),
            ListTile(
              title: Text('The Last Month '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.25,
                  child: Chart(_recentTransactions)),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.75,
                  child:
                      TransactionList(_transactionFilter, _deleteTransaction))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Mycolor,
        child: Icon(
          Icons.add,
          color: colortext,
        ),
        onPressed: (() => _startNewTransaction(context)),
      ),
    );
  }
}
