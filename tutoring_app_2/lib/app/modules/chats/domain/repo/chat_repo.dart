import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';

class ChatsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<User>> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection('users').get();

      List<User> usersList = querySnapshot.docs
          .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return usersList;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      return [];
    }
  }
}
