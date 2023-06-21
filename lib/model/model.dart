class Post {
  final String id;
  final String image;
  final int likes;
  final String text;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;
  final String publishDate;

  const Post({
    required this.image,
    required this.likes,
    required this.text,
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.id,
    required this.title,
    required this.publishDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      image: json['image'],
      likes: json['likes'],
      text: json['text'],
      publishDate: json['publishDate'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      title: json['title'],
      picture: json['picture'],
    );
  }
}
