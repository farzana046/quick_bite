import 'package:flutter/material.dart';
import 'package:quick_bite/models/menuItem_model.dart';
import 'package:quick_bite/services/menu_service.dart';

class EditMenuItemPage extends StatefulWidget {
  final MenuItemModel? item;

  const EditMenuItemPage({super.key, this.item});

  @override
  State<EditMenuItemPage> createState() => _EditMenuItemPageState();
}

class _EditMenuItemPageState extends State<EditMenuItemPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final MenuService _menuService = MenuService();

  String _selectedCategory = 'Burgers';

  final List<String> _categories = ['Burgers', 'Pizza', 'Desserts', 'Drinks'];

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
      _imageUrlController.text = widget.item!.imageUrl;
      _selectedCategory = widget.item!.category;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text) ?? 0;
    final imageUrl = _imageUrlController.text.trim();

    if (name.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid name and price")),
      );
      return;
    }

    if (widget.item == null) {
      await _menuService.addMenuItem(
        name: name,
        price: price,
        imageUrl: imageUrl,
        category: _selectedCategory,
      );
    } else {
      await _menuService.updateMenuItem(
        id: widget.item!.id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        category: _selectedCategory,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Menu Item" : "Add Menu Item")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Price
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price (৳)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Image URL
            TextField(
              controller: _imageUrlController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: "Image URL",
                hintText: "https://example.com/image.jpg",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Image Preview
            if (_imageUrlController.text.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _imageUrlController.text,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Text("Invalid image URL")),
                ),
              ),

            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),

            const SizedBox(height: 28),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveItem,
                child: Text(
                  isEdit ? "Update Item" : "Add Item",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
