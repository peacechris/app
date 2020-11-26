class TagsListData {
  TagsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.summary = '',
    this.author = '',
    this.publish = '',
    this.startColor = '',
    this.endColor = '',
  });

  String imagePath;
  String titleTxt;
  String summary;
  String author;
  String publish;
  String startColor;
  String endColor;
  List<TagsListData> tagsListData = <TagsListData>[];
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
          tagsListData.add(
            TagsListData(
              imagePath: 'assets/fitness_app/breakfast.png',
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
