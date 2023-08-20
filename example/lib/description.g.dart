// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description.dart';

// **************************************************************************
// CopyableGenerator
// **************************************************************************

class Note {
  final int id;
  final String title;
  final String author;
  final String text;
  final String? description;
  final String? category;

  const Note({
    required this.id,
    required this.title,
    required this.author,
    required this.text,
    required this.description,
    required this.category,
  });

  Note copyWith({
    int? id,
    String? title,
    String? author,
    String? text,
    String? description,
    bool resetDescription = false,
    String? category,
    bool resetCategory = false,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      text: text ?? this.text,
      description: resetDescription ? description ?? this.description : null,
      category: resetCategory ? category ?? this.category : null,
    );
  }
}

class Person {
  final String name;
  final String surname;
  final DateTime birthday;

  const Person({
    required this.name,
    required this.surname,
    required this.birthday,
  });

  Person copyWith({
    String? name,
    String? surname,
    DateTime? birthday,
  }) {
    return Person(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthday: birthday ?? this.birthday,
    );
  }
}
