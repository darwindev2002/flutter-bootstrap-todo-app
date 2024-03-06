import 'package:firebase_auth/firebase_auth.dart';

const FIRESTORE_COLLECTION_TODO = 'todo-items';

bool checkUserValid() {
  User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}
