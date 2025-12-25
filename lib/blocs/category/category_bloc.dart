import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
import '../../repositories/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repo = CategoryRepository();

  CategoryBloc() : super(const CategoryState()) {
    on<FetchCategoryList>(_onFetchCategoryList);
  }

  Future<void> _onFetchCategoryList(
      FetchCategoryList event,
      Emitter<CategoryState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final categories = await repo.getCategoryList();
      emit(state.copyWith(isLoading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}

