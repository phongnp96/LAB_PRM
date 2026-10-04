import 'package:flutter/material.dart';
import 'movie.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});
  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String search = '';
  Set<String> selGenres = {};
  String sort = 'A-Z';

  @override
  Widget build(BuildContext context) {
    var list = myMovies.where((m) =>
    m.title.toLowerCase().contains(search.toLowerCase()) &&
        (selGenres.isEmpty || m.genres.any(selGenres.contains))
    ).toList();

    list.sort((a, b) {
      if (sort == 'A-Z') return a.title.compareTo(b.title);
      if (sort == 'Z-A') return b.title.compareTo(a.title);
      if (sort == 'Year') return b.year.compareTo(a.year);
      return b.rating.compareTo(a.rating);
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Find a Movie', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              TextField(
                onChanged: (v) => setState(() => search = v),
                decoration: const InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search)),
              ),

              Wrap(
                spacing: 8,
                children: allGenres.map((g) => FilterChip(
                  label: Text(g),
                  selected: selGenres.contains(g),
                  onSelected: (s) => setState(() => s ? selGenres.add(g) : selGenres.remove(g)),
                )).toList(),
              ),

              DropdownButton<String>(
                value: sort,
                items: ['A-Z', 'Z-A', 'Year', 'Rating'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => sort = v!),
              ),

              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 800) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3.5),
                      itemCount: list.length,
                      itemBuilder: (c, i) => _card(list[i]),
                    );
                  }
                  return ListView.builder(itemCount: list.length, itemBuilder: (c, i) => _card(list[i]));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(Movie m) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Image.network(m.poster, width: 60, fit: BoxFit.cover),
        title: Text(m.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${m.year} • ${m.genres.join(', ')} • ⭐${m.rating}'),
      ),
    );
  }
}