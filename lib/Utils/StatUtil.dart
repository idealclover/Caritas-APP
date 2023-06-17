import 'package:caritas/Models/Db/DbHelper.dart';
import 'package:caritas/Pages/Settings/SettingsProvider.dart';
import 'package:hive/hive.dart';

class StatParams {
  bool byAuthor;
  bool byCatagory;
  bool sumWords;
  bool sumArticles;
  StatParams(
      {this.byAuthor = false,
      this.byCatagory = false,
      this.sumWords = true,
      this.sumArticles = false});
}

class StatResult {
  List<String> keys;
  StatItem sumWords;
  StatItem sumArticles;
  StatResult(this.keys, this.sumWords, this.sumArticles);
}

class StatItem {
  int current;
  int total;
  get percent => total == 0 ? 0 : current * 1000 ~/ total / 10.0;
  StatItem(this.current, this.total);
}

class StatUtil {
  static List<StatResult> getStatResult(StatParams params) {
    List<Article> articles = Hive.box("articles").values.toList().cast();
    List<String> categories = Hive.box('categories')
        .values
        .cast<Category>()
        .map((e) => e.title)
        .toList();
    var histories = SettingsProvider().getHistories();
    Map<String, StatResult> map = {};
    for (var article in articles) {
      var keys = _getArticleStatKeys(article, categories, params);
      for (var key in keys) {
        var keyStr = key.join(",");
        if (!map.containsKey(keyStr)) {
          map[keyStr] = StatResult(key, StatItem(0, 0), StatItem(0, 0));
        }
        var item = map[keyStr]!;
        if (histories.contains(article.id)) {
          item.sumWords.current += article.content.length;
          item.sumArticles.current += 1;
        }
        item.sumWords.total += article.content.length;
        item.sumArticles.total += 1;
      }
    }
    return (map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
        .map((e) => e.value)
        .toList();
  }

  static List<List<String>> _getArticleStatKeys(
      Article article, List<String> categories, StatParams params) {
    List<List<String>> keys = [];
    categories =
        categories.where((element) => article.tags.contains(element)).toList();
    var author = article.author.trim();
    if (params.byAuthor && params.byCatagory) {
      keys = categories.map((e) => [author, e]).toList();
    } else if (params.byAuthor) {
      keys = [
        [author]
      ];
    } else if (params.byCatagory) {
      keys = categories.map((e) => [e]).toList();
    } else {
      keys = [];
    }
    keys.insert(0, ["#All"]);
    return keys;
  }
}
