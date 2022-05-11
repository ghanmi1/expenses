import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:some_project/providers.dart/User_Transaction.dart';
import 'package:some_project/widgets/NewTransaction.dart';
import 'package:some_project/widgets/transaction_list.dart';
import '../widgets/chart.dart';
import '../main.dart';

class OverViewScreen extends StatefulWidget {
  static const routename = '/OverviewScreen';
  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  final _form = GlobalKey<FormState>();

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (() {}),
            child: NewTransaction(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final trans = Provider.of<UserTransaction>(context);
    final appbar = AppBar(
        backgroundColor: const Color.fromRGBO(42, 42, 42, 1),
        elevation: 0,
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: _form,
              child: Container(
                height: constraints.maxHeight * 0.6,
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 35,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      filled: true,
                      fillColor: Mycolor1,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintStyle: new TextStyle(color: Colors.black38),
                      hintText: "Search"),
                ),
              ),
            );
          },
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
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
                  child: Chart(trans.recentTransactions)),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.75,
                child: TransactionList(),
              )
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
