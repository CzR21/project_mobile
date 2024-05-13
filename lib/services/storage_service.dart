import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static final FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

  static FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

}