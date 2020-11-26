import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';
import '../../common/http_util.dart';
import 'dart:convert';

class PostDetail extends StatefulWidget {
  final Map arguments;
  PostDetail( {this.arguments,Key key }) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  // String title = '';
  
  // ignore: non_constant_identifier_names
  Map PostDetail = {
    'id':'',
    'title':'',
    'summary':'',
    'content':'',
    'publish':'',
    'publish_date':'',
    'is_notice':'',
    'related_posts':'',
    'images':'',
  };

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
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/helpImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  PostDetail['title'].isNotEmpty?
                  PostDetail['title']:'',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  PostDetail['content'].isNotEmpty?
                  PostDetail['content']:'',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Chat with Us',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
