class_name GameConfiguration extends Resource

enum GalaxySize { SMALL, MEDIUM, LARGE, HUGE }
enum Difficulty { EASY, MEDIUM, HARD, IMPOSSIBLE }

@export var size: GalaxySize
@export var difficulty: Difficulty
@export var opponents: int
@export var race: Race
