import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';
import '../../common/http_util.dart';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import '../../common/global.dart';

class PostDetail extends StatefulWidget {
  final Map arguments;
  PostDetail({this.arguments, Key key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  // String title = '';

  // ignore: non_constant_identifier_names
  Map PostDetail = {
    'id': '',
    'images': [],
    'title': '',
    'summary': '',
    'content': '',
    'publish': '',
    'publish_date': '',
    'is_notice': '',
    'related_posts': '',
  };

  Widget images = Image.asset('assets/images/helpImage.png');

  @override
  void initState() {
    // print(widget.arguments);
    wgetData();
    super.initState();
  }

  Future<void> wgetData() async {
    Map<String, dynamic> params = Map();
    params["post_id"] = widget.arguments['postId'];
    var response = await HttpUtil.request('/api/tags/post-detail',
        data: params, method: HttpUtil.GET);

    var responseData = jsonDecode(response.toString());
    // print(responseData);
    if (responseData.containsKey('data')) {
      responseData = responseData['data'][0];
      print(responseData['id']);
      PostDetail['title'] = responseData['title'];
      PostDetail['content'] = responseData['content'];

      if(responseData.containsKey('images')){
        var images_urls = responseData['images'][0];
        setState(() {
          images = Image.network(Global.API_PREFIX+images_urls);
        });
      }
      
      setState(() {
        PostDetail = PostDetail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: ListView(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  // minWidth: 180,
                  minHeight: 250,
                ),
                child: images,
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left:20,right: 20),
                child: Text(
                  PostDetail['title'].isNotEmpty ? PostDetail['title'] : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left:18,right: 18),
                child: PostDetail['content'].isNotEmpty
                      ? Html(
                          data: PostDetail['content'],
                        )
                      : Text(''),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
