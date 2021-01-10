import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

    String getuid(User user) {
        user = _auth.currentUser;
        return user != null ? user.uid : ''; 
    }
    
    Stream<String> get user {
    // ignore: deprecated_member_use
      return _auth.onAuthStateChanged
        .map(getuid);
    }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}