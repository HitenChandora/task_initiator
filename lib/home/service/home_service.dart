import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getPosts() {
    return fireStore
        .collection("posts")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                "text": data["text"] ?? "",
                "firstName": data["firstName"] ?? "",
                "lName": data["lName"] ?? "",
                "timestamp": data["timestamp"] ?? Timestamp.now(),
              };
            }).toList());
  }
}
