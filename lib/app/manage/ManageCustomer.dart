import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrum_app/app/model/Customer.dart';

class ManageCustomer{

  //Get Information of Customer
  static Customer getCustomer(String id){
    FirebaseFirestore.instance
        .collection('users')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Customer(id, map['fullName'], map['address'], map['phone']);
      }else{
        return null;
      }
    });
  }
  //update customer
  static void updateCustomer(String id, String fullName, String address, String phone){
    FirebaseFirestore.instance.collection('users')
    .doc('$id').update({
      'fullName': fullName,
      'address': address,
      'phone': phone
    }).then((value) => print("Update Customer Success!!"))
        .catchError((error) => print("Failed to Update Customer: $error"));
  }
  //signIn
  static bool signIn(String email, String password){
    FirebaseAuth.instance.signInWithEmailAndPassword(email:email, password: password).then((value)  {
      Customer.uid = value.uid;
      print("login success!");
      return true;
    }).catchError((onError){
      print("login failure"+onError.toString());
      return false;
    });
    return true;
  }
  static bool customerRegister(String email, String password, String fullName, String address, String phone){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email:email, password: password).then((value) {
      //upload info customer
      var idUser = value.uid;
      Customer.uid = value.uid;
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(idUser).set({
        'id': idUser,
        'fullName': fullName,
        'address': address,
        'phone': phone
      }).then((value) => print("Add Customer Success!!"))
          .catchError((error) => print("Failed to add customer: $error"));

      return true;
    }).catchError((onError) {
      print("register failure"+onError.toString());
      return false;
    });
    return true;

  }
  static void signOut(){
    FirebaseAuth.instance.signOut();
  }
}