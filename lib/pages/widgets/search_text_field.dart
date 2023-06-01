import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/resources/app_strings.dart';
import 'package:github_surfer/providers/github_repository_provider.dart';
import 'package:github_surfer/providers/search_history_provider.dart';
import 'package:github_surfer/providers/search_section_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

///Input textField
class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({
    super.key,
  });

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _textController.addListener(() {
      if (_textController.text.isNotEmpty) {
        ref
            .read(searchSectionProvider.notifier)
            .notifyStatusChange(searchValueIsEmpty: false);
      }
      if (_textController.text.isEmpty) {
        ref
            .read(searchSectionProvider.notifier)
            .notifyStatusChange(searchValueIsEmpty: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = ref.watch(searchSectionProvider) == SearchStatus.value;
    ref.listen(paginatedRequestProvider, (_, next) {
      if (_textController.text != next.searchValue) {
        _textController.text = next.searchValue;
      }
    });
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      cursorColor: AppColors.textPrimary,
      style: AppStyles.body,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        ref.read(searchHistoryProvider.notifier).addToHistory(value: value);
        ref.read(paginatedRequestProvider.notifier).setNewValue(value);
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
          child: SvgPicture.asset(
            AppIcons.search,
          ),
        ),
        suffixIcon: Visibility(
          visible: hasValue,
          child: GestureDetector(
            onTap: () {
              _textController.clear();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 16, 16),
              child: SvgPicture.asset(
                AppIcons.close,
              ),
            ),
          ),
        ),
        hintText: AppStrings.search,
        fillColor: _focusNode.hasFocus ? AppColors.accentSecondary : null,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
