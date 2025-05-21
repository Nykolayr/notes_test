part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isLoading;
  final String error;
  final bool isListChange;
  final List<Note> notes;
  final Note currentNote;
  final List<Note> notesFiltered;

  const MainState({
    required this.isLoading,
    required this.error,
    required this.isListChange,
    required this.notes,
    required this.currentNote,
    required this.notesFiltered,
  });

  MainState copyWith({
    bool? isLoading,
    String? error,
    bool? isListChange,
    List<Note>? notes,
    Note? currentNote,
    List<Note>? notesFiltered,
  }) {
    isListChange = notes != null && notesFiltered != null;
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isListChange: isListChange,
      notes: notes ?? this.notes,
      currentNote: currentNote ?? this.currentNote,
      notesFiltered: notesFiltered ?? this.notesFiltered,
    );
  }

  factory MainState.initial() => MainState(
        isLoading: false,
        error: '',
        isListChange: false,
        notes: Get.find<MainRepository>().notes,
        currentNote: Note.initial(),
        notesFiltered: Get.find<MainRepository>().notes,
      );

  @override
  List<Object?> get props =>
      [isLoading, error, isListChange, notes, currentNote, notesFiltered];
}
