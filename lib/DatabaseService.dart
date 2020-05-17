import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  // Collection reference
  final CollectionReference collectionReference =
      Firestore.instance.collection('Users');

  Future updateUserData(
      String firstname, String lastname, String gender, String email) async {
    return await collectionReference.document(uid).setData({
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'email': email
    });
  }

}
