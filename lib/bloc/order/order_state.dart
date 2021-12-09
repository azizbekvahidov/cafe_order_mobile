// import 'package:flutter_infinite_list/models/models.dart';

abstract class OrderState {
  OrderState([List props = const []]);
}

class OrderUninitialized extends OrderState {
  @override
  String toString() => 'OrderUninitialized';
}

class OrderError extends OrderState {
  @override
  String toString() => 'OrderError';
}

class OrderLoaded extends OrderState {
  final List<Map<String, dynamic>> record;
  final bool hasReachedMax;

  OrderLoaded({
    this.record = const [],
    this.hasReachedMax = false,
  }) : super([record, hasReachedMax]);

  OrderLoaded copyWith({
    List<Map<String, dynamic>>? record,
    bool? hasReachedMax,
  }) {
    return OrderLoaded(
      record: record ?? this.record,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'OrderLoaded { posts: ${record.length}, hasReachedMax: $hasReachedMax }';
}
