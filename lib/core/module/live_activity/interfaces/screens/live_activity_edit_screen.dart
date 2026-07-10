import 'package:flutter/material.dart';

class LiveActivityEditScreen extends StatefulWidget {
  const LiveActivityEditScreen({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<LiveActivityEditScreen> createState() => _LiveActivityEditScreenState();
}

class _LiveActivityEditScreenState extends State<LiveActivityEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _coverController;
  late TextEditingController _pageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.data['bookTitle'] as String? ?? '',
    );
    _authorController = TextEditingController(
      text: widget.data['author'] as String? ?? '',
    );
    _coverController = TextEditingController(
      text: widget.data['coverUrl'] as String? ?? '',
    );
    _pageController = TextEditingController(
      text: widget.data['page']?.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _coverController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _save() {
    final Map<String, dynamic> updated = <String, dynamic>{
      'activityId': widget.data['activityId'] ?? widget.data['activityId'],
      'bookTitle': _titleController.text,
      'author': _authorController.text,
      'coverUrl': _coverController.text.isEmpty ? null : _coverController.text,
      'page': int.tryParse(_pageController.text) ?? 1,
    };

    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Book Activity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Book title'),
            ),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _coverController,
              decoration: const InputDecoration(
                labelText: 'Cover URL (optional)',
              ),
            ),
            TextField(
              controller: _pageController,
              decoration: const InputDecoration(labelText: 'Page'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save & Update'),
            ),
          ],
        ),
      ),
    );
  }
}
