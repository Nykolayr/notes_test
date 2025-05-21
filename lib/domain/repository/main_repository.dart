import 'dart:async';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:notes_test/data/local_data.dart';
import 'package:notes_test/domain/models/notes.dart';

/// репо  для всего приложения
class MainRepository {
  List<Note> notes = [];

  static final MainRepository _instance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository() => _instance;

  /// Начальная загрузка
  Future init() async {
    await getNotesLocal();
  }

  /// Получение заметок
  Future<void> getNotesLocal() async {
    try {
      final data = await LocalData.loadListJson(key: LocalDataKey.notes);

      if (data.isNotEmpty && data.first['error'] == null) {
        notes = data.map((e) => Note.fromJson(e)).toList();
      } else {
        await saveNotesToLocal();
      }
    } catch (e) {
      Logger.e('загрузка заметок ошибка: $e');
      throw Exception('загрузка заметок ошибка: $e');
    }
  }

  /// сохранение заметок в локальное хранилище
  Future<void> saveNotesToLocal() async {
    Logger.i('сохранение заметок в локальное хранилище ${notes.length}');
    await LocalData.saveListJson(
        json: notes.map((e) => e.toJson()).toList(), key: LocalDataKey.notes);
  }

  /// добавление заметки
  Future<void> addNote(Note note) async {
    try {
      note = note.copyWith(id: notes.length);
      notes.add(note);
      Logger.i('добавление заметки: ${note.toJson()}');
      await saveNotesToLocal();
    } catch (e) {
      Logger.e('добавление заметки ошибка: $e');
    }
  }

  /// обновление заметки
  Future<void> updateNote(Note note) async {
    try {
      int index = notes.indexWhere((element) => element.id == note.id);
      notes[index] = notes[index].copyWith(
        title: note.title,
        summary: note.summary,
        createdAt: note.createdAt,
      );
      await saveNotesToLocal();
    } catch (e) {
      Logger.e('обновление заметки ошибка: $e');
    }
  }

  /// удаление заметки
  Future<void> deleteNote(int id) async {
    try {
      int index = notes.indexWhere((element) => element.id == id);
      notes.removeAt(index);
      await saveNotesToLocal();
    } catch (e) {
      Logger.e('удаление заметки ошибка: $e');
    }
  }
}
