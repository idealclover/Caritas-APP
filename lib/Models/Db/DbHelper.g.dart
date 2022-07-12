// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DbHelper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      title: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 1;

  @override
  Article read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Article(
      id: fields[0] as String,
      title: fields[1] as String,
      question: fields[2] as String,
      content: fields[3] as String,
      zhihuLink: fields[4] as String,
      author: fields[5] as String,
      tags: (fields[6] as List).cast<String>(),
      links: (fields[7] as List).cast<String>(),
      categories: (fields[8] as List).cast<String>(),
      lastUpdate: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.zhihuLink)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.links)
      ..writeByte(8)
      ..write(obj.categories)
      ..writeByte(9)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
