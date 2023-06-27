import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/account/account_model.dart';

import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';

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
          child: Column(
            children: [
              Row(
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
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StreamBuilder<QuerySnapshot<Post>>(
                      stream: model.postsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('알 수 없는 에러');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        List<Post> posts = snapshot.data!.docs
                            .map((post) => post.data())
                            .toList();

                        return GridView.builder(
                          /// 사진의 개수를 알려줘야 한다.
                          itemCount: posts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            /// 열의 개수
                            crossAxisCount: 3,

                            /// 상하 간격
                            mainAxisSpacing: 2,

                            /// 좌우 간격
                            crossAxisSpacing: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final post = posts[index];

                            /// Grid는 사진의 사이즈를 설정하지 않아도 자동으로 정사각형 사이즈로 설정
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPostPage(post: post)),
                                );
                              },
                              child: Hero(
                                tag: post.id,
                                child: Image.network(
                                  post.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
