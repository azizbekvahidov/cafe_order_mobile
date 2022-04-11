// import 'package:flutter_infinite_list/models/models.dart';

abstract class SearchState {
  SearchState([List props = const []]);
}

class SearchUninitialized extends SearchState {
  @override
  String toString() => 'SearchUninitialized';
}

class SearchError extends SearchState {
  @override
  String toString() => 'SearchError';
}

class SearchLoaded extends SearchState {
  final List<Map<String, dynamic>> record;
  final bool hasReachedMax;

  SearchLoaded({
    this.record = const [],
    this.hasReachedMax = false,
  }) : super([record, hasReachedMax]);

  SearchLoaded copyWith({
    List<Map<String, dynamic>>? record,
    bool? hasReachedMax,
  }) {
    return SearchLoaded(
      record: record ?? this.record,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'SearchLoaded { posts: ${record.length}, hasReachedMax: $hasReachedMax }';
}
