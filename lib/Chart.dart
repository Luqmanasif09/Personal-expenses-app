import 'package:flutter/material.dart';
import 'Widget/Transaction.dart';
import 'package:intl/intl.dart';
import 'ChartsDraw.dart';

class Chart extends StatelessWidget {
  final List<Transaction> RecentTrans;

  Chart(this.RecentTrans);

  List<Map<String, Object>> get Group_Trans {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var total_sum = 0.0;

      for (var i = 0; i < RecentTrans.length; i++) {
        if (RecentTrans[i].Date.day == weekday.day &&
            RecentTrans[i].Date.month == weekday.month &&
            RecentTrans[i].Date.year == weekday.year) {
          total_sum += RecentTrans[i].Amount;
        }
      }
      return {
        'days': DateFormat.E().format(weekday).substring(0, 1),
        'amount': total_sum
      };
    }).reversed.toList();
  }

  double get maxSpend {
    return Group_Trans.fold(
      0.0,
      (sum, item) {
        return sum + double.parse(item['amount'].toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Group_Trans.map(
            (e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Drawchart(
                  e['days'].toString(),
                  double.parse(e['amount'].toString()),
                  maxSpend == 0.0 ? 0.0 : (e['amount'] as double) / maxSpend,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
