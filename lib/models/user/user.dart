import 'package:cloud_firestore/cloud_firestore.dart';

const modelName = 'name';
const modelEmail = 'email';

class User {
  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data[modelName] as String;
    email = document.data[modelEmail] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'email': email,
    };
  }
}
