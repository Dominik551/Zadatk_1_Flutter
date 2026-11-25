import 'package:flutter/material.dart';
import '../models/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final bool pinned;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PostTile({
    super.key,
    required this.post,
    required this.pinned,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      leading: Hero(
        tag: 'post-${post.id}',
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            post.id.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      title: Text(
        post.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        post.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: AnimatedScale(
        scale: pinned ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: const Icon(Icons.push_pin),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
