// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:poster_assignment/models/template_model.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> addTemplate(TemplateModel template) async {
//     await _db.collection('templates').add(template.toMap());
//   }

//   Stream<List<TemplateModel>> getTemplates() {
//     return _db.collection('templates').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => TemplateModel.fromFirestore(doc)).toList());
//   }

//   Future<void> addUserRole(User user, String role) async {
//     await _db.collection('users').doc(user.uid).set({
//       'email': user.email,
//       'role': role,
//     });
//   }

//   Future<String?> getUserRole(String uid) async {
//     DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
//     return doc.exists ? doc['role'] : null;
//   }
// }
