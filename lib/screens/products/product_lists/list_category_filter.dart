import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/category/category_bloc.dart';
import '../../../blocs/category/category_state.dart';
import 'list_category_chip.dart';



class ListCategoryFilter extends StatelessWidget {
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelect;

  const ListCategoryFilter({
    super.key,
    required this.selectedCategoryId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              CategoryChip(
                label: "All",
                selected: selectedCategoryId == null,
                onTap: () => onSelect(null),
              ),
              ...state.categories.map(
                    (cat) => CategoryChip(
                  label: cat.name ?? "",
                  selected: cat.id == selectedCategoryId,
                  onTap: () => onSelect(cat.id),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
