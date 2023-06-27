import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/account/account_model.dart';

class AccountPage extends StatelessWidget {
  final model = AccountModel();

  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Instagram Clone'),
          actions: [
            IconButton(
              onPressed: () {
                model.logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            /// 공백까지 균등하게 간격 주기
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.getProfileImageUrl()),
                        ),
                      ),

                      /// 프로필 사진 위에 버튼 띄우기
                      Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: FloatingActionButton(
                                onPressed: null,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: FloatingActionButton(
                                onPressed: () {},
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.getNickName(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '3',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '게시글',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '팔로워',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '팔로잉',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
