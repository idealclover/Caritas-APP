// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DbHelper.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Article extends DataClass implements Insertable<Article> {
  final int id;
  final String title;
  final String path;
  final String question;
  final String zhihuLink;
  final String author;
  final String tags;
  final String links;
  final String lastUpdate;
  final String content;
  Article(
      {required this.id,
      required this.title,
      required this.path,
      required this.question,
      required this.zhihuLink,
      required this.author,
      required this.tags,
      required this.links,
      required this.lastUpdate,
      required this.content});
  factory Article.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Article(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      path: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}path'])!,
      question: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}question'])!,
      zhihuLink: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zhihu_link'])!,
      author: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author'])!,
      tags: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tags'])!,
      links: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}links'])!,
      lastUpdate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_update'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['path'] = Variable<String>(path);
    map['question'] = Variable<String>(question);
    map['zhihu_link'] = Variable<String>(zhihuLink);
    map['author'] = Variable<String>(author);
    map['tags'] = Variable<String>(tags);
    map['links'] = Variable<String>(links);
    map['last_update'] = Variable<String>(lastUpdate);
    map['content'] = Variable<String>(content);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      title: Value(title),
      path: Value(path),
      question: Value(question),
      zhihuLink: Value(zhihuLink),
      author: Value(author),
      tags: Value(tags),
      links: Value(links),
      lastUpdate: Value(lastUpdate),
      content: Value(content),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      path: serializer.fromJson<String>(json['path']),
      question: serializer.fromJson<String>(json['question']),
      zhihuLink: serializer.fromJson<String>(json['zhihuLink']),
      author: serializer.fromJson<String>(json['author']),
      tags: serializer.fromJson<String>(json['tags']),
      links: serializer.fromJson<String>(json['links']),
      lastUpdate: serializer.fromJson<String>(json['lastUpdate']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'path': serializer.toJson<String>(path),
      'question': serializer.toJson<String>(question),
      'zhihuLink': serializer.toJson<String>(zhihuLink),
      'author': serializer.toJson<String>(author),
      'tags': serializer.toJson<String>(tags),
      'links': serializer.toJson<String>(links),
      'lastUpdate': serializer.toJson<String>(lastUpdate),
      'content': serializer.toJson<String>(content),
    };
  }

  Article copyWith(
          {int? id,
          String? title,
          String? path,
          String? question,
          String? zhihuLink,
          String? author,
          String? tags,
          String? links,
          String? lastUpdate,
          String? content}) =>
      Article(
        id: id ?? this.id,
        title: title ?? this.title,
        path: path ?? this.path,
        question: question ?? this.question,
        zhihuLink: zhihuLink ?? this.zhihuLink,
        author: author ?? this.author,
        tags: tags ?? this.tags,
        links: links ?? this.links,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('question: $question, ')
          ..write('zhihuLink: $zhihuLink, ')
          ..write('author: $author, ')
          ..write('tags: $tags, ')
          ..write('links: $links, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, path, question, zhihuLink, author,
      tags, links, lastUpdate, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.title == this.title &&
          other.path == this.path &&
          other.question == this.question &&
          other.zhihuLink == this.zhihuLink &&
          other.author == this.author &&
          other.tags == this.tags &&
          other.links == this.links &&
          other.lastUpdate == this.lastUpdate &&
          other.content == this.content);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> path;
  final Value<String> question;
  final Value<String> zhihuLink;
  final Value<String> author;
  final Value<String> tags;
  final Value<String> links;
  final Value<String> lastUpdate;
  final Value<String> content;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.path = const Value.absent(),
    this.question = const Value.absent(),
    this.zhihuLink = const Value.absent(),
    this.author = const Value.absent(),
    this.tags = const Value.absent(),
    this.links = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.content = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String path,
    required String question,
    required String zhihuLink,
    required String author,
    required String tags,
    required String links,
    required String lastUpdate,
    required String content,
  })  : title = Value(title),
        path = Value(path),
        question = Value(question),
        zhihuLink = Value(zhihuLink),
        author = Value(author),
        tags = Value(tags),
        links = Value(links),
        lastUpdate = Value(lastUpdate),
        content = Value(content);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? path,
    Expression<String>? question,
    Expression<String>? zhihuLink,
    Expression<String>? author,
    Expression<String>? tags,
    Expression<String>? links,
    Expression<String>? lastUpdate,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (path != null) 'path': path,
      if (question != null) 'question': question,
      if (zhihuLink != null) 'zhihu_link': zhihuLink,
      if (author != null) 'author': author,
      if (tags != null) 'tags': tags,
      if (links != null) 'links': links,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (content != null) 'content': content,
    });
  }

  ArticlesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? path,
      Value<String>? question,
      Value<String>? zhihuLink,
      Value<String>? author,
      Value<String>? tags,
      Value<String>? links,
      Value<String>? lastUpdate,
      Value<String>? content}) {
    return ArticlesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      question: question ?? this.question,
      zhihuLink: zhihuLink ?? this.zhihuLink,
      author: author ?? this.author,
      tags: tags ?? this.tags,
      links: links ?? this.links,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (zhihuLink.present) {
      map['zhihu_link'] = Variable<String>(zhihuLink.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (links.present) {
      map['links'] = Variable<String>(links.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<String>(lastUpdate.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('question: $question, ')
          ..write('zhihuLink: $zhihuLink, ')
          ..write('author: $author, ')
          ..write('tags: $tags, ')
          ..write('links: $links, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String?> path = GeneratedColumn<String?>(
      'path', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _questionMeta = const VerificationMeta('question');
  @override
  late final GeneratedColumn<String?> question = GeneratedColumn<String?>(
      'question', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _zhihuLinkMeta = const VerificationMeta('zhihuLink');
  @override
  late final GeneratedColumn<String?> zhihuLink = GeneratedColumn<String?>(
      'zhihu_link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String?> author = GeneratedColumn<String?>(
      'author', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String?> tags = GeneratedColumn<String?>(
      'tags', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _linksMeta = const VerificationMeta('links');
  @override
  late final GeneratedColumn<String?> links = GeneratedColumn<String?>(
      'links', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastUpdateMeta = const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<String?> lastUpdate = GeneratedColumn<String?>(
      'last_update', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        path,
        question,
        zhihuLink,
        author,
        tags,
        links,
        lastUpdate,
        content
      ];
  @override
  String get aliasedName => _alias ?? 'articles';
  @override
  String get actualTableName => 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('zhihu_link')) {
      context.handle(_zhihuLinkMeta,
          zhihuLink.isAcceptableOrUnknown(data['zhihu_link']!, _zhihuLinkMeta));
    } else if (isInserting) {
      context.missing(_zhihuLinkMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('links')) {
      context.handle(
          _linksMeta, links.isAcceptableOrUnknown(data['links']!, _linksMeta));
    } else if (isInserting) {
      context.missing(_linksMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Article.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ArticlesTable articles = $ArticlesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articles];
}
