extends RigidBody2D

@onready var hl = $sprite/highlight

var infocus := false

var itemNum := -1:
	set(value):
		itemNum = value
		$sprite.frame = itemNum

func _on_but_mouse_entered() -> void:
	if !infocus:
		hl.color = Color8(255,255,255,50)

func _on_but_mouse_exited() -> void:
	if !infocus:
		hl.color = Color8(255,255,255,0)

func _on_but_focus_entered() -> void:
	infocus = true
	hl.color = Color8(255,255,255,100)

func _on_but_focus_exited() -> void:
	infocus = false
	hl.color = Color8(255,255,255,0)
	
func _on_but_button_down() -> void:
	Selected.itemNum = itemNum
	Selected.rot = rotation
	Selected.scl = 1
	$audio.play()

var checkBad := false

func _ready():
	await get_tree().create_timer(3).timeout
	checkBad = true

func _process(_delta: float) -> void:
	if checkBad:
		if abs(position.x-450) > 450 or position.y > 900 or position.y < 16:
			resetPos()

func resetPos():
	checkBad = false
	randomize()
	position = Vector2(randi_range(200,700),-100)
	await get_tree().create_timer(5).timeout
	checkBad = true
	
