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
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.",
  ),
  Post(
    userName: "Sowmya",
    timeAgo: "32m",
    caption:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
  ),
  Post(
    userName: "Pranathi",
    timeAgo: "43m",
  ),
  Post(
    userName: "Harsha",
    timeAgo: "51m",
  ),
  Post(
    userName: "Harsha",
    timeAgo: "1hr",
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
