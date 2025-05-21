part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

/// сортировка заметок по дате
class SortNotesByDateEvent extends MainEvent {
  final bool isAscending;
  const SortNotesByDateEvent(this.isAscending);
}

/// сортировка заметок
class SortNotesEvent extends MainEvent {
  final bool isAscending;
  const SortNotesEvent(this.isAscending);
}

/// поиск заметок
class FilterNotesEvent extends MainEvent {
  final String query;
  const FilterNotesEvent(this.query);
}

/// выбор заметки
class SelectNoteEvent extends MainEvent {
  final int id;
  const SelectNoteEvent(this.id);
}

/// создание новой заметки
class CreateNewNoteEvent extends MainEvent {}

/// записываем новую заметку
class NewNoteEvent extends MainEvent {
  final Note note;
  const NewNoteEvent(this.note);
}

/// обновление заметки
class UpdateNoteEvent extends MainEvent {
  final Note note;
  const UpdateNoteEvent(this.note);
}

/// удаление заметки
class DeleteNoteEvent extends MainEvent {
  final int id;
  const DeleteNoteEvent(this.id);
}
