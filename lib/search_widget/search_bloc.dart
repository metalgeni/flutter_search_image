import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:search_image/kakap_api.dart';
import 'package:search_image/search_widget/search_state.dart';

class SearchBloc {
  final Sink<String> onTextChanged;
  final Stream<SearchState> state;

  factory SearchBloc(KakaoApi api) {
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
        .distinct()
        .debounceTime(const Duration(milliseconds: 250))
        .switchMap<SearchState>((String term) => _search(term, api))
        .startWith(SearchNoTerm());

    return SearchBloc._(onTextChanged, state);
  }

  SearchBloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

  static Stream<SearchState> _search(String term, KakaoApi api) => term.isEmpty
      ? Stream.value(SearchNoTerm())
      : Rx.fromCallable(() => api.search(term))
          .map((result) =>
              result.isEmpty ? SearchEmpty() : SearchPopulated(result))
          .startWith(SearchLoading())
          .onErrorReturn(SearchError());
}
