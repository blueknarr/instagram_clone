import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/search/search_model.dart';

import '../../create/create_page.dart';
import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final List<String> _urls = const [
    'https://img.hankyung.com/photo/202209/01.31260157.1.jpg',
    'https://img.khan.co.kr/news/2023/05/12/news-p.v1.20230512.e5fffd99806f4dcabd8426d52788f51a_P1.png',
    'https://image.xportsnews.com/contents/images/upload/article/2023/0511/mb_1683765801791769.jpeg',
    'https://file2.nocutnews.co.kr/newsroom/image/2023/05/03/202305031714287586_0.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final model = SearchModel();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// 새 게시글 작성 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        child: const Icon(Icons.create),
      ),
      appBar: AppBar(
        title: Text('Instagram Clone'),
      ),
      body: StreamBuilder<QuerySnapshot<Post>>(
          stream: model.postsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('알 수 없는 에러');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Post> posts =
                snapshot.data!.docs.map((post) => post.data()).toList();

            return GridView.builder(
              /// 사진의 개수를 알려줘야 한다.
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (context) => DetailPostPage(post: post)),
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
    );
  }
}
