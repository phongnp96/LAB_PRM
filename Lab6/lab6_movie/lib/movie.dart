class Movie {
  final String title, poster;
  final int year;
  final List<String> genres;
  final double rating;
  Movie(this.title, this.year, this.genres, this.poster, this.rating);
}

final List<Movie> myMovies = [
  Movie('Dune: Part Two', 2024, ['Sci-Fi', 'Action'], 'https://picsum.photos/id/10/400/250', 8.6),
  Movie('Deadpool & Wolverine', 2024, ['Action', 'Comedy'], 'https://picsum.photos/id/11/400/250', 8.3),
  Movie('Oppenheimer', 2023, ['Drama'], 'https://picsum.photos/id/12/400/250', 8.4),
];

final List<String> allGenres = ['Action', 'Drama', 'Comedy', 'Sci-Fi'];