import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/post.dart';

class SearchModel {
  /// posts 전체 데이터를 스트림으로 가져온다.
  /// 스트림은 데이터가 변경되면 자동으로 갱신된다.
  final Stream<QuerySnapshot<Post>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();
}
