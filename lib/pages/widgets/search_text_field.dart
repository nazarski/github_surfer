import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_surfer/constants/app_strings.dart';
import 'package:github_surfer/providers/search_section_provider.dart';
import 'package:github_surfer/resources/app_colors.dart';
import 'package:github_surfer/resources/app_icons.dart';
import 'package:github_surfer/resources/app_styles.dart';

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
            .notifyStatusChange(searchValueIsEmpty: true);
      }
      if (_textController.text.isEmpty) {
        ref
            .read(searchSectionProvider.notifier)
            .notifyStatusChange(searchValueIsEmpty: false);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = ref.watch(searchSectionProvider) == SearchStatus.value;
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      cursorColor: AppColors.textPrimary,
      style: AppStyles.body,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {},
      onEditingComplete: () {},
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
}