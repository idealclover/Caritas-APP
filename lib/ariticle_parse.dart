import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import './model/article.dart';

Future<String> _loadMemberJson() async {
  return await rootBundle.loadString('md/data.json');
}

Future<ArticleList> decodeMemberList() async {
  String memberListJson = await _loadMemberJson();

  List<dynamic> list = json.decode(memberListJson);

  ArticleList memberList = ArticleList.fromJson(list);

  memberList.memberList!
      .forEach((member) => print('member name is ${member.Title}'));

  return memberList;
}

Future<ArticleList> decodeTypeList(String? type) async {
  String memberListJson = await _loadMemberJson();

  List<dynamic> list = json.decode(memberListJson);

  ArticleList memberList = ArticleList.fromJson(list);
  List<Article>? TypeList = <Article>[];

  memberList.memberList!.forEach((element) {
    if (element.Path == type) {
      TypeList.add(element);
    }
  });

  memberList.memberList = TypeList;

  return memberList;
}

Future<ArticleList> SearchList(String? type) async {
  String memberListJson = await _loadMemberJson();

  List<dynamic> list = json.decode(memberListJson);

  ArticleList memberList = ArticleList.fromJson(list);
  List<Article>? TypeList = <Article>[];

  memberList.memberList!.forEach((element) {
    if (element.Content!.contains(type!)) {
      TypeList.add(element);
    }
  });

  memberList.memberList = TypeList;

  return memberList;
}

Future<ArticleList> FavList(Set<String>? type) async {
  String memberListJson = await _loadMemberJson();

  List<dynamic> list = json.decode(memberListJson);

  ArticleList memberList = ArticleList.fromJson(list);
  List<Article>? TypeList = <Article>[];

  memberList.memberList!.forEach((element) {
    for (String item in type!) {
      if (element.Title! == (item)) {
        TypeList.add(element);
        print(item);
      } else {}
    }
  });

  memberList.memberList = TypeList;

  return memberList;
}
