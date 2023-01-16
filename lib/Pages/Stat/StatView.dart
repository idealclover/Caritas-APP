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
  @override
  void initState() {
    super.initState();
    updateStatResult();
  }

  void updateStatResult() {
    statResult = StatUtil.getStatResult(statParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).stat_title),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: ListTile.divideTiles(
              context: context,
              tiles: [
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
                ),
                ...statResult.map(_displayStat)
              ],
            ).toList()),
      ),
    );
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
                flex: 28,
                child: Column(
                  children: result.keys.map((e) => Text(e)).toList(),
                )),
            Expanded(
                flex: 60,
                child: Column(
                  children: items,
                ))
          ],
        ));
  }

  Widget _displayStatItem(String title, StatItem item) {
    return Row(children: [
      Expanded(flex: 25, child: Text("$title:")),
      Expanded(
          flex: 32,
          child: Text(
            "${item.current}",
            textAlign: TextAlign.right,
          )),
      Expanded(flex: 38, child: Text(" / ${item.total}")),
      Expanded(
          flex: 25,
          child: Text(
            "${item.percent}%",
            textAlign: TextAlign.right,
          )),
    ]);
  }
}
