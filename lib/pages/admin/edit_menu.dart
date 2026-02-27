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

  final List<String> _categories = [
    'Burgers',
    'Pizza',
    'Chickens',
    'Desserts',
    'Drinks',
  ];

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
      backgroundColor: const Color(0xFFFFF7F0),
      appBar: AppBar(
        title: Text(isEdit ? "Edit Menu Item" : "Add Menu Item"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SECTION: BASIC INFO
            _SectionTitle("Basic Information"),

            _Card(
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Item Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Price (৳)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SECTION: IMAGE
            _SectionTitle("Item Image"),

            _Card(
              child: Column(
                children: [
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
                  if (_imageUrlController.text.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _imageUrlController.text,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 160,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const Text("Invalid image URL"),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SECTION: CATEGORY
            _SectionTitle("Category"),

            _Card(
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
              ),
            ),

            const SizedBox(height: 28),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFF8F00)],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveItem,
                  child: Text(
                    isEdit ? "Update Item" : "Add Item",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- SMALL UI HELPERS ----------

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(padding: const EdgeInsets.all(14), child: child),
    );
  }
}
