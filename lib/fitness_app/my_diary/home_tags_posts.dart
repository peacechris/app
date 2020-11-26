import 'package:best_flutter_ui_templates/fitness_app/fintness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/home_tags_posts_data.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HomeTagsPosts extends StatefulWidget {
  const HomeTagsPosts(
      {Key key,
      this.tagsPostsData,
      this.tagSequence,
      this.mainScreenAnimationController,
      this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final tagsPostsData;
  final tagSequence;

  @override
  _HomeTagsPostsState createState() => _HomeTagsPostsState();
}

class _HomeTagsPostsState extends State<HomeTagsPosts>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<HomeTagsPostsData> tagsPostsData;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    HomeTagsPostsData tagsPostsDataObj = HomeTagsPostsData();
    tagsPostsData =
        tagsPostsDataObj.refreshList(widget.tagSequence, widget.tagsPostsData);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: tagsPostsData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      tagsPostsData.length > 10 ? 10 : tagsPostsData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return TagsCard(
                    tagsPostsData: tagsPostsData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class TagsCard extends StatelessWidget {
  const TagsCard(
      {Key key, this.tagsPostsData, this.animationController, this.animation})
      : super(key: key);

  final HomeTagsPostsData tagsPostsData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/post-detail',
                    arguments: {"postId": tagsPostsData.id}
                  );
                },
                child: SizedBox(
                  width: 320,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 8, right: 8, bottom: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: HexColor(tagsPostsData.endColor)
                                      .withOpacity(0.6),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                            gradient: LinearGradient(
                              colors: <HexColor>[
                                HexColor(tagsPostsData.startColor),
                                HexColor(tagsPostsData.endColor),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(54.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 16, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                tagsPostsData.titleTxt.isNotEmpty
                                    ? Text(
                                        tagsPostsData.titleTxt,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      )
                                    : Text(''),
                                Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: tagsPostsData
                                                  .summary.isNotEmpty
                                              ? Text(
                                                  tagsPostsData.summary,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: FitnessAppTheme.grey
                                                        .withOpacity(0.8),
                                                  ),
                                                )
                                              : Text(''),
                                        ),
                                      ],
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, bottom: 8),
                                      child: Column(
                                        children: <Widget>[
                                          tagsPostsData.author.isNotEmpty
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.portrait,
                                                      color: FitnessAppTheme
                                                          .grey
                                                          .withOpacity(0.5),
                                                      size: 14,
                                                    ),
                                                    Text(
                                                      tagsPostsData.author,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: FitnessAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text('')
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          tagsPostsData.publish.isNotEmpty
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      color: FitnessAppTheme
                                                          .grey
                                                          .withOpacity(0.5),
                                                      size: 14,
                                                    ),
                                                    Text(
                                                      tagsPostsData.publish,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FitnessAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        letterSpacing: 0.0,
                                                        color: FitnessAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -2,
                        left: 1,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 6,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(tagsPostsData.imagePath),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
