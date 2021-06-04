class Movie {
  String? imdbId;
  String? imdbLink;
  String? title;
  String? iMDBScore;
  String? genre;
  String? poster;

  Movie(
      {this.imdbId,
      this.imdbLink,
      this.title,
      this.iMDBScore,
      this.genre,
      this.poster});

  Movie.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdbId'];
    imdbLink = json['Imdb Link'];
    title = json['Title'];
    iMDBScore = json['IMDB Score'];
    genre = json['Genre'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdbId'] = this.imdbId;
    data['Imdb Link'] = this.imdbLink;
    data['Title'] = this.title;
    data['IMDB Score'] = this.iMDBScore;
    data['Genre'] = this.genre;
    data['Poster'] = this.poster;
    return data;
  }
}
