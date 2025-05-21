import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_test/domain/models/notes.dart';
import 'package:notes_test/presentation/theme/theme.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ItemNote({
    super.key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yy');
    final String formattedDate = formatter.format(note.createdAt);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.orange,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: AppText.t16rw.copyWith(color: AppColor.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: AppText.t14rb
                      .copyWith(color: AppColor.white.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    note.summary,
                    style: AppText.t14rb.copyWith(color: AppColor.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onEdit != null)
                  IconButton(
                    icon:
                        const Icon(Icons.edit_outlined, color: AppColor.white),
                    onPressed: onEdit,
                    tooltip: 'Редактировать',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                if (onDelete != null)
                  IconButton(
                    icon:
                        const Icon(Icons.delete_outline, color: AppColor.white),
                    onPressed: onDelete,
                    tooltip: 'Удалить',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
