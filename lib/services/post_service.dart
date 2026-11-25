import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  const PostService();

  static final _url = Uri.parse(
    'https://jsonplaceholder.typicode.com/posts',
  );

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(_url).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 200) {
      throw Exception('Poslužitelj je vratio status ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return json
        .map((post) => Post.fromJson(post as Map<String, dynamic>))
        .toList();
  }
}
