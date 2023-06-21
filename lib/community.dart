import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'community/post.dart';
import 'model/model.dart';
import 'repository/repository.dart';
import 'theme.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Post> postList = [];
  Repository repository = Repository();

  getData() async {
    postList = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  // const CommunityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Community'),
        backgroundColor: greenColor,
        toolbarHeight: 71.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return PostPage(
                  image: postList[index].image,
                  likes: postList[index].likes,
                  text: postList[index].text,
                  publishDate: postList[index].publishDate,
                  title: postList[index].title,
                  firstName: postList[index].firstName,
                  lastName: postList[index].lastName,
                  picture: postList[index].picture,
                );
              },
              itemCount: postList.length,
            ),
          ),
        ],
      ),
    );
  }
}
