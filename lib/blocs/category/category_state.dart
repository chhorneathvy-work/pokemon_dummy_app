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
