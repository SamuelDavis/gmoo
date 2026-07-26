class_name GameConfiguration extends Resource

enum GalaxySize { SMALL, MEDIUM, LARGE, HUGE }
enum Difficulty { EASY, NORMAL, HARD, IMPOSSIBLE }

@export var size: GalaxySize = GalaxySize.MEDIUM
@export var difficulty: Difficulty = Difficulty.NORMAL
@export var opponents: int = 3
@export var race: Race
