import 'dart:math';

import 'package:aissam_store_v2/app/buisness/features/products/core/params.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/providers/back_action.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/data.dart';
import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/providers/view.dart';
import 'package:aissam_store_v2/core/utils/extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'widgets/tile.dart';
import 'widgets/title.dart';

class SuggestionsView extends ConsumerStatefulWidget {
  const SuggestionsView({super.key});

  @override
  ConsumerState<SuggestionsView> createState() => _SuggestionsViewState();
}

class _SuggestionsViewState extends ConsumerState<SuggestionsView> {
  late final inputController = ref.read(viewProvider).searchInputController;
  // late final Ref _refOnDispose;

  @override
  void initState() {
    super.initState();
    inputController.addListener(_loadSuggestions);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(backEventProvider).backEvent = () {
    //     ref.read(viewProvider).clear();
    //   };
    //   _refOnDispose = ref.read(backEventProvider).ref;
    // });
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _refOnDispose.read(backEventProvider.notifier).backEvent = null;
    // });

    inputController.removeListener(_loadSuggestions);
    super.dispose();
  }

  void _loadSuggestions() {
    if (inputController.text.isNotEmpty) {
      setState(() {});
      final inputText = inputController.text;
      ref.read(suggestionsProvider(inputController.text).future).then(
        (value) {
          _previousText = inputText;
          _previousSuggestions = value;
        },
      );
    }
  }

  String _previousText = '';
  List<String>? _previousSuggestions;

  @override
  Widget build(BuildContext context) {
    final suggestions = ref.watch(suggestionsProvider(inputController.text));
    return MultiSliver(
      children: [
        const Title2(title: 'Suggestions'),
        suggestions.when(
          data: (data) => _buildList(data, inputController.text),
          error: (error, stackTrace) {
            return ErrorCard(
              addPageMargine: true,
              error: error,
              showDescription: true,
              onRety: () =>
                  ref.refresh(suggestionsProvider(inputController.text)),
            );
          },
          loading: () => _previousSuggestions != null
              ? _buildList(_previousSuggestions!, _previousText)
              : const CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget _buildList(List<String> list, String insertedText) {
    return SliverList.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _Tile(
          insertedText: insertedText,
          suggestionText: list[index],
          onPressed: () {
            ref.read(viewProvider.notifier).searchSubmit(
                useFilters: SearchProductFilterParams.suggestion(list[index]));
          },
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
      {required this.insertedText,
      required this.suggestionText,
      required this.onPressed});
  final String insertedText;
  final String suggestionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: ViewConsts.pagePadding),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: _builsTextSpans(context),
            ),
          ),
          Icon(
            FluentIcons.search_24_regular,
            color: context.theme.colors.s,
            size: 25,
          ),
        ],
      ),
    );
  }

  List<TextSpan> _builsTextSpans(BuildContext context) {
    final spans = <TextSpan>[];
    final matchIndex =
        suggestionText.toLowerCase().indexOf(insertedText.toLowerCase());
    final matchEndIndex = matchIndex + insertedText.length;

    spans.add(
      TextSpan(
        text: suggestionText.substring(0, max(matchIndex, 0)),
        style: context.textTheme.displaySmall!.copyWith(
          color: context.theme.colors.s,
        ),
      ),
    );
    spans.add(
      TextSpan(
          text: insertedText,
          style: context.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w400,
          )),
    );
    spans.add(
      TextSpan(
        text: suggestionText.substring(
          matchEndIndex,
          suggestionText.length,
        ),
        style: context.textTheme.displaySmall!.copyWith(
          color: context.theme.colors.s,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return spans;
  }
}
