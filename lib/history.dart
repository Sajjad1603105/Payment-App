import 'package:flutter/material.dart';
import 'package:payment_app/database.dart';
import 'package:payment_app/menubar.dart';
import 'package:provider/provider.dart';
import 'database.dart';

// ignore: must_be_immutable
class History extends StatelessWidget{
    final String uid;
    History({ this.uid });

    
    Widget build(context){
           final uid = Provider.of<String>(context) ?? '';
          return StreamProvider<List<PayInfo>>.value(
              value: DatabaseService(uid: uid).payments,
              child: Scaffold(         
                  drawer: NavDrawer(),
                  backgroundColor: Colors.black,
                  body: HistoryScreen(),
                  resizeToAvoidBottomInset: false,
                  resizeToAvoidBottomPadding: true,
                  appBar: AppBar(
                  title: Text('            Payment History' , style: TextStyle(color: Colors.blueAccent,
                  fontWeight: FontWeight.bold ) ),
                  backgroundColor: Colors.grey[900],
                  elevation: 0.0,
 
                ),
            ),
        );
    }
}

class HistoryScreen extends StatefulWidget{
  createState() {
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen>{ 
    Widget build(context){
        final paidDocs = Provider.of<List<PayInfo>>(context) ?? [];
        paidDocs.sort((a, b) => b.time.compareTo(a.time));
        return ListView.builder(
            itemCount: paidDocs.length,
            itemBuilder: (context, index) {
            return DocTile(doc: paidDocs[index]);
            }
        );
    }
}

class DocTile extends StatelessWidget {

  final PayInfo doc;
  DocTile({ this.doc });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.blueGrey,
        child: ListTile(
          title: Text('Paid Tk ${doc.amount}', style: TextStyle(color: Colors.white,fontSize: 20)),
          subtitle: Text('${doc.time} ',  style: TextStyle(color: Colors.white,fontSize: 17)),
        ),
      ),
    );
  }
}
