import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class PostPage extends StatefulWidget {
  final String image;
  final int likes;
  final String text;
  final String publishDate;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;

  const PostPage({
    Key? key,
    required this.image,
    required this.likes,
    required this.text,
    required this.publishDate,
    required this.title,
    required this.firstName,
    required this.picture,
    required this.lastName,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 17.0,
          thickness: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.firstName} ${widget.lastName}",
                          style: TextStyle(
                            fontFamily: "PoppinsMedium",
                            fontSize: 14,
                            color: blackColor,
                          ),
                        ),
                        Text(
                          widget.publishDate,
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 12.0,
                            color: Color(0x0FF797979),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.more_horiz),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: widget.text,
              style: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 12.0,
                color: blackColor,
              ),
            ),
          ),
        ),
        SizedBox(
          child: Image.network(
            "https://picsum.photos/600/400?name=${widget.firstName}",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: _toggleLike,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x0FFE8E8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 97.0,
                  height: 27.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "images/icon/like.svg",
                            width: 16,
                            height: 16,
                            color: isLiked ? Colors.redAccent : null,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Like ${isLiked ? (widget.likes + 1) : widget.likes}",
                            style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: blackColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0x0FFE8E8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 115.0,
                height: 27.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "images/icon/comment.svg",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Comment",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0x0FFE8E8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 80.0,
                height: 27.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "images/icon/share.svg",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
