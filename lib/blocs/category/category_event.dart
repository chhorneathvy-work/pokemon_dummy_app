//old version

// import 'package:equatable/equatable.dart';
//
// abstract class CategoryEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class FetchCategoryList extends CategoryEvent {}

// import 'package:equatable/equatable.dart';
//
// /// All possible actions related to categories
// enum CategoryAction { fetch }
//
// /// A single event class that handles ALL actions
// class CategoryEvent extends Equatable {
//   final CategoryAction action;
//   final dynamic payload;
//
//   const CategoryEvent(this.action, {this.payload});
//
//   @override
//   List<Object?> get props => [action, payload];
// }

import 'package:equatable/equatable.dart';

/// Base class for all category events.
/// Every event extends this to keep structure clean and scalable.
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event to request fetching the category list.
class FetchCategoryList extends CategoryEvent {
  const FetchCategoryList();
}
