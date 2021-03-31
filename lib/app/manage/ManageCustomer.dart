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

  static void signOut(){
    FirebaseAuth.instance.signOut();
  }
}