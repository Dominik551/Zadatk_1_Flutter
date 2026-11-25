import 'package:flutter/material.dart';
import '../models/post.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animation,
      curve: Curves.easeOutBack,
    ));

    _animation.forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalji objave')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: ScaleTransition(
              scale: _scale,
              child: Hero(
                tag: 'post-${post.id}',
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    post.id.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            post.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Text(
            post.body,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: const Text('Broj objave'),
            trailing: Text(post.id.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Korisnik'),
            trailing: Text(post.userId.toString()),
          ),
        ],
      ),
    );
  }
}
