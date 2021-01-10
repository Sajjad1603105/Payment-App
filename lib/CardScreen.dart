import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:payment_app/success.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'loading.dart';
import 'menubar.dart';

class Cards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
          final uid = Provider.of<String>(context) ?? '';
            return StreamProvider<UserData>.value(
              value: DatabaseService(uid: uid).userData ,
              child: Scaffold(
                  drawer: NavDrawer(),
                  body: CardScreen(),
                  resizeToAvoidBottomInset: false,
                  resizeToAvoidBottomPadding: true,
                  appBar: AppBar(
                  title: Text('                Pay Fees' , style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold ) ),
                  backgroundColor: Colors.black,
                  elevation: 10.0,
                ),
            ),
        );
    }
}

class CardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardScreenState();
  }
}

class CardScreenState extends State<CardScreen> {
    
  String amount = '';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<String>(context) ?? '';
    UserData obj = UserData(name: '',roll: '',department: '',series: '',bloodgroup: '');
    UserData data = Provider.of< UserData >(context) ?? obj;
    
    return loading ? Loading() : Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
             CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                     CreditCardForm( onCreditCardModelChange: onCreditCardModelChange),
          
                      amountField(),          
                      RaisedButton(
                         child: Text('Pay',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                         color: Colors.green,
                         onPressed: () async{
                           if(_formKey.currentState.validate()){
                              setState(() => loading = true);    
                              await DatabaseService(uid: uid).addPayInfo(data.name,data.roll,amount);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Success()),(route) => false);     
                           }
                         }
                      )
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
}

  Widget amountField() {
      return Container(
        margin:EdgeInsets.all(15.0),
        child: TextFormField(
          decoration: new InputDecoration(
             focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.blue)),
             enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.grey)),
            labelText: 'Amount',
          ),
          onChanged: (val) { setState(() => amount = val); },
          validator: (value) {
            if (value.isEmpty) return 'Please enter your name';
            return null;
          },
        ),
   );
 }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
       cardNumber = creditCardModel.cardNumber;
       expiryDate = creditCardModel.expiryDate;
       cardHolderName = creditCardModel.cardHolderName;
       cvvCode = creditCardModel.cvvCode;
       isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}