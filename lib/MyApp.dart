import 'package:flutter/material.dart';
import 'package:myapp/TransactionList.dart';
import 'transaction.dart';
//you can define your own Widget
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  Transaction _transaction = Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
  List<Transaction> _transactions = <Transaction>[];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  void _insertTransaction(){
    if(_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN){
      return ;
    }
    _transaction.createdDate = DateTime.now();
    _transactions = [..._transactions, _transaction];
    _transaction = Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
    _contentController.text = '';
    _amountController.text = '';
  }
  void _onButtonShowModalSheet(){
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Content'),
                  controller: _contentController,
                  onChanged: (text) {
                    setState(() {
                      _transaction.content = text;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Amount(money)'),
                  controller: _amountController,
                  onChanged: (text){
                    setState(() {
                      _transaction.amount = double.tryParse(text) ?? 0;//if error, value = 0
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: SizedBox(child:
                    RaisedButton(
                      child: Text('Save',style: TextStyle(fontSize: 16,color: Colors.white),),
                      color: Colors.greenAccent,
                      onPressed: (){
                        setState(() {
                          this._insertTransaction();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                      height: 50,)),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(child: SizedBox(child:
                    RaisedButton(
                      child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white),),
                      color: Colors.pinkAccent,
                      onPressed: (){

                        Navigator.of(context).pop();
                      },
                    ),
                      height: 50,))
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "This is a StatefulWidget",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Transaction manager', style: TextStyle(color: Colors.black,),),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
                onPressed: (){
                  this._onButtonShowModalSheet();
                },
                icon: Icon(Icons.add)
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add transcation',
          child: Icon(Icons.add),
          onPressed: (){
            this._onButtonShowModalSheet();
          },
        ),
        key: _scaffoldKey,
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                ButtonTheme(
                    height: 50,
                    child: FlatButton(onPressed: (){
                      this._onButtonShowModalSheet();
                    },
                      child: Text('Insert Transaction', style: const TextStyle(fontSize:18),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    )),
                TransactionList(transactions: _transactions)
              ],
            ),
          ),
      ),
    ));
  }
}
