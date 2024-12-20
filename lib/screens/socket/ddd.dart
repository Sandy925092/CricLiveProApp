import 'package:flutter/material.dart';

class ListViewBuilderExample extends StatefulWidget {
  @override
  _ListViewBuilderExampleState createState() => _ListViewBuilderExampleState();
}

class _ListViewBuilderExampleState extends State<ListViewBuilderExample> {
  List<String> items = List.generate(2, (index) => 'Item ${index + 1}');

  Future<void> _refreshItems() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      items = List.generate(2, (index) => 'Updated Item ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.builder Example'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(items[index]),
                subtitle: const Text('Subtitle here'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tapped on ${items[index]}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
