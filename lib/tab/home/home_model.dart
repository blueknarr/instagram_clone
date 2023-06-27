import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeModel {
  final String _url =
      'https://file2.nocutnews.co.kr/newsroom/image/2023/05/03/202305031714287586_0.jpg';

  final ImagePicker _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      /// 사진 업로드 후 url을 보낸다.
      /// 이미지 업로드
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
          'user/${FirebaseAuth.instance.currentUser?.uid}/profile/${DateTime.now().microsecondsSinceEpoch}.jpg');
      await imageRef.putFile(File(image.path));

      /// 이미지 url을 얻는다.
      final photoURL = await imageRef.getDownloadURL();

      /// 사진 업데이트
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(photoURL);
    }
  }

  String getEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ?? _url;
  }
}
