import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers.dart/User_Transaction.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trans = Provider.of<UserTransaction>(context);
    final transdata = trans.transaction;
    return Container(
        child: transdata.isEmpty
            ? LayoutBuilder(builder: (cntx, constraints) {
                return Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.2,
                      child: Text(
                        'NO Transactions added yet ',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.7,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                          color: Mycolor1,
                        ))
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Mycolor1,
                    elevation: 6,
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Mycolor,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                                '\$ ${transdata[index].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Color.fromRGBO(42, 42, 42, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ),
                      ),
                      title: Text(
                        transdata[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transdata[index].dateTime)),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            trans.deleteTransaction(transdata[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transdata.length,
              ));
  }
}
