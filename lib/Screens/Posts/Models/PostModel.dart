// import 'package:firebase_auth/firebase_auth.dart';
List<Post> posts = [
  Post(
    userName: "Gowtham",
    timeAgo: "12m",
    caption:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    imageUrl:
        "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_2x1.jpg",
  ),
  Post(
    userName: "Harsha",
    timeAgo: "21m",
    caption:
        "Contrary to popular belief, Lorem Ipsum is not simply random text.",
  ),
  Post(
    userName: "Sowmya",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
  ),
  Post(
    userName: "Pranathi",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
  ),
  Post(
    userName: "Aishu",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
  ),
  Post(
    userName: "Vihas",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
  ),
  Post(
    userName: "Deepak",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    imageUrl:
        "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_2x1.jpg",
  ),
];

class Post {
  final String userName;
  final String timeAgo;
  final String? caption;
  final String? imageUrl;
  final int? likes;
  final int? comments;
  final int? shares;

  const Post({
    required this.userName,
    required this.timeAgo,
    this.caption,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
  });
}
