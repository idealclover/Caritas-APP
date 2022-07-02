class Article {
  String? Title;
  String? Path;
  String? Question;
  String? ZhiHu;
  String? Author;
  String? Links;
  String? LastUpdate;
  String? Content;

  Article(
      {this.Title,
      this.Path,
      this.Question,
      this.ZhiHu,
      this.Author,
      this.Links,
      this.LastUpdate,
      this.Content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        Title: json['Title'],
        Path: json['Path'],
        Question: json['Question'],
        ZhiHu: json['ZhiHu'],
        Author: json['Author'],
        Links: json['Links'],
        LastUpdate: json['LastUpdate'],
        Content: json['Content']);
  }
}

class ArticleList {
  List<Article>? memberList;

  ArticleList({this.memberList});

  factory ArticleList.fromJson(List<dynamic> listJson) {
    List<Article> memberList =
        listJson.map((value) => Article.fromJson(value)).toList();

    return ArticleList(memberList: memberList);
  }
}
