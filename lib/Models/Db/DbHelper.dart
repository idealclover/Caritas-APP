import 'package:drift/drift.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'DbHelper.g.dart';

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get path => text()();
  TextColumn get question => text()();
  TextColumn get zhihuLink => text()();
  TextColumn get author => text()();
  TextColumn get tags => text()();
  TextColumn get links => text()();
  TextColumn get lastUpdate => text()();
  TextColumn get content => text()();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Articles])
class MyDatabase extends _$MyDatabase {
  MyDatabase(super.e);

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}