import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_store/constants/app_color.dart';
import 'package:pokemon_store/widgets/form_label_widget.dart';

import '../../blocs/products/products_bloc.dart';
import '../../blocs/products/products_event.dart';
import '../../blocs/products/products_state.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_state.dart';
import '../../widgets/pokemon_input_field.dart';

class CreatePokemonScreen extends StatefulWidget {
  const CreatePokemonScreen({super.key});

  @override
  State<CreatePokemonScreen> createState() => _CreatePokemonScreenState();
}

class _CreatePokemonScreenState extends State<CreatePokemonScreen> {
  final _nameCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  int? _selectedCategoryId;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _imageCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (prev, curr) =>
          prev.createSuccess != curr.createSuccess || prev.error != curr.error,
      listener: (context, state) {
        if (state.createSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pokémon created successfully 🎉")),
          );
        }

        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          title: const Text("Create Pokémon"),
          backgroundColor: Colors.amber.shade400,
          elevation: 0,
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE PREVIEW =================
            Center(
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textDark.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: _imageCtrl.text.isEmpty
                    ? const Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: Colors.grey,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          _imageCtrl.text,
                          fit: BoxFit.cover,
                          errorBuilder: (error, stackTrace, context) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            FormLabel("Image URL"),
            PokemonInputField(
              controller: _imageCtrl,
              hint: "https://image.url",
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 20),

            FormLabel("Pokémon Name"),
            PokemonInputField(hint: "e.g. Pikachu", controller: _nameCtrl),

            const SizedBox(height: 20),

            FormLabel("Description"),
            PokemonInputField(controller: _descCtrl, hint: "Short description", maxLines: 4,),

            const SizedBox(height: 20),

            FormLabel("Category"),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.categories.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "No categories available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedCategoryId,
                      hint: const Text("Select category"),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      items: state.categories.map((cat) {
                        return DropdownMenuItem<int>(
                          value: cat.id,
                          child: Text(cat.name ?? ""),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedCategoryId = value);
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () => _onCreatePressed(context),
                child: const Text(
                  "Create Pokémon",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCreatePressed(BuildContext context) {
    if (_nameCtrl.text.isEmpty ||
        _imageCtrl.text.isEmpty ||
        _descCtrl.text.isEmpty ||
        _selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final categoryName = context
        .read<CategoryBloc>()
        .state
        .categories
        .firstWhere((c) => c.id == _selectedCategoryId)
        .name!;

    context.read<ProductBloc>().add(
      CreatePokemon(
        pokemonName: _nameCtrl.text.trim(),
        pokemonImage: _imageCtrl.text.trim(),
        pokemonDescription: _descCtrl.text.trim(),
        categoryName: categoryName,
      ),
    );
  }
}
