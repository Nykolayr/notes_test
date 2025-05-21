import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:notes_test/domain/models/notes.dart';
import 'package:notes_test/presentation/theme/theme.dart';
import 'package:notes_test/presentation/widgets/buttons.dart';

class NoteDetailsModalContent extends StatelessWidget {
  final Note note;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const NoteDetailsModalContent({
    super.key,
    required this.note,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
    final String formattedDate = formatter.format(note.createdAt);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Детали заметки',
              style: AppText.t16rw.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Gap(20),
          Text(
            'Заголовок:',
            style: AppText.t14rb
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Text(
            note.title,
            style: AppText.t16rw.copyWith(color: AppColor.greyText),
          ),
          const Gap(16),
          Text(
            'Текст заметки:',
            style: AppText.t14rb
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Flexible(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: Text(
                  note.summary,
                  style: AppText.t16rw.copyWith(color: AppColor.greyText),
                ),
              ),
            ),
          ),
          const Gap(16),
          Text(
            'Дата создания:',
            style: AppText.t14rb
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Text(
            formattedDate,
            style: AppText.t16rw.copyWith(color: AppColor.greyText),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: ButtonWide(
                  text: 'Редактировать',
                  onPressed: onEditPressed, // Используем переданный колбэк
                ),
              ),
              const Gap(10),
              Expanded(
                child: ButtonWide(
                  text: 'Удалить',
                  onPressed: onDeletePressed, // Используем переданный колбэк
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
