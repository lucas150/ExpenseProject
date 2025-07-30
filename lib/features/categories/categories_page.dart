import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late final _tab = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final expAsync = ref.watch(expenseCategoriesProvider);
    final incAsync = ref.watch(incomeCategoriesProvider);

    Future<void> _add(bool expense) async {
      final controller = TextEditingController();
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('New ${expense ? 'Expense' : 'Income'} Category'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (expense) {
                  ref
                      .read(expenseCategoriesProvider.notifier)
                      .add(controller.text);
                } else {
                  ref
                      .read(incomeCategoriesProvider.notifier)
                      .add(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: 'Expense'),
            Tab(text: 'Income'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [_buildList(expAsync, true), _buildList(incAsync, false)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(_tab.index == 0),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(AsyncValue<List> async, bool expense) => async.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (e, _) => Center(child: Text('Error: $e')),
    data: (list) => ListView(
      children: list
          .map(
            (c) => ListTile(
              leading: expense
                  ? const Icon(Icons.remove_circle_outline)
                  : const Icon(Icons.add_circle_outline),
              title: Text(c.name),
            ),
          )
          .toList(),
    ),
  );
}
