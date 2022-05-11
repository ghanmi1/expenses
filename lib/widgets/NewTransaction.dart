import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:some_project/providers.dart/User_Transaction.dart';

import '../main.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _form = GlobalKey<FormState>();
  var _newtransaction =
      Transaction(amount: 0, dateTime: DateTime.now(), id: null, title: '');

  void _saveform() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    Provider.of<UserTransaction>(context, listen: false)
        .addTransaction(_newtransaction);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _newtransaction.dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Card(
        color: Mycolor1,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'enter title',
                  labelStyle: TextStyle(color: colortext),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  filled: true,
                  fillColor: Mycolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please provide a title ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newtransaction = Transaction(
                      amount: _newtransaction.amount,
                      id: _newtransaction.id,
                      dateTime: _newtransaction.dateTime,
                      title: value);
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'enter amount',
                  labelStyle: TextStyle(color: colortext),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  filled: true,
                  fillColor: Mycolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please provide a price ';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number ';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than 0 ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newtransaction = Transaction(
                      amount: double.parse(value),
                      id: _newtransaction.id,
                      dateTime: _newtransaction.dateTime,
                      title: _newtransaction.title);
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_newtransaction.dateTime == null
                            ? 'No Date Chosen'
                            : 'Picked Date :${DateFormat.yMd().format(_newtransaction.dateTime)}')),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colortext,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                  color: Mycolor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onPressed: _saveform,
                  child: Text(
                    'Add transaction',
                    style: TextStyle(
                        color: colortext, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
