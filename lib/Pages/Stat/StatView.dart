import 'dart:math';
import 'package:caritas/Utils/StatUtil.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class StatView extends StatefulWidget {
  const StatView({Key? key}) : super(key: key);

  @override
  State<StatView> createState() => _StatViewState();
}

class _StatViewState extends State<StatView> {
  StatParams statParams = StatParams();
  List<StatResult> statResult = [];
  // 自适应计算每一列的宽度
  int width1Category = 10;
  int width2Item = 10;
  int width3Current = 10;
  int width4Total = 10;
  int width5Percent = 10;
  int get actualNeedWidth =>
      width1Category + width2Item + width3Current + width4Total + width5Percent;
  @override
  void initState() {
    super.initState();
    updateStatResult();
  }

  void updateStatResult() {
    statResult = StatUtil.getStatResult(statParams);
  }

  int _textWidth(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width.ceil();
  }

  void _computeWidth() {
    assert(statResult.isNotEmpty);
    var padding = 20;
    var gap = 10;
    width1Category =
        statResult.expand((e) => e.keys).map(_textWidth).reduce(max);
    width2Item = [S.of(context).stat_articles, S.of(context).stat_words]
        .map((e) => "$e: ")
        .map(_textWidth)
        .reduce(max);
    int computeItemWidth(String Function(StatItem i) f) => statResult
        .expand((e) => [e.sumArticles, e.sumWords])
        .map(f)
        .map(_textWidth)
        .reduce(max);

    width3Current = computeItemWidth((e) => "${e.current}");
    width4Total = computeItemWidth((e) => " / ${e.total}");
    width5Percent = computeItemWidth((e) => "${e.percent}%");
    width1Category += padding + gap;
    width2Item += gap;
    width3Current += gap;
    width4Total += gap;
    width5Percent += padding;
  }

  @override
  Widget build(BuildContext context) {
    _computeWidth();
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).stat_title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: max(actualNeedWidth.toDouble(),
                    MediaQuery.of(context).size.width),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [...chips(), ...statResult.map(_displayStat)],
                    ).toList()),
              ),
            )));
  }

  List<Widget> chips() {
    return [
      Wrap(alignment: WrapAlignment.center, spacing: 5, children: [
        FilterChip(
          label: Text(S.of(context).stat_byAuthor),
          selected: statParams.byAuthor,
          onSelected: (value) => setState(() {
            statParams.byAuthor = !statParams.byAuthor;
            updateStatResult();
          }),
        ),
        FilterChip(
          label: Text(S.of(context).stat_byCatagory),
          selected: statParams.byCatagory,
          onSelected: (value) => setState(() {
            statParams.byCatagory = !statParams.byCatagory;
            updateStatResult();
          }),
        ),
      ]),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [
          FilterChip(
            label: Text(S.of(context).stat_sumArticles),
            selected: statParams.sumArticles,
            onSelected: (value) => setState(() {
              statParams.sumArticles = !statParams.sumArticles;
              updateStatResult();
            }),
          ),
          FilterChip(
            label: Text(S.of(context).stat_sumWords),
            selected: statParams.sumWords,
            onSelected: (value) => setState(() {
              statParams.sumWords = !statParams.sumWords;
              updateStatResult();
            }),
          ),
        ],
      )
    ];
  }

  Widget _displayStat(StatResult result) {
    List<Widget> items = [];
    if (statParams.sumArticles) {
      items.add(
          _displayStatItem(S.of(context).stat_articles, result.sumArticles));
    }
    if (statParams.sumWords) {
      items.add(_displayStatItem(S.of(context).stat_words, result.sumWords));
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          children: [
            Expanded(
                flex: width1Category,
                child: Column(
                  children: result.keys.map((e) => Text(e)).toList(),
                )),
            Expanded(
                flex: width2Item + width3Current + width4Total + width5Percent,
                child: Column(
                  children: items,
                ))
          ],
        ));
  }

  Widget _displayStatItem(String title, StatItem item) {
    Widget ltext(int flex, String text) => Expanded(
        flex: flex,
        child: Text(
          text,
          maxLines: 1,
        ));
    Widget rtext(int flex, String text) => Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: TextAlign.right,
          maxLines: 1,
        ));
    return Row(children: [
      ltext(width2Item, "$title:"),
      rtext(width3Current, "${item.current}"),
      ltext(width4Total, " / ${item.total}"),
      rtext(width5Percent, "${item.percent}%"),
    ]);
  }
}
