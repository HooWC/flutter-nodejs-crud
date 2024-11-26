import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/item.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  // 获取数据
  Future<void> fetchItems() async {
    try {
      final fetchedItems = await ApiService.fetchItems();
      setState(() {
        items = fetchedItems;
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  // 创建新数据
  Future<void> createItem(String name, String description) async {
    try {
      await ApiService.createItem(name, description);
      fetchItems();
    } catch (e) {
      print('Error creating item: $e');
    }
  }

  // 弹出对话框以输入数据
  Future<void> showCreateItemDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 关闭对话框
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  await createItem(nameController.text, descriptionController.text);
                  Navigator.pop(context); // 关闭对话框
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  // 删除数据
  Future<void> deleteItem(String id) async {
    try {
      await ApiService.deleteItem(id);
      fetchItems();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  // 打开编辑页面
  void editItem(Item item) async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPage(item: item)),
    );
    if (updatedItem != null) {
      fetchItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD with Edit and Delete'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showCreateItemDialog(); // 显示创建对话框
            },
            child: Text('Create Item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].name),
                  subtitle: Text(items[index].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          editItem(items[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteItem(items[index].id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
