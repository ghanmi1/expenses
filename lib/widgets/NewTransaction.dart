import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:some_project/main.dart';

class NewTransaction extends StatefulWidget {
  final Function tx;

  NewTransaction(this.tx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontoller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _selectedDite;

  void _submitData() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    final titleEnter = _titlecontoller.text;
    final amountenter = double.parse(_amountcontroller.text);

    if (titleEnter.isEmpty || amountenter <= 0 || _selectedDite == null) {
      return;
    }
    widget.tx(titleEnter, amountenter, _selectedDite);
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
        _selectedDite = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Mycolor1,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 5,
            ),
            TextField(
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
              controller: _titlecontoller,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
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
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDite == null
                          ? 'No Date Chosen'
                          : 'Picked Date :${DateFormat.yMd().format(_selectedDite)}')),
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
                onPressed: _submitData,
                child: Text(
                  'Add transaction',
                  style:
                      TextStyle(color: colortext, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
