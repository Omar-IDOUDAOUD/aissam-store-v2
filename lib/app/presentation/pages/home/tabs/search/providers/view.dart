import 'package:aissam_store_v2/app/buisness/products/core/params.dart';
import 'package:aissam_store_v2/app/buisness/products/domain/usecases/search_usecases.dart';
import 'package:aissam_store_v2/app/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data.dart';

// final viewProvider = <_ViewNotifier>(_ViewNotifier.new);

final viewProvider = ChangeNotifierProvider<_ViewNotifier>(_ViewNotifier.new);

enum ViewStates {
  initial,
  showSuggestions,
  results;

  bool get isInitial => this == ViewStates.initial;
  bool get isSearching => this == ViewStates.showSuggestions;
  bool get isShowSuggestions => this == ViewStates.showSuggestions;
  bool get isResults => this == ViewStates.results;
}

class _ViewNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef _ref;
  _ViewNotifier(this._ref);
  final TextEditingController searchInputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode searchFocusNode = FocusNode();

  SearchProductFilterParams _searchFilters = SearchProductFilterParams.empty();

  SearchProductFilterParams get searchFilters => _searchFilters;

  set searchFilters(SearchProductFilterParams value) {
    _ref.invalidate(resultsProvider(_searchFilters));
    _searchFilters = value;
    notifyListeners();
  }

  @override
  void dispose() {
    searchInputController.dispose();
    scrollController.dispose();
    searchFocusNode.requestFocus();
    super.dispose();
  }

  ViewStates _viewState = ViewStates.initial;
  bool _pinAppbar = true;

  bool get pinAppbar => _pinAppbar;

  set pinAppbar(bool value) {
    _pinAppbar = value;
    notifyListeners();
  }

  set viewState(ViewStates viewState) {
    _viewState = viewState;

    notifyListeners();
  }

  void searchFocus() async {
    print('SEARCH FOCUS');
    _pinAppbar = false;
    onSearchTextEdit(null);
    await scrollController.animateTo(
      ViewConsts.appBarExpandHeight,
      duration: ViewConsts.animationDuration2,
      curve: ViewConsts.animationCurve,
    );
    searchFocusNode.requestFocus();
  }

  void searchSubmit({SearchProductFilterParams? useFilters}) async {
    if (useFilters != null) {
      searchInputController.text = useFilters.keywords;
      _ref.invalidate(resultsProvider(_searchFilters));
      _searchFilters = useFilters;
    } else
      _searchFilters = _searchFilters..keywords = searchInputController.text;

    if (_searchFilters.suggestionClick) {
      print('SUGGESTION CLICK');
      HandleSearchSuggestionClick().call(_searchFilters.keywords);
      AddSearchToHistory()
          .call(SearchProductsParams(filterParams: _searchFilters))
          .then((_) {
        print('history res: $_');
        _ref.invalidate(historyProvider);
      });
    }

    print('SEARCH SUBMIT');

    // hello
    searchFocusNode.unfocus();
    if (searchInputController.text.isNotEmpty)
      viewState = ViewStates.results;
    else
      viewState = ViewStates.initial;
    await scrollController.animateTo(
      0,
      duration: ViewConsts.animationDuration2,
      curve: ViewConsts.animationCurve,
    );
    pinAppbar = true;
  }

  void onSearchTextEdit(_) {
    print('SEARCH EDIT TEXT');

    if (searchInputController.text.isNotEmpty) {
      viewState = ViewStates.showSuggestions;
    } else if (searchInputController.text.isEmpty) {
      viewState = ViewStates.initial;
    }
  }

  void clear() {
    searchInputController.text = '';
    searchFocusNode.unfocus();
    scrollController.animateTo(
      0,
      duration: ViewConsts.animationDuration2,
      curve: ViewConsts.animationCurve,
    );
    viewState = ViewStates.initial;
  }

  ViewStates get viewState => _viewState;
}
