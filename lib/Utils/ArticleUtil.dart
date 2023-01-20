import 'package:caritas/Models/Db/DbHelper.dart';
import 'package:hive/hive.dart';

class ArticleUtil {
  // 有以下链接样式
  // www.zhihu.com/question/xxxxx/answer/xxxxx
  // 传入此样式的url, 返回知乎链接包含此url的文章
  static Article? findArticleByUrl(String url) {
    url =
        RegExp(r'www.zhihu.com/question/\d+/answer/\d+').firstMatch(url)?[0] ??
            "";
    if (url == "") return null;
    List<Article> articles = Hive.box("articles").values.toList().cast();
    for (var article in articles) {
      if (article.zhihuLink.contains(url)) {
        return article;
      }
    }
    return null;
  }
}
