@tool
extends ViewTarget
class_name CharacterViewTarget


@onready var player: PlayerCharacter = $'../PlayerCharacter'


func _ready(): $'../Camera'.push(self)


func _process(_delta): position = player.position

