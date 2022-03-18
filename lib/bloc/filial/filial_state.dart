// import 'package:flutter_infinite_list/models/models.dart';

abstract class FilialState {
  FilialState([List props = const []]);
}

class FilialUninitialized extends FilialState {
  @override
  String toString() => 'OrderUninitialized';
}

class FilialError extends FilialState {
  @override
  String toString() => 'OrderError';
}

class FilialLoaded extends FilialState {
  final List<Map<String, dynamic>> record;
  final bool hasReachedMax;

  FilialLoaded({
    this.record = const [],
    this.hasReachedMax = false,
  }) : super([record, hasReachedMax]);

  FilialLoaded copyWith({
    List<Map<String, dynamic>>? record,
    bool? hasReachedMax,
  }) {
    return FilialLoaded(
      record: record ?? this.record,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'FilialLoaded { posts: ${record.length}, hasReachedMax: $hasReachedMax }';
}
