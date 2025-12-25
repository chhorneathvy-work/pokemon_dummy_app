import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_store/constants/app_color.dart';

import '../../../blocs/products/products_bloc.dart';
import '../../../blocs/products/products_event.dart';

import '../../../widgets/create_fab_widget.dart';

import 'list_category_filter.dart';
import 'list_grid.dart';
import 'list_search_bar.dart';

class PokemonListScreen extends StatefulWidget {
  final String title;
  const PokemonListScreen({super.key, required this.title});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  static const int _allMaxPage = 4;

  int _currentPage = 1;
  int? _categoryId;
  String? _search;

  bool get _hasNextPage => _currentPage < _allMaxPage;

  // ================= REQUEST =================
  void _requestPokemonList(ProductBloc bloc) {
    bloc.add(
      FetchPokemonList(
        page: _currentPage,
        search: _search,
        categoryId: _categoryId,
      ),
    );
  }

  // ================= SEARCH =================
  void _handleSearchChange(String value, ProductBloc bloc) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      setState(() {
        _search = value.isEmpty ? null : value;
        _currentPage = 1;
      });
      _requestPokemonList(bloc);
    });
  }

  // ================= CATEGORY =================
  void _handleCategorySelect(int? categoryId, ProductBloc bloc) {
    setState(() {
      _categoryId = categoryId;
      _currentPage = 1;
    });
    _requestPokemonList(bloc);
  }

  // ================= PAGINATION =================
  void _goToNextPage(ProductBloc bloc) {
    if (!_hasNextPage) return;
    setState(() => _currentPage++);
    _requestPokemonList(bloc);
  }

  void _goToPreviousPage(ProductBloc bloc) {
    if (_currentPage <= 1) return;
    setState(() => _currentPage--);
    _requestPokemonList(bloc);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.cardDark,
        elevation: 0,
      ),
      floatingActionButton: const CreateFabWidget(),
      body: Column(
        children: [
          ListSearchBar(
            controller: _searchController,
            onChanged: (v) => _handleSearchChange(v, productBloc),
          ),

          ListCategoryFilter(
            selectedCategoryId: _categoryId,
            onSelect: (id) => _handleCategorySelect(id, productBloc),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListGrid(
              currentPage: _currentPage,
              hasNextPage: _hasNextPage,
              onNext: () => _goToNextPage(productBloc),
              onPrev: () => _goToPreviousPage(productBloc),
            ),
          ),
        ],
      ),
    );
  }
}

