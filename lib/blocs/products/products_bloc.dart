import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/products_repositories.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo = ProductRepository();

  ProductBloc() : super(const ProductState()) {
    // debugPrint('ProductBloc created');
    on<FetchPokemonList>(_onFetchPokemonList);
    on<CreatePokemon>(_onCreatePokemon);
    on<UpdatePokemon>(_onUpdatePokemon);
    on<DeletePokemon>(_onDeletePokemon);
  }

  Future<void> _onFetchPokemonList(
    FetchPokemonList event,
    Emitter<ProductState> emit,
  ) async {
    // debugPrint('FetchPokemonList event received with page: ${event.page}');
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final list = await repo.getPokemonList(
        search: event.search,
        categoryId: event.categoryId,
        page: event.page,
        limit: event.limit,
      );

      final isAppending = event.append;

      bool hasMore;

      if (list.isEmpty) {
        hasMore = false;
      } else if (list.length < event.limit) {
        hasMore = false;
      } else if (isAppending && list.first.id == state.pokemon.last.id) {
        // backend returned same page again → stop
        hasMore = false;
      } else {
        hasMore = true;
      }

      emit(
        state.copyWith(
          isLoading: false,
          pokemon: isAppending ? [...state.pokemon, ...list] : list,
          page: event.page,
          hasMore: hasMore,
          lastFetchCount: list.length,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCreatePokemon(
      CreatePokemon event,
      Emitter<ProductState> emit,
      ) async {
    emit(
      state.copyWith(
        isCreating: true,
        createSuccess: false,
        error: null,
      ),
    );

    try {
      final created = await repo.createPokemon(
        pokemonName: event.pokemonName,
        pokemonImage: event.pokemonImage,
        pokemonDescription: event.pokemonDescription,
        categoryName: event.categoryName,
      );

      emit(
        state.copyWith(
          isCreating: false,
          createSuccess: true,
          pokemon: [created, ...state.pokemon], // optimistic insert
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isCreating: false,
          error: e.toString(),
        ),
      );
    }
  }

  // Future<void> _onUpdatePokemon(
  //     UpdatePokemon event,
  //     Emitter<ProductState> emit,
  //     ) async {
  //   emit(state.copyWith(isLoading: true, error: null, updateSuccess: false));
  //
  //   try {
  //     final updated = await repo.updatePokemon(
  //       id: event.id,
  //       pokemonName: event.pokemonName,
  //       pokemonImage: event.pokemonImage,
  //       pokemonDescription: event.pokemonDescription,
  //       categoryName: event.categoryName,
  //     );
  //
  //     final updatedList = state.pokemon.map((p) {
  //       return p.id == updated.id ? updated : p;
  //     }).toList();
  //
  //     emit(
  //       state.copyWith(
  //         isLoading: false,
  //         pokemon: updatedList,
  //         updatedPokemon: updated,
  //         updateSuccess: true,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, error: e.toString()));
  //   }
  // }

  //Because update requires an API call. The example shows state replacement, not API design. The behavior is identical.
  Future<void> _onUpdatePokemon(
      UpdatePokemon event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final updated = await repo.updatePokemon(
        id: event.id,
        pokemonName: event.pokemonName,
        pokemonImage: event.pokemonImage,
        pokemonDescription: event.pokemonDescription,
        categoryName: event.categoryName,
      );

      final updatedList = state.pokemon
          .map((p) => p.id == updated.id ? updated : p)
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          pokemon: updatedList,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }


  Future<void> _onDeletePokemon(
      DeletePokemon event,
      Emitter<ProductState> emit,
      ) async {
    emit(state.copyWith(isDeleting: true, deleteSuccess: false, error: null));

    try {
      await repo.deletePokemon(event.id);

      emit(
        state.copyWith(
          isDeleting: false,
          pokemon:
          state.pokemon.where((p) => p.id != event.id).toList(),
          deleteSuccess: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isDeleting: false, error: e.toString()));
    }
  }
}
