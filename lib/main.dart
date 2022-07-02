// ignore_for_file: must_be_immutable, unnecessary_const

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/article.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_markdown/flutter_markdown.dart';
import 'ariticle_parse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized(); //解决加载json错误

  runApp(const MyApp());
}

final Future<ArticleList> data = decodeMemberList();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _appBar_bottom_demo(context);
  }
}

class MyHomeBody extends StatelessWidget {
  ArticleList? xx;

  MyHomeBody(ArticleList x, {Key? key}) : super(key: key) {
    xx = x;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: xx!.memberList!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            title: Text(
              index.toString() +
                  " " +
                  xx!.memberList![index].Title!.replaceAll(".md", ""),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: 2.0,
                  wordSpacing: 1.5),
            ),
            subtitle: Text(xx!.memberList![index].Question!),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                Set<String> get() {
                  Set<String> Link = <String>{};
                  RegExp rxp = RegExp(r"\[(.*?)\]");
                  Iterator<RegExpMatch> xxa =
                      rxp.allMatches(xx!.memberList![index].Links!).iterator;
                  final matches = rxp
                      .allMatches(xx!.memberList![index].Links!)
                      .map((m) => m.group(0));
                  matches.forEach((element) {
                    if (element.toString().indexOf("/") == -1) {
                      Link.add(element
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "") +
                          ".md");
                    } else {
                      String tit = element.toString();
                      tit = tit.substring(tit.lastIndexOf("/") + 1);

                      print(tit
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "") +
                          ".md");
                      Link.add(tit
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "") +
                          ".md");
                    }
                  });

                  return Link;
                }

                return Scaffold(
                  appBar: AppBar(
                      title: Text(
                        xx!.memberList![index].Title!.replaceAll(".md", ""),
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.blue,
                      actions: <Widget>[
                        // 非隐藏的菜单
                        fav(s: xx!.memberList![index].Title!),
                        IconButton(
                            icon: const Icon(Icons.explore),
                            onPressed: () {
                              if (xx!.memberList![index].ZhiHu!.isNotEmpty) {
                                launch(xx!.memberList![index].ZhiHu!);
                              } else {
                                launch(
                                    "https://www.zhihu.com/search?type=content&q=" +
                                        xx!.memberList![index].Question!);
                              }
                            }),
                      ]),
                  body: PageView(
                    children: [
                      FlutterMarkdown(xx!.memberList![index].Content!, key),
                      FutureBuilder(
                          future: FavList(get()),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              ArticleList xx = snapshot.data;
                              if (xx.memberList!.isEmpty) {
                                return const Center(
                                  child: Text("无关联阅读..."),
                                );
                              } else {
                                return MyHomeBody(snapshot.data);
                              }
                            } else {
                              return const Center(
                                child: Text("加载中..."),
                              );
                            }
                          }),
                    ],
                  ),
                );
              }));
            },
          );
        });
  }
}

class FlutterMarkdown extends StatelessWidget {
  String? path;
  FlutterMarkdown(
    this.path,
    Key? key,
  );

  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: true,
      data: path!,
      styleSheet: MarkdownStyleSheet(
        horizontalRuleDecoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                width: 2.0,
                color: Colors.black12,
              ),
              bottom: BorderSide(
                width: 20.0,
                color: Colors.transparent,
              )),
        ),
        blockquoteDecoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 5.0,
              color: Colors.black12,
            ),
          ),
        ),
        blockquotePadding: const EdgeInsets.fromLTRB(25.0, 5.0, 5.0, 5.0),
        blockquote: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        strong: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        h2: const TextStyle(fontSize: 20, height: 1.8, wordSpacing: 1.2),
        h4: const TextStyle(fontSize: 20, height: 1.8, wordSpacing: 1.2),
        p: const TextStyle(
            fontSize: 16, color: Colors.black87, height: 1.8, wordSpacing: 1.2),
        pPadding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
        a: const TextStyle(
            color: Color.fromARGB(255, 26, 109, 177),
            decoration: TextDecoration.underline),
      ),
      onTapLink: (text, href, title) {
        launch(href!);
      },
    );
  }
}

Widget _appBar_bottom_demo(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultTabController(
      length: 20,
      child: Scaffold(
        drawer: Drawer(child: menu()),
        appBar: AppBar(
          primary: true, //为false的时候会影响leading，actions、titile组件，导致向上偏移
          actionsIconTheme: const IconThemeData(
              color: Colors.white,
              opacity: 1), //设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
          iconTheme: const IconThemeData(
              color: Colors.white, opacity: 1), //设置AppBar上面Icon的主题颜色
          brightness: Brightness.dark, //设置导航条上面的状态栏显示字体颜色
          backgroundColor: Colors.blue, //设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效

//          bottom: PreferredSize(child: Text('data'), preferredSize: Size(30, 30)),//出现在导航条底部的按钮
          bottom: TabBar(
              onTap: (int index) {
                print('Selected......$index');
              },
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              unselectedLabelColor:
                  Colors.black38, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
              labelColor: Colors.white, //设置选中时的字体颜色，tabs里面的字体样式优先级最高
              labelStyle:
                  const TextStyle(fontSize: 20.0), //设置选中时的字体样式，tabs里面的字体样式优先级最高
              isScrollable: true, //允许左右滚动
              indicatorColor: Colors.blue, //选中下划线的颜色
              indicatorSize: TabBarIndicatorSize
                  .tab, //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
              indicatorWeight: 2.0, //选中下划线的高度，值越大高度越高，默认为2。0
              indicator: const BoxDecoration(), //用于设定选中状态下的展示样式
              tabs: const [
                Text('致读者'),
                Text('家族答集'),
                Text('企管答集'),
                Text('第一性'),
                Text('社科答集'),
                Text('科学答集'),
                Text('未来科技'),
                Text('军事技艺'),
                Text('文艺答集'),
                Text('神学答集'),
                Text('就你机灵'),
                Text('新冠系列'),
                Text('大过滤器'),
                Text('是什么系列'),
                Text('怎么办系列'),
                Text('如何看待'),
                Text('好好活着'),
                Text('Bible女性'),
                Text('书评影评'),
                Text('待分类'),
              ]),
          centerTitle: true,
          title: const Text('Caritas App'),
          actions: <Widget>[Serch()],
        ),
        body: TabBarView(children: [
          FutureBuilder(
              future: decodeTypeList("00 - 致读者"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("01 - 家族答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("02 - 企管答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("03 - 第一性"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("04 - 社科答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("05 - 科学答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("06 - 未来科技"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("07 - 军事技术与艺术"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("08 - 文艺答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("09 - 神学答集"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("10 - “就你机灵”系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("11 - 新冠"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("12 - 大过滤器"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("00 - “是什么”系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("01 - “怎么办”系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("02 - “如何看待”系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("03 - “好好活着”系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("04 - Bible女性系列"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("05 - 书评 & 影评"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
          FutureBuilder(
              future: decodeTypeList("待分类"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MyHomeBody(snapshot.data);
                } else {
                  return const Center(
                    child: Text("加载中..."),
                  );
                }
              }),
        ]),
      ),
    ),
  );
}

class SearchBarDelegate extends SearchDelegate<String> {
  // 搜索条右侧的按钮执行方法，我们在这里方法里放入一个clear图标。 当点击图片时，清空搜索的内容。
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          // 清空搜索内容
          query = "";
        },
      )
    ];
  }

  // 搜索栏左侧的图标和功能，点击时关闭整个搜索页面
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, "");
      },
    );
  }

  // 搜索到内容了
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder(
            future: SearchList(query),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                ArticleList xx = snapshot.data;
                if (xx.memberList!.isEmpty) {
                  return const Center(
                    child: Text("搜索无结果..."),
                  );
                } else {
                  return MyHomeBody(snapshot.data);
                }
              } else {
                return const Center(
                  child: Text("加载中..."),
                );
              }
            }),
      ),
    );
  }

  // 输入时的推荐及搜索结果
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        recentList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        // 创建一个富文本，匹配的内容特别显示
        return ListTile(
          title: RichText(
              text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ],
          )),
          onTap: () {
            query = suggestionList[index];
            //Scaffold.of(context).showSnackBar(SnackBar(content: Text("")));
          },
        );
      },
    );
  }
}

const recentList = [
  "爱到底是什么",
];

class Serch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: SearchBarDelegate());
          print('search....');
        });
  }
}

class fav extends StatefulWidget {
  fav({String? s, Key? key}) : super(key: key) {
    title = s;
  }

  String? title;

  @override
  State<fav> createState() => _favState(title);
}

class _favState extends State<fav> {
  Icon ic = const Icon(Icons.star_border);
  String? title;
  _favState(String? s) {
    title = s;
    get();
  }
  Future<String> get() async {
    var userName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(title!);
    if (userName == "true") {
      setState(() {
        ic = const Icon(Icons.star);
      });
      return "true";
    } else {
      return "false";
    }
  }

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(title!, "true");
  }

  cle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(title!);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: ic,
        onPressed: () {
          final prefs = SharedPreferences.getInstance();
          if (ic.icon == Icons.star_border) {
            save();
            setState(() {
              ic = const Icon(Icons.star);
            });
            Scaffold.of(context)
                // ignore: deprecated_member_use
                .showSnackBar(const SnackBar(
                    duration: Duration(milliseconds: 800),
                    content: Text("已收藏")));
          } else {
            cle();
            setState(() {
              ic = const Icon(Icons.star_border);
            });
            Scaffold.of(context)
                // ignore: deprecated_member_use
                .showSnackBar(const SnackBar(
                    duration: Duration(milliseconds: 800),
                    content: Text("取消收藏")));
          }
        });
  }
}

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);
  Future<ArticleList> get() async {
    var userName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getKeys();
    return FavList(userName);
  }

  Future<ArticleList> getan(Set<String> userName) async {
    return FavList(userName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const UserAccountsDrawerHeader(
            accountName: const Text("Caritas App 1.0"),
            accountEmail: const Text("公众号 予你告白"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: const AssetImage("md/3.png"),
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: const AssetImage("md/2.png"), fit: BoxFit.cover))),
        ListTile(
            title: const Text("收藏"),
            leading: const CircleAvatar(child: Icon(Icons.star_border_rounded)),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("我的收藏"),
                  ),
                  body: FutureBuilder(
                      future: get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          ArticleList xx = snapshot.data;
                          if (xx.memberList!.isEmpty) {
                            return const Center(
                              child: Text("还没有收藏..."),
                            );
                          } else {
                            return MyHomeBody(snapshot.data);
                          }
                        } else {
                          return const Center(
                            child: Text("加载中..."),
                          );
                        }
                      }),
                );
              }));
            }),
        ExpansionTile(
          title: Text('药方'), //闭合时的标题
          leading: CircleAvatar(child: Icon(Icons.medication)),
          backgroundColor: Colors.white24, //闭合时的颜色
          children: <Widget>[
            //展开时子部件
            ListTile(
              title: Text('如何面对抑郁'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  Set<String> xx = Set<String>();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("如何面对抑郁"),
                    ),
                    body: FutureBuilder(
                        future: getan(Set<String>()
                          ..add("悲观与乐观.md")
                          ..add("缺爱者的自救.md")
                          ..add("对人类失望.md")
                          ..add("双相情感障碍.md")
                          ..add("痛苦根源.md")
                          ..add("耽误了五六年.md")
                          ..add("一事无成.md")
                          ..add("懒散.md")
                          ..add("正常.md")
                          ..add("自我怀疑.md")
                          ..add("TOUGHNESS.md")
                          ..add("忙起来.md")
                          ..add("战胜抑郁.md")
                          ..add("抑郁的潮.md")
                          ..add("疗愈艺术.md")
                          ..add("报复社会.md")
                          ..add("缺爱.md")
                          ..add("丧的本质.md")
                          ..add("谈谈文化性抑郁.md")
                          ..add("负面沉浸.md")
                          ..add("苦熬1.md")
                          ..add("苦熬2.md")
                          ..add("万念俱灰.md")
                          ..add("玻璃心.md")
                          ..add("穿越幽谷.md")
                          ..add("社恐.md")
                          ..add("反刍痛苦.md")
                          ..add("逃避伤害.md")
                          ..add("送你一句话.md")
                          ..add("气质高贵.md")
                          ..add("怨恨.md")
                          ..add("脱困.md")
                          ..add("如何活.md")
                          ..add("自卑.md")
                          ..add("克服自卑.md")
                          ..add("不可论断人.md")
                          ..add("被讨厌.md")
                          ..add("少小离家老大回.md")
                          ..add("想太多.md")),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return MyHomeBody(snapshot.data);
                          } else {
                            return const Center(
                              child: Text("加载中..."),
                            );
                          }
                        }),
                  );
                }));
              },
            ),

            ListTile(
              title: Text('不破灭的爱情'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  Set<String> xx = Set<String>();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("不破灭的爱情"),
                    ),
                    body: FutureBuilder(
                        future: getan(Set<String>()
                          ..add("恋爱原理.md")
                          ..add("重组家庭的难题.md")
                          ..add("事业已定.md")
                          ..add("爱的自由.md")
                          ..add("走到一起.md")
                          ..add("温柔.md")
                          ..add("男女间的纯洁.md")
                          ..add("性感.md")
                          ..add("性感男人.md")
                          ..add("爱怕了.md")
                          ..add("沉鱼落雁.md")
                          ..add("收入管理共识.md")
                          ..add("结婚条件.md")
                          ..add("爱的好处.md")
                          ..add("反接盘.md")
                          ..add("幼稚女生.md")
                          ..add("戒掉喜欢.md")
                          ..add("苦而不忍.md")
                          ..add("要的是啥 - 男人.md")
                          ..add("要的是啥 - 女人.md")
                          ..add("求偶烧钱.md")
                          ..add("大男子主义.md")
                          ..add("灵魂伴侣.md")
                          ..add("不好花钱.md")
                          ..add("贞操无价.md")
                          ..add("进化心理学.md")
                          ..add("因爱生恨.md")
                          ..add("门当户对.md")
                          ..add("防早恋.md")
                          ..add("安全感.md")
                          ..add("公开换安全.md")
                          ..add("下药.md")
                          ..add("热烈和长久.md")
                          ..add("女生不讲理.md")
                          ..add("情侣话题.md")
                          ..add("快餐式.md")
                          ..add("心猿意马.md")
                          ..add("可爱 - Loveable.md")
                          ..add("前途与爱情.md")
                          ..add("性.md")
                          ..add("离婚要事.md")
                          ..add("爱情 - Romance.md")
                          ..add("紧追不放.md")
                          ..add("不可论断人.md")
                          ..add("黄色玩笑1.md")
                          ..add("美人无困扰.md")
                          ..add("萌.md")
                          ..add("值得一嫁.md")
                          ..add("伤害应对.md")
                          ..add("知止.md")
                          ..add("先轻信后多疑.md")
                          ..add("优秀与被爱.md")
                          ..add("吸引力.md")
                          ..add("丑.md")
                          ..add("获美.md")
                          ..add("不喜欢.md")
                          ..add("别互补.md")
                          ..add("危险迹象.md")
                          ..add("爱无筹码.md")
                          ..add("最高效途径.md")
                          ..add("缺爱症.md")
                          ..add("身价.md")
                          ..add("占有欲.md")
                          ..add("别互补.md")
                          ..add("高级妩媚感.md")
                          ..add("第一次.md")
                          ..add("黄色玩笑.md")
                          ..add("拿号去.md")
                          ..add("大叔控.md")
                          ..add("挑水果.md")
                          ..add("绝对安全.md")
                          ..add("无伤大雅的承诺.md")
                          ..add("所托非人.md")
                          ..add("赔我啥.md")
                          ..add("渣起来.md")
                          ..add("喜欢.md")
                          ..add("性道德.md")
                          ..add("幸福感.md")
                          ..add("为“爱”妥协.md")
                          ..add("爱与自由.md")
                          ..add("临终一面.md")
                          ..add("爱得痛苦.md")
                          ..add("情感挽回大师.md")
                          ..add("亲近.md")
                          ..add("专职主内.md")
                          ..add("凭爱分手.md")
                          ..add("无目的.md")
                          ..add("爱你的仇敌.md")
                          ..add("强奸.md")
                          ..add("何如不问.md")
                          ..add("脱困.md")
                          ..add("强奸.md")
                          ..add("各归各.md")
                          ..add("崇高爱情.md")
                          ..add("谈恋爱.md")
                          ..add("真爱.md")
                          ..add("我需要ta.md")
                          ..add("感情测试.md")
                          ..add("结什么果.md")
                          ..add("教养.md")
                          ..add("为何对你好.md")
                          ..add("BoyzIIMen.md")),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return MyHomeBody(snapshot.data);
                          } else {
                            return const Center(
                              child: Text("加载中..."),
                            );
                          }
                        }),
                  );
                }));
              },
            ),

            ListTile(
              title: Text('爱是什么'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  Set<String> xx = Set<String>();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Caritas之路"),
                    ),
                    body: FutureBuilder(
                        future: getan(Set<String>()
                          ..add("爱.md")
                          ..add("善良程度.md")
                          ..add("以弱悯强.md")
                          ..add("有重要的善良.md")
                          ..add("温柔.md")
                          ..add("农夫与蛇.md")
                          ..add("恩.md")
                          ..add("授人以鱼.md")
                          ..add("善良与现实.md")
                          ..add("讨好型人格.md")
                          ..add("被讨厌.md")
                          ..add("教养.md")
                          ..add("怒的边界.md")
                          ..add("爱情 - Romance.md")
                          ..add("爱与自由.md")
                          ..add("爱与神哲学.md")
                          ..add("主动的被动.md")
                          ..add("双相情感障碍.md")
                          ..add("无爱信仰.md")
                          ..add("理性的爱.md")
                          ..add("不配被爱.md")
                          ..add("优秀与被爱.md")
                          ..add("自爱.md")
                          ..add("缺爱症.md")
                          ..add("无条件的爱.md")
                          ..add("先于且高于一切.md")
                          ..add("看得见爱的眼睛.md")
                          ..add("爱你的仇敌.md")
                          ..add("因爱生恨.md")
                          ..add("可爱.md")
                          ..add("最重要的能力.md")
                          ..add("爱国.md")
                          ..add("脱困.md")
                          ..add("晚景凄凉.md")
                          ..add("留门.md")
                          ..add("爱无筹码.md")
                          ..add("被讨厌.md")
                          ..add("谴责恶行.md")
                          ..add("自卑.md")
                          ..add("平庸.md")
                          ..add("财富观.md")
                          ..add("爱与欲望.md")
                          ..add("爱得痛苦.md")
                          ..add("爱是由什么产生的.md")
                          ..add("崇高爱情.md")
                          ..add("爱的实践.md")
                          ..add("爱与智慧.md")
                          ..add("可爱.md")
                          ..add("同性恋出路.md")
                          ..add("恋爱的意义.md")
                          ..add("自传.md")
                          ..add("缺爱.md")
                          ..add("归属感.md")
                          ..add("你如何表达爱.md")
                          ..add("劝人.md")
                          ..add("少小离家老大回.md")
                          ..add("你如何表达爱.md")
                          ..add("不可论断人.md")
                          ..add("重组家庭的难题.md")
                          ..add("缺爱者的自救.md")
                          ..add("面子.md")
                          ..add("爱国爱党.md")
                          ..add("爱和理解哪个更重要.md")),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return MyHomeBody(snapshot.data);
                          } else {
                            return const Center(
                              child: Text("加载中..."),
                            );
                          }
                        }),
                  );
                }));
              },
            ),

            ListTile(
              title: Text('面对校园欺凌'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  Set<String> xx = Set<String>();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("面对校园欺凌"),
                    ),
                    body: FutureBuilder(
                        future: getan(Set<String>()
                          ..add("举报.md")
                          ..add("被讨厌.md")
                          ..add("初中生.md")
                          ..add("幼年负轭.md")
                          ..add("气质高贵.md")
                          ..add("校服.md")
                          ..add("情绪失控的孩子.md")
                          ..add("TOUGHNESS.md")
                          ..add("反欺凌.md")),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return MyHomeBody(snapshot.data);
                          } else {
                            return const Center(
                              child: Text("加载中..."),
                            );
                          }
                        }),
                  );
                }));
              },
            ),

            ListTile(
              title: Text('如何看待贫穷'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  Set<String> xx = Set<String>();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("如何看待贫穷"),
                    ),
                    body: FutureBuilder(
                        future: getan(Set<String>()
                          ..add("财富观.md")
                          ..add("有钱人.md")
                          ..add("摆脱贫穷.md")
                          ..add("瞧不起.md")
                          ..add("家里不富裕.md")
                          ..add("穷得没尊严.md")
                          ..add("穷开心.md")
                          ..add("仇穷与仇富.md")
                          ..add("虚荣.md")
                          ..add("面子.md")
                          ..add("低贱的事情.md")
                          ..add("几代人的努力.md")
                          ..add("生而贫穷.md")
                          ..add("贫穷.md")),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return MyHomeBody(snapshot.data);
                          } else {
                            return const Center(
                              child: Text("加载中..."),
                            );
                          }
                        }),
                  );
                }));
              },
            ),
          ],
          initiallyExpanded: true, //初始状态为闭合状态(默认状态)
        )
      ],
    );
  }
}
