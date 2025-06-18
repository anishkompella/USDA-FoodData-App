import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import 'nutrients_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    final prov = ctx.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Foods')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Get Started!',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => prov.search(_controller.text),
                ),
              ),
              onSubmitted: prov.search,
            ),
          ),
          if (prov.isLoading) const CircularProgressIndicator(),
          if (prov.error != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Error: ${prov.error}',
                  style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: prov.results.length,
              itemBuilder: (_, i) {
                final item = prov.results[i];
                final title = item.brandName.isNotEmpty
                    ? item.brandName
                    : item.description;
                return ListTile(
                  title: Text(title),
                  subtitle: item.brandName.isNotEmpty
                      ? Text(item.description)
                      : null,
                  onTap: () {
                    Navigator.of(ctx).push(
                      MaterialPageRoute(
                        builder: (_) => NutrientsScreen(
                          fdcId: item.fdcId,
                          title: title,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
