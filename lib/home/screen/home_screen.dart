import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/home/bloc/post_bloc.dart';
import 'package:task_app/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController post = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetPost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post",
            style: TextStyle(
                color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SplashScreen()));
              },
              icon: const Icon(
                Icons.login_outlined,
                color: Colors.red,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is PostSuccess) {
                  if (state.posts.isEmpty) {
                    return const Center(
                        child: Text("No posts yet. Be the first to post!"));
                  }
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${post['firstName']} ${post['lName']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                                Text(post["text"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${formatTimestamp(post["timestamp"])}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                    child: Text("Press the button to fetch posts"));
              },
            ),
          ),
          Container(height: 30),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: TextField(
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          hintText: "Write new post..",
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none),
                      controller: post),
                )),
                IconButton(
                    onPressed: () {
                      addPost();
                    },
                    icon: const Icon(Icons.send, color: Colors.red))
              ],
            ),
          )
        ],
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();

    String formattedDate = DateFormat('d MMMM, h:mm a').format(dateTime);
    return formattedDate;
  }

  Future<void> addPost() async {
    if (post.text.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      await FirebaseFirestore.instance.collection("posts").add({
        "text": post.text.trim(),
        "userId": user?.uid,
        "firstName": userData?['firstName'],
        "lName": userData?['lName'],
        "timestamp": FieldValue.serverTimestamp(),
      });
      post.clear();
    }
  }
}
