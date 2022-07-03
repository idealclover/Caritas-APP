import 'package:flutter/material.dart';
import '../../Components/Markdown.dart';
import '../../Models/ArticleModel.dart';
import 'ArticleProvider.dart';
import '../../generated/l10n.dart';

class ArticleView extends StatelessWidget {
  final int id;

  const ArticleView(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticleProvider ap = ArticleProvider();
    Article data = ap.getArticle(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(data.title),
        ),
        body: MMarkdown(data.content));
  }
}
