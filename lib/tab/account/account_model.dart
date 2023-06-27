import 'package:firebase_auth/firebase_auth.dart';

class AccountModel {
  final String _url =
      'https://file2.nocutnews.co.kr/newsroom/image/2023/05/03/202305031714287586_0.jpg';

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ?? _url;
  }
}
