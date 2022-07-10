import 'package:flutter/material.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';
import '../../generated/l10n.dart';

class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
        ),
        body: MMarkdown(article.content));
  }
}
