import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_service.dart';

class EditPage extends StatefulWidget {
  final Item item;

  const EditPage({Key? key, required this.item}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    descriptionController = TextEditingController(text: widget.item.description);
  }

  Future<void> updateItem() async {
    try {
      await ApiService.updateItem(
        widget.item.id,
        nameController.text,
        descriptionController.text,
      );
      Navigator.pop(context, true); // 返回并通知刷新数据
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateItem,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
