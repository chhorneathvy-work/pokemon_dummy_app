// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../models/product_res_model.dart';
// import '../../blocs/products/products_bloc.dart';
// import '../../blocs/products/products_event.dart';
// import '../../blocs/products/products_state.dart';
// import '../../blocs/category/category_bloc.dart';
// import '../../blocs/category/category_state.dart';
// import '../../widgets/form_label_widget.dart';
// import '../../widgets/pokemon_input_field.dart';
//
// class UpdatePokemonScreen extends StatefulWidget {
//   final PokemonListQuery data;
//
//   const UpdatePokemonScreen({
//     super.key,
//     required this.data,
//   });
//
//   @override
//   State<UpdatePokemonScreen> createState() => _UpdatePokemonScreenState();
// }
//
// class _UpdatePokemonScreenState extends State<UpdatePokemonScreen> {
//   String? _name;
//   String? _image;
//   String? _description;
//   int? _selectedCategoryId;
//
//   bool get _hasChanged {
//     final state = context.read<CategoryBloc>().state;
//
//     if (state.categories.isEmpty) return false;
//
//     final originalCategoryId = state.categories
//         .firstWhere((c) => c.name == widget.data.categoryName)
//         .id;
//
//     return (_name != null && _name != widget.data.pokemonName) ||
//         (_image != null && _image != widget.data.pokemonImage) ||
//         (_description != null &&
//             _description != widget.data.pokemonDescription) ||
//         (_selectedCategoryId != null &&
//             _selectedCategoryId != originalCategoryId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProductBloc, ProductState>(
//       listenWhen: (prev, curr) =>
//       prev.updateSuccess != curr.updateSuccess ||
//           prev.error != curr.error,
//
//       listener: (context, state) {
//         if (state.updateSuccess) {
//           Navigator.pop(context);
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Pokémon updated successfully ✨"),
//             ),
//           );
//         }
//
//         if (state.error != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error!)),
//           );
//         }
//       },
//
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             title: const Text("Edit Pokémon"),
//             backgroundColor: Colors.amber.shade400,
//             elevation: 0,
//           ),
//           body: _buildBody(context),
//         );
//       },
//     );
//   }
//
//   // ===========================================================
//   // BODY
//   // ===========================================================
//   Widget _buildBody(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= IMAGE PREVIEW =================
//             Center(
//               child: Container(
//                 height: 160,
//                 width: 160,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 10,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: (_image ?? widget.data.pokemonImage)?.isEmpty ?? true
//                     ? const Icon(
//                   Icons.image_outlined,
//                   size: 64,
//                   color: Colors.grey,
//                 )
//                     : ClipRRect(
//                   borderRadius: BorderRadius.circular(24),
//                   child: Image.network(
//                     _image ?? widget.data.pokemonImage!,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) =>
//                     const Icon(Icons.broken_image),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             FormLabel("Image URL"),
//             PokemonInputField(
//               initialValue: widget.data.pokemonImage ?? "",
//               hint: "https://image.url",
//               onChanged: (v) => setState(() => _image = v),
//             ),
//
//             const SizedBox(height: 20),
//
//             FormLabel("Pokémon Name"),
//             PokemonInputField(
//               initialValue: widget.data.pokemonName ?? "",
//               hint: "e.g. Pikachu",
//               onChanged: (v) => setState(() => _name = v),
//             ),
//
//             const SizedBox(height: 20),
//
//             FormLabel("Description"),
//             PokemonInputField(
//               initialValue: widget.data.pokemonDescription ?? "",
//               hint: "Short description",
//               maxLines: 4,
//               onChanged: (v) => setState(() => _description = v),
//             ),
//
//             const SizedBox(height: 20),
//
//             FormLabel("Category"),
//             BlocBuilder<CategoryBloc, CategoryState>(
//               builder: (context, state) {
//                 if (state.categories.isEmpty) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     child: Text(
//                       "No categories available",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   );
//                 }
//
//                 _selectedCategoryId ??= state.categories
//                     .firstWhere(
//                       (c) => c.name == widget.data.categoryName,
//                   orElse: () => state.categories.first,
//                 )
//                     .id;
//
//                 return Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<int>(
//                       isExpanded: true,
//                       dropdownColor: Colors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       value: _selectedCategoryId,
//                       items: state.categories.map((cat) {
//                         return DropdownMenuItem<int>(
//                           value: cat.id,
//                           child: Text(cat.name ?? ""),
//                         );
//                       }).toList(),
//                       onChanged: (v) =>
//                           setState(() => _selectedCategoryId = v),
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 36),
//
//             // ================= UPDATE BUTTON =================
//             SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                   _hasChanged ? Colors.black : Colors.grey.shade400,
//                   elevation: _hasChanged ? 6 : 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                 ),
//                 onPressed:
//                 _hasChanged ? () => _onUpdatePressed(context) : null,
//                 child: const Text(
//                   "Update Pokémon",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ===========================================================
//   // ACTION
//   // ===========================================================
//   void _onUpdatePressed(BuildContext context) {
//     final categories = context.read<CategoryBloc>().state.categories;
//
//     final categoryName = categories
//         .firstWhere((c) => c.id == _selectedCategoryId)
//         .name!;
//
//     context.read<ProductBloc>().add(
//       UpdatePokemon(
//         id: widget.data.id!,
//         pokemonName: _name ?? widget.data.pokemonName!,
//         pokemonImage: _image ?? widget.data.pokemonImage!,
//         pokemonDescription:
//         _description ?? widget.data.pokemonDescription!,
//         categoryName: categoryName,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/product_res_model.dart';
import '../../widgets/form_label_widget.dart';
import '../../widgets/pokemon_input_field.dart';

class UpdatePokemonScreen extends StatefulWidget {
  final PokemonListQuery data;

  const UpdatePokemonScreen({
    super.key,
    required this.data,
  });

  @override
  State<UpdatePokemonScreen> createState() => _UpdatePokemonScreenState();
}

class _UpdatePokemonScreenState extends State<UpdatePokemonScreen> {
  String? _name;
  String? _image;
  String? _description;
  int? _categoryId;
  String? _categoryName;

  bool get _hasChanged {
    return (_name != null && _name != widget.data.pokemonName) ||
        (_image != null && _image != widget.data.pokemonImage) ||
        (_description != null &&
            _description != widget.data.pokemonDescription) ||
        (_categoryId != null && _categoryId != widget.data.categoryId);
  }

  @override
  void initState() {
    super.initState();
    _categoryId = widget.data.categoryId;
    _categoryName = widget.data.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text("Edit Pokémon"),
        backgroundColor: Colors.amber.shade400,
        elevation: 0,
      ),
      body: SafeArea(
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
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: (_image ?? widget.data.pokemonImage)?.isEmpty ?? true
                      ? const Icon(Icons.image_outlined,
                      size: 64, color: Colors.grey)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      _image ?? widget.data.pokemonImage!,
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
                initialValue: widget.data.pokemonImage ?? "",
                hint: "https://image.url",
                onChanged: (v) => setState(() => _image = v),
              ),

              const SizedBox(height: 20),

              FormLabel("Pokémon Name"),
              PokemonInputField(
                initialValue: widget.data.pokemonName ?? "",
                hint: "e.g. Pikachu",
                onChanged: (v) => setState(() => _name = v),
              ),

              const SizedBox(height: 20),

              FormLabel("Description"),
              PokemonInputField(
                initialValue: widget.data.pokemonDescription ?? "",
                hint: "Short description",
                maxLines: 4,
                onChanged: (v) => setState(() => _description = v),
              ),

              const SizedBox(height: 36),

              // ================= UPDATE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _hasChanged ? Colors.black : Colors.grey.shade400,
                    elevation: _hasChanged ? 6 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: _hasChanged ? _onUpdatePressed : null,
                  child: const Text(
                    "Update Pokémon",
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
      ),
    );
  }

  // ================= ACTION =================
  void _onUpdatePressed() {
    final updated = widget.data.copyWith(
      pokemonName: _name ?? widget.data.pokemonName,
      pokemonImage: _image ?? widget.data.pokemonImage,
      pokemonDescription:
      _description ?? widget.data.pokemonDescription,
      categoryId: _categoryId ?? widget.data.categoryId,
      categoryName: _categoryName ?? widget.data.categoryName,
    );

    Navigator.pop(context, updated);
  }
}
