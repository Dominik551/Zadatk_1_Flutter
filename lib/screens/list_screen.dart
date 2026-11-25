import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';
import '../widgets/post_tile.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _service = const PostService();
  late Future<List<Post>> _posts;
  final _pinned = <int>{};

  @override
  void initState() {
    super.initState();
    _posts = _service.fetchPosts();
  }

  Future<void> _reload() {
    setState(() {
      _posts = _service.fetchPosts();
    });
    return _posts.then((_) {});
  }

  void _openDetail(Post post) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return DetailScreen(post: post);
        },
      ),
    );
  }

  void _togglePin(Post post) {
    setState(() {
      if (!_pinned.remove(post.id)) {
        _pinned.add(post.id);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _pinned.contains(post.id)
              ? 'Objava je označena'
              : 'Oznaka je uklonjena',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildList(List<Post> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text('Nema objava za prikaz'));
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return PostTile(
            post: post,
            pinned: _pinned.contains(post.id),
            onTap: () => _openDetail(post),
            onLongPress: () => _togglePin(post),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objave'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48),
                  const SizedBox(height: 12),
                  const Text('Objave nije moguće dohvatiti.'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _reload,
                    child: const Text('Pokušaj ponovno'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Nema podataka.'));
          }

          return _buildList(snapshot.data!);
        },
      ),
    );
  }
}
