import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:get/get.dart';
import 'package:notes_test/domain/models/notes.dart';
import 'package:notes_test/domain/repository/main_repository.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<NewNoteEvent>(_onNewNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<CreateNewNoteEvent>(_onCreateNewNoteEvent);
    on<SelectNoteEvent>(_onSelectNoteEvent);
    on<FilterNotesEvent>(_onFilterNotesEvent);
    on<SortNotesEvent>(_onSortNotesEvent);
    on<SortNotesByDateEvent>(_onSortNotesByDateEvent);
  }

  /// сортировка заметок
  void _onSortNotesEvent(SortNotesEvent event, Emitter<MainState> emit) {
    final notes = Get.find<MainRepository>().notes.toList();
    notes.sort((a, b) => event.isAscending
        ? a.title.compareTo(b.title)
        : b.title.compareTo(a.title));
    emit(state.copyWith(notesFiltered: notes));
  }

  /// сортировка заметок по дате
  void _onSortNotesByDateEvent(
      SortNotesByDateEvent event, Emitter<MainState> emit) {
    final notes = Get.find<MainRepository>().notes.toList();
    notes.sort((a, b) => event.isAscending
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
    emit(state.copyWith(notesFiltered: notes));
  }

  /// фильтрация заметок
  void _onFilterNotesEvent(FilterNotesEvent event, Emitter<MainState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(notesFiltered: Get.find<MainRepository>().notes));
    } else {
      emit(state.copyWith(
          notesFiltered: Get.find<MainRepository>()
              .notes
              .where((element) => element.title.contains(event.query))
              .toList()));
    }
  }

  /// выбор заметки
  void _onSelectNoteEvent(SelectNoteEvent event, Emitter<MainState> emit) {
    final note = Get.find<MainRepository>()
        .notes
        .firstWhere((element) => element.id == event.id);
    emit(state.copyWith(currentNote: note));
  }

  /// создание новой заметки
  void _onCreateNewNoteEvent(
      CreateNewNoteEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(currentNote: Note.initial()));
  }

  /// записываем новую заметку
  void _onNewNoteEvent(NewNoteEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Get.find<MainRepository>().addNote(event.note);
    emit(state.copyWith(
        isLoading: false, notes: Get.find<MainRepository>().notes));
  }

  /// обновление заметки
  void _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Get.find<MainRepository>().updateNote(event.note);
    emit(state.copyWith(
        isLoading: false, notes: Get.find<MainRepository>().notes));
  }

  /// удаление заметки
  void _onDeleteNoteEvent(
      DeleteNoteEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Get.find<MainRepository>().deleteNote(event.id);
    emit(state.copyWith(
        isLoading: false, notes: Get.find<MainRepository>().notes));
  }
}
