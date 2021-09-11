import 'package:flutter/material.dart';
import 'Widget/Transaction.dart';
import 'package:intl/intl.dart';

class TransList extends StatelessWidget {
  final List<Transaction> Trans;
  final Function Delete;
  TransList(this.Trans, this.Delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: EdgeInsets.all(10),
      child: Trans.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text('No Transaction added yet!!.',
                        style: Theme.of(context).textTheme.title),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\$${Trans[index].Amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      Trans[index].title.toString(),
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(Trans[index].Date),
                      style: Theme.of(context).textTheme.title,
                    ),
                    trailing: IconButton(
                      onPressed: () => Delete(Trans[index].Id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: Trans.length,
            ),
    );
  }
}
