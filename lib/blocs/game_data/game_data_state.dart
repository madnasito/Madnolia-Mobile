part of 'game_data_bloc.dart';

class GameDataState extends Equatable {

  final String id;
  final String name;
  final String slug;
  final int gameId;
  final String background;
  final List<String> screenshots;
  final String description;

   const GameDataState({
    this.id = "",
    this.name = "",
    this.slug = "",
    this.gameId = 0,
    this.background = "",
    this.screenshots = const [],
    this.description = ""
  });

  GameDataState copyWith({
    String? id,
    String? name,
    String? slug,
    int? gameId,
    String? background,
    List<String>? screenshots,
    String? description
  }) => GameDataState(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    gameId: gameId ?? this.gameId,
    background: background ?? this.background,
    screenshots: screenshots ?? this.screenshots,
    description: description ?? this.description
  );
  
  @override
  List<Object> get props => [id, name, slug, gameId, background, screenshots, description];
}
