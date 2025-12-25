//old version
// import 'package:equatable/equatable.dart';
// import '../../models/category_res_model.dart';
//
// abstract class CategoryState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class CategoryInitial extends CategoryState {}
//
// class CategoryLoading extends CategoryState {}
//
// class CategoryLoaded extends CategoryState {
//   final List<CategoryListQuery> categories;
//
//   CategoryLoaded(this.categories);
//
//   @override
//   List<Object?> get props => [categories];
// }
//
// class CategoryError extends CategoryState {
//   final String message;
//
//   CategoryError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }

import 'package:equatable/equatable.dart';
import '../../models/category_res_model.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryListQuery> categories;

  @override
  List<Object?> get props => [isLoading, error, categories];

  const CategoryState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
  });

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryListQuery>? categories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      categories: categories ?? this.categories,
    );
  }
}
