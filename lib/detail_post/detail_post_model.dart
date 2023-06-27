import 'package:firebase_auth/firebase_auth.dart';

class DetailPostModel {
  final String _url =
      'https://file2.nocutnews.co.kr/newsroom/image/2023/05/03/202305031714287586_0.jpg';
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
