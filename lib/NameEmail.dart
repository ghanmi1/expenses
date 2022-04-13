import 'package:flutter/material.dart';
import 'package:some_project/main.dart';

class NameEmail extends StatefulWidget {
  @override
  State<NameEmail> createState() => _NameEmailState();
}

class _NameEmailState extends State<NameEmail> {
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                labelStyle: TextStyle(color: colortext),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: Mycolor1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              controller: _namecontroller,
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Enter Email ',
                labelStyle: TextStyle(color: colortext),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: Mycolor1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              controller: _emailcontroller,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Mycolor1,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  if (_namecontroller.text.isEmpty ||
                      _emailcontroller.text.isEmpty) {
                    return;
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  }
                },
                child: Text(
                  'Submit',
                  style:
                      TextStyle(color: colortext, fontWeight: FontWeight.bold),
                ))
          ],
        );
      },
    ));
  }
}
