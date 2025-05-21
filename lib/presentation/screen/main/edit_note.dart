import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:notes_test/domain/models/notes.dart';
import 'package:notes_test/domain/routers/routers.dart';
import 'package:notes_test/presentation/screen/main/bloc/main_bloc.dart';
import 'package:notes_test/presentation/theme/theme.dart';
import 'package:notes_test/presentation/widgets/app_bar.dart';
import 'package:notes_test/presentation/widgets/buttons.dart';
import 'package:notes_test/presentation/widgets/text_fields.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final controllerTitle = TextEditingController();
  final controllerText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  MainBloc bloc = Get.find<MainBloc>();
  bool isNew = false;
  Note note = Note.initial();

  @override
  void initState() {
    isNew = bloc.state.currentNote.id == -1;
    note = bloc.state.currentNote;

    super.initState();
    controllerTitle.text = note.title;
    controllerText.text = note.summary;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.background,
        resizeToAvoidBottomInset: true,
        bottomSheet: Padding(
          padding: const EdgeInsets.all(20),
          child: ButtonWide(
            text: 'Сохранить',
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                note = note.copyWith(
                  title: controllerTitle.text,
                  summary: controllerText.text,
                  createdAt: isNew ? DateTime.now() : note.createdAt,
                );
                Logger.i('сохранение заметки: ${note.toJson()}');
                if (isNew) {
                  bloc.add(NewNoteEvent(note));
                } else {
                  bloc.add(UpdateNoteEvent(note));
                }
                router.pop();
              }
            },
          ),
        ),
        appBar: AppBarBazi(
          title: isNew ? 'Новая заметка' : 'Редактирование заметки',
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(100),
                NotesTextField(
                  controller: controllerTitle,
                  hintText: 'Заголовок заметки',
                ),
                const Gap(20),
                NotesTextField(
                  controller: controllerText,
                  hintText: 'Текст заметки',
                  isMultiLine: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
