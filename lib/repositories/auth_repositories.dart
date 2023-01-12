import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import '../services/firebase_services.dart';

class AuthRepository {
  CollectionReference<UserModel> userRef =
      FirebaseService.db.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, _) {
              return UserModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Future<UserCredential> register(
      UserModel user, String email, String password) async {
    UserCredential auth = await FirebaseService.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    user.userId = auth.user!.uid;
    userRef.add(user);
    return auth;
  }
}
