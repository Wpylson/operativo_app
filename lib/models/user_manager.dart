import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:operativo_final_cliente/helpers/firebase_errors.dart';
import 'package:operativo_final_cliente/models/user.dart';

class UserManager extends ChangeNotifier{

  //Para carregar o user qndo ja estiver logado
  UserManager(){
    _loadCurrentUser();
  }

  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;


  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;


  Future<void> signIn({User user, Function onFail,Function onSuccess})async{
    loading = true;
    try{
      final AuthResult result = await auth.signInWithEmailAndPassword
       (email: user.email, password: user.password);


      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();

    }on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }

    loading = false;

  }

  Future<void> signUp({User user, Function onFail, Function onSuccess})async{
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      //Salvar o id do user
      user.id = result.user.uid;
      await user.saveData();
      onSuccess();

    } on PlatformException catch(e){

      onFail(getErrorString(e.code));
    }
    loading = false;

  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

 Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async{
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot docUser = await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);

      //verificar se o user é um admin
      final docAdmin = await firestore.collection('admins').document(user.id).get();
      if(docAdmin.exists){
        user.admin = true;
      }

      notifyListeners();
    }


 }

 //get para check se user é um admin ou não
 bool get adminEnabled => user != null && user.admin;


}