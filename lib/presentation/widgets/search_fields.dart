import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Импортируем Get для доступа к BLoC
import 'package:notes_test/presentation/screen/main/bloc/main_bloc.dart'; // Импортируем MainBloc и события
import 'package:notes_test/presentation/theme/theme.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;

  const SearchTextField({
    super.key,
    this.hintText = 'Поиск заметок...',
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _showClearButton = false;
  late MainBloc _mainBloc;
  bool _isSortByDateAscending = true;
  bool _isSortByTitleAscending = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _mainBloc = Get.find<MainBloc>();
    _controller.addListener(_onTextChanged);
    _showClearButton = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text;
    _mainBloc.add(FilterNotesEvent(query));
    if (mounted) {
      setState(() {
        _showClearButton = query.isNotEmpty;
      });
    }
  }

  void _handleClear() {
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColor.backgrounField,
              borderRadius: AppDif.borderRadius13,
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: AppText.t14rb.copyWith(color: AppColor.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.backgrounField,
                hintText: widget.hintText,
                hintStyle: AppText.t14rb.copyWith(color: AppColor.greyText),
                border: const OutlineInputBorder(
                  borderRadius: AppDif.borderRadius13,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: AppDif.borderRadius13,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: AppDif.borderRadius13,
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                suffixIcon: _showClearButton
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: AppColor.greyText, size: 20),
                        onPressed: _handleClear,
                        tooltip: 'Очистить поиск',
                      )
                    : null,
              ),
              onChanged: (query) {
                _mainBloc.add(FilterNotesEvent(query));
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
              _isSortByDateAscending
                  ? Icons.calendar_today
                  : Icons.calendar_today,
              color: AppColor.orange,
              size: 22),
          tooltip:
              'Сортировка по дате (${_isSortByDateAscending ? "старые сначала" : "новые сначала"})',
          onPressed: () {
            final newSortOrder = !_isSortByDateAscending;
            _mainBloc.add(SortNotesByDateEvent(newSortOrder));
            setState(() {
              _isSortByDateAscending = newSortOrder;
            });
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(_isSortByTitleAscending ? Icons.sort : Icons.sort,
              color: AppColor.orange, size: 22),
          tooltip:
              'Сортировка по названию (${_isSortByTitleAscending ? "А-Я" : "Я-А"})',
          onPressed: () {
            final newSortOrder = !_isSortByTitleAscending;
            _mainBloc.add(SortNotesEvent(newSortOrder));
            setState(() {
              _isSortByTitleAscending = newSortOrder;
            });
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
