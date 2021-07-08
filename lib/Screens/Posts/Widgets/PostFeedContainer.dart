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
              ? CachedNetworkImage(
                  imageUrl: post.imageUrl!,
                )
              : const SizedBox.shrink(),
        ],
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
          imageUrl: post.imageUrl ?? "assets/icons/profile-user.png",
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
