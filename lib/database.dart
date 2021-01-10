import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
     final String name,roll,department,series,bloodgroup;
     UserData({this.name,this.roll,this.department,this.series,this.bloodgroup});
}

class PayInfo{
    final amount,time,name;
    PayInfo({this.amount,this.time,this.name});
}

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  // ignore: deprecated_member_use
  final CollectionReference students = Firestore.instance.collection('Students');

  Future<void> addStudent(String name,String roll, String department,String series,String bloodGroup) async {
    // ignore: deprecated_member_use
    return await students.document(uid).setData({
      'Name': name,
      'Roll': roll,
      'Department': department,
      'Series': series,
      'Blood-Group': bloodGroup,
    });
  }

    // ignore: deprecated_member_use
    final CollectionReference paidStudents = Firestore.instance.collection('Paid-Students');

  Future<void> addPayInfo(String name,String roll, String amount) async {
    // ignore: deprecated_member_use
    return await paidStudents.add({
      'Uid' : uid,
      'Name': name,
      'Roll': roll,
      'Amount': amount,
      'Time' : DateTime.now().toString()
    });
  }
  
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String , dynamic> data = snapshot.data();
    return UserData(
      name: data['Name'],
      roll: data['Roll'],
      department: data['Department'],
      series: data['Series'],
      bloodgroup: data['Blood-Group']
    );
  }

  Stream<UserData> get userData {
     if(uid != ''){
       return students.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
      }
    else return null; 
  }

  List<PayInfo> _paymentsFromSnapshot(QuerySnapshot snapshot) {
    // ignore: deprecated_member_use
    return snapshot.documents.map((doc){
      Map<String , dynamic> data = doc.data();
      return PayInfo(

        amount: data['Amount'] ?? '',
        time :  data['Time'] ?? '',
        name: data['Name'] ?? '',
      );
    }).toList();
  }

  Stream<List<PayInfo>> get payments {
    if(uid != '')
      return paidStudents.where('Uid',isEqualTo: uid).snapshots()
      .map(_paymentsFromSnapshot);
    else return null;
  }
}