import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmx/Screens/Posts/Models/PostModel.dart';
import 'package:flutter/material.dart';

import 'ProfileAvatar.dart';

class PostFeedContainer extends StatelessWidget {
  const PostFeedContainer({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: <Widget>[
                _PostHeader(post: post),
                const SizedBox(
                  height: 4.0,
                ),
                Text(post.caption ?? ""),
                post.imageUrl != null
                    ? SizedBox.shrink()
                    : SizedBox(
                        height: 6.0,
                      ),
              ],
            ),
          ),
          post.imageUrl != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl!,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          ),
        ],
      ),
    );
  }
}

class _PostStats extends StatelessWidget {
  const _PostStats({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.thumb_up,
                size: 10,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              '${post.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.thumb_up_outlined,
                  color: Colors.grey[600],
                  size: 20.0,
                ),
                onPressed: () {
                  print('Like');
                },
                // onTap: () => print('Like'),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.comment_outlined,
                  color: Colors.grey[600],
                  size: 20.0,
                ),
                onPressed: () {
                  print('Comment');
                },
                // onTap: () => print('Comment'),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: Colors.grey[600],
                  size: 25.0,
                ),
                onPressed: () {
                  print('Share');
                },
                // onTap: () => print('Share'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;

  const _PostButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ProfileAvatar(
          imageUrl: post.imageUrl ??
              "https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/e5uz3hohacjxhdga_1595409485.jpeg",
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "${post.timeAgo} . ",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            print("More");
          },
          icon: Icon(
            Icons.more_horiz,
          ),
        ),
      ],
    );
  }
}
