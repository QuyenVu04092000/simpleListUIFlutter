import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';
class TransactionList extends StatelessWidget{
  List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index){
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: (index - 1) % 2 == 0 ? Colors.green : Colors.teal,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:10)),
                  Text(transactions[index].content,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white
                    ),),
                  Text('Date: ${DateFormat.yMd().format(transactions[index].createdDate)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),),
                  Padding(padding: EdgeInsets.only(bottom:10)),
                ],
              ),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text('${transactions[index].amount}\$',
                            style: TextStyle(fontSize: 18, color: Colors.white)
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 2,style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10))
                    ],
                  )
                )
            ],
          ),
          // child: ListTile(
          //   leading: const Icon(Icons.access_alarm),
          //   title: Text(transactions[index].content,
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18,
          //         color: Colors.white
          //     ),),
          //   subtitle: Text('Price: ${transactions[index].amount}',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 18
          //     ),),
          //   onTap: () {
          //
          //   },
          // ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: transactions.length.toDouble() * 80,
      child: _buildListView()
    );
  }
}