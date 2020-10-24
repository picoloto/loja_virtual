import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/utils/const/user_constants.dart';

class User {
  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data[userName] as String;
    email = document.data[userEmail] as String;
    if(document.data.containsKey(userAddress)){
      address = Address.fromMap(document.data[userAddress] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;
  Address address;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('$userCollection/$id');

  CollectionReference get cartReference => firestoreRef.collection(userCartCollection);

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      userName: name,
      userEmail: email,
      if(address != null)
        userAddress: address.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
