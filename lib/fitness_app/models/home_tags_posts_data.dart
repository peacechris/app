import 'dart:math';

class HomeTagsPostsData {
  HomeTagsPostsData({
    this.id,
    this.imagePath = '',
    this.titleTxt = '',
    this.summary = '',
    this.author = '',
    this.publish = '',
    this.startColor = '',
    this.endColor = '',
  });

  String id;
  String imagePath;
  String titleTxt;
  String summary;
  String author;
  String publish;
  String startColor;
  String endColor;
  List<HomeTagsPostsData> tagsListData = <HomeTagsPostsData>[];
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  List colorsMap = [
    {'startColor':'#FA7D82','endColor':'#FFB295'},
    {'startColor':'#738AE6','endColor':'#5C5EDD'},
    {'startColor':'#FE95B6','endColor':'#FF5287'},
    {'startColor':'#cccc66','endColor':'#ffff66'},
  ];


  List refreshList(tagSequence, responseData){
        for (var post in responseData) {
          var sequence = tagSequence%4;
          var bgColor = colorsMap[sequence];
          int iconSeq = next(0,9);
          tagsListData.add(
            HomeTagsPostsData(
              id:post['id'],
              imagePath: 'assets/fitness_app/post_icon/'+iconSeq.toString()+'.png',
              titleTxt: post['title'],
              summary:post['summary'],
              author:post['author'],
              publish:post['publish_date'],
              startColor: bgColor['startColor'],
              endColor: bgColor['endColor'],
            ),
          );
    }
    return tagsListData;
  }

}
