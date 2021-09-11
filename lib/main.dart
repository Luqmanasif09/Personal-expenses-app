import 'package:flutter/material.dart';
import 'Widget/Transaction.dart';
import 'package:intl/intl.dart';
import 'NewTrans.dart';
import 'Transaction_list.dart';
import 'Chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Personal(),
      title: 'Expenses',
      theme: ThemeData(
        errorColor: Colors.red,
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.purple, fontSize: 20))),
      ),
    );
  }
}

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final List<Transaction> Trans = [
    Transaction(DateTime.now().toString(), 'Shoes', 56.365, DateTime.now()),
    Transaction(DateTime.now().toString(), 'Grocery', 814.36, DateTime.now())
  ];

  void Start_Button(BuildContext Ctx) {
    showModalBottomSheet(
        context: Ctx,
        builder: (_) {
          return NewTrans(Add_Transaction);
        });
  }

  void Add_Transaction(String T, double A, DateTime D) {
    final new_tx = Transaction(DateTime.now().toString(), T, A, D);

    setState(() {
      Trans.add(
        new_tx,
      );
    });
  }

  void Del(String id) {
    setState(() {
      Trans.removeWhere((element) => element.Id == id);
    });
  }

  bool _Check = false;

  List<Transaction> get Recent_Trans {
    return Trans.where(
      (tx) {
        return tx.Date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(
          onPressed: () => Start_Button(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                Switch(
                    value: _Check,
                    onChanged: (value) {
                      setState(() {
                        _Check = value;
                      });
                    })
              ],
            ),
            _Check
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        1,
                    child: Chart(Recent_Trans),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransList(Trans, Del),
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Start_Button(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
