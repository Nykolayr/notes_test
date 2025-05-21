import 'package:notes_test/domain/routers/routers.dart';
import 'package:notes_test/presentation/screen/main/bloc/main_bloc.dart';
import 'package:notes_test/presentation/screen/main/item_note.dart';
import 'package:notes_test/presentation/theme/colors.dart';
import 'package:notes_test/presentation/theme/text.dart';
import 'package:notes_test/presentation/widgets/app_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_test/domain/models/notes.dart';
import 'package:notes_test/presentation/screen/main/modal_note.dart';
import 'package:notes_test/presentation/widgets/search_fields.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  MainBloc bloc = Get.find<MainBloc>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.orange,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showNoteDetailsModal(BuildContext context, Note note) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext modalContext) {
        return NoteDetailsModalContent(
          note: note,
          onEditPressed: () {
            Navigator.pop(modalContext);
            bloc.add(SelectNoteEvent(note.id));
            router.goNamed('editNote', extra: {'isNew': false});
          },
          onDeletePressed: () {
            Navigator.pop(modalContext);
            bloc.add(DeleteNoteEvent(note.id));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<MainBloc, MainState>(
          bloc: bloc,
          builder: (context, state) {
            final bool isSearchingOrFiltered =
                state.notes.length != state.notesFiltered.length ||
                    (state.notes.length == state.notesFiltered.length &&
                        state.notes.isNotEmpty &&
                        state.notesFiltered.isNotEmpty &&
                        state.notes.first.id != state.notesFiltered.first.id);

            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColor.background,
              resizeToAvoidBottomInset: true,
              appBar: const AppBarBazi(
                isBack: false,
                title: 'Заметки',
                isRight: true,
              ),
              body: Stack(
                children: [
                  if (state.notesFiltered.isEmpty && !state.isLoading) ...[
                    Center(
                      child: Text(
                        (state.notes.isNotEmpty && isSearchingOrFiltered)
                            ? 'Ничего не найдено'
                            : 'Заметок еще нет',
                        style: AppText.t16rw.copyWith(color: AppColor.orange),
                      ),
                    )
                  ] else if (state.notesFiltered.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 0),
                      child: ListView.builder(
                        itemCount: state.notesFiltered.length,
                        itemBuilder: (context, index) {
                          final note = state.notesFiltered[index];
                          return ItemNote(
                            note: note,
                            onTap: () {
                              _showNoteDetailsModal(context, note);
                            },
                            onEdit: () async {
                              FocusScope.of(context).unfocus();
                              bloc.add(SelectNoteEvent(note.id));
                              await Future.delayed(
                                  const Duration(milliseconds: 100));
                              router
                                  .goNamed('editNote', extra: {'isNew': false});
                            },
                            onDelete: () {
                              FocusScope.of(context).unfocus();
                              bloc.add(DeleteNoteEvent(note.id));
                            },
                          );
                        },
                      ),
                    )
                  ],
                  if (state.isLoading) ...[
                    const Center(
                        child: CircularProgressIndicator(color: AppColor.white))
                  ],
                ],
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: 'addNoteFab',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  bloc.add(CreateNewNoteEvent());
                  router.goNamed('editNote', extra: {'isNew': true});
                },
                backgroundColor: AppColor.orange,
                tooltip: 'Добавить заметку',
                child: const Icon(Icons.add, color: AppColor.white, size: 32),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const SearchTextField(),
              ),
            );
          }),
    );
  }
}
