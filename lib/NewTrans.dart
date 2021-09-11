import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrans extends StatefulWidget {
  final Function Add;
  NewTrans(this.Add);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final Title = TextEditingController();
  final Amount = TextEditingController();
  DateTime? D;

  void DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      D = value;
    });
  }

  void _Submit() {
    String T = Title.text;
    double A = double.parse(Amount.text);

    if (T.isEmpty || A <= 0 || D == null) {
      return;
    }

    widget.Add(T, A, D);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: Title,
            onSubmitted: (_) => _Submit,
            decoration: InputDecoration(
                labelText: 'Title',
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          Padding(padding: EdgeInsets.all(10)),
          TextField(
            keyboardType: TextInputType.number,
            controller: Amount,
            onSubmitted: (_) => _Submit,
            decoration: InputDecoration(
              labelText: 'Amount',
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                D == null ? 'No Date Chosen' : (DateFormat.yMd(D).toString()),
                style: TextStyle(fontSize: 15),
              ),
              FlatButton(
                onPressed: DatePicker,
                child: Text(
                  'Select Date',
                ),
              ),
              Padding(padding: EdgeInsets.all(15)),
              RaisedButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: _Submit,
                color: Colors.purple,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
