import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/post.dart';

class CreateModel {
  final ImagePicker _picker = ImagePicker();

  Future<File?> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  Future<void> uploadPost(String title, File imageFile) async {
    final postsRef =
        FirebaseFirestore.instance.collection('posts').withConverter<Post>(
              fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
              toFirestore: (post, _) => post.toJson(),
            );

    postsRef.add(
      Post(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          title: title,
          imageUrl:
              'https://file2.nocutnews.co.kr/newsroom/image/2023/05/03/202305031714287586_0.jpg'),
    );
  }
}
