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
  final MenuService _menuService = MenuService();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? "Add Item" : "Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final price = double.parse(_priceController.text);

                if (widget.item == null) {
                  await _menuService.addMenuItem(name, price);
                } else {
                  await _menuService.updateMenuItem(
                    widget.item!.id,
                    name,
                    price,
                  );
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
