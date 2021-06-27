// To parse this JSON data, do
//
//     final gitUser = gitUserFromJson(jsonString);

import 'dart:convert';

class GitUser {
  GitUser({
    this.name,
    required this.avatarUrl,
    this.bio,
    this.location,
    this.email,
    required this.url,
    this.starredRepositories,
  });

  String? name;
  String avatarUrl;
  String? bio;
  String? location;
  String? email;
  String url;
  List<StarredRepository>? starredRepositories;

  factory GitUser.fromRawJson(String str) => GitUser.fromJson(json.decode(str));

  factory GitUser.fromJson(Map<String, dynamic> json) => GitUser(
        name: json["name"] == null ? null : json["name"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        bio: json["bio"] == null ? null : json["bio"],
        location: json["location"] == null ? null : json["location"],
        email: json["email"] == null ? null : json["email"],
        url: json["url"] == null ? null : json["url"],
        starredRepositories: json["starredRepositories"] == null
            ? null
            : json["starredRepositories"]
                .map((e) => StarredRepository.fromJson(e["nodes"])),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "avatarUrl": avatarUrl,
        "bio": bio == null ? null : bio,
        "location": location == null ? null : location,
        "email": email == null ? null : email,
        "url": url,
        "starredRepositories": (starredRepositories ?? <StarredRepository>[])
            .map((e) => e.toJson()),
      };
}

class StarredRepository {
  StarredRepository({
    required this.nameWithOwner,
    this.description,
    required this.stargazerCount,
  });

  String nameWithOwner;
  String? description;
  int stargazerCount;

  factory StarredRepository.fromRawJson(String str) =>
      StarredRepository.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StarredRepository.fromJson(Map<String, dynamic> json) =>
      StarredRepository(
        nameWithOwner:
            json["nameWithOwner"] == null ? null : json["nameWithOwner"],
        description: json["description"] == null ? null : json["description"],
        stargazerCount:
            json["stargazerCount"] == null ? null : json["stargazerCount"],
      );

  Map<String, dynamic> toJson() => {
        "nameWithOwner": nameWithOwner,
        "description": description ?? "",
        "stargazerCount": stargazerCount,
      };
}
