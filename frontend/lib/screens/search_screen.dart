import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import 'nutrients_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final _controller = TextEditingController(); //holds the current text in the search bar

  @override
  Widget build(BuildContext ctx) {
    final prov = ctx.watch<SearchProvider>(); //grabs an instance of the search provider 

    return Scaffold(
      appBar: AppBar(title: const Text('Search for your Favorite Foods!')),
      body: Column(
        children: [ //Scaffold contains the search bar, Error message handling, and the search results list
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Get Started!',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => prov.search(_controller.text), //when search bar is made appropriate search results are fetced
                ),
              ),
              onSubmitted: prov.search, //fetches results when the enter key is pressed
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
              itemBuilder: (_, i) { //loops through results list
                final item = prov.results[i];
                final title = item.brandName.isNotEmpty
                    ? item.brandName // for each element it chooses the brand name as the title if it exists, otherwise it chooses the description
                    : item.description;
                return ListTile(
                  title: Text(title),
                  subtitle: item.brandName.isNotEmpty
                      ? Text(item.description)
                      : null,
                  onTap: () {
                    Navigator.of(ctx).push(
                      MaterialPageRoute(
                        builder: (_) => NutrientsScreen( //navigates to the chosen food's key nutritional facts based on its id
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