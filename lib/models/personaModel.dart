class Model {
  List<Results> results;

  Model({required this.results});

  factory Model.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Results> resultsList = list.map((i) => Results.fromJson(i)).toList();
    return Model(results: resultsList);
  }
}

class Results {
  Name name;
  Picture picture;

  Results({required this.name, required this.picture});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      name: Name.fromJson(json['name']),
      picture: Picture.fromJson(json['picture']),
    );
  }
}

class Name {
  String first;
  String last;

  Name({required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
    );
  }
}

class Picture {
  String large;

  Picture({required this.large});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
    );
  }
}
