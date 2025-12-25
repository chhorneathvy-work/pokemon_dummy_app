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
