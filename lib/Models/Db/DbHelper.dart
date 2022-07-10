import 'dart:io';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'DbHelper.g.dart';

@DataClassName('Article')
class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get path => text().nullable()();
  TextColumn get question => text()();
  TextColumn get zhihuLink => text()();
  TextColumn get author => text()();
  TextColumn get tags => text().nullable()();
  TextColumn get links => text().nullable()();
  TextColumn get lastUpdate => text()();
  TextColumn get content => text()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get contents => text()();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Articles])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  // loads all articles
  Future<List<Article>> get allArticles => select(articles).get();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}