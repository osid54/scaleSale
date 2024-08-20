extends StaticBody2D

var itemNum := -1
var rot := 0.0
var scl := 1.0
var dead = false

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	setup()

func setup():
	if dead:
		return
	$item.visible = true
	itemNum = randi_range(0,349)
	rot = randf_range(0,TAU)
	scl = randf_range(0.5,2)
	$item.frame = itemNum
	$item.rotation = rot
	$item.scale = Vector2(1,1) * scl
	$Timer.wait_time = Selected.roundTime
	$Timer.start()

func _process(_delta: float) -> void:
	$TextureProgressBar.value = $Timer.time_left/$Timer.wait_time * 100
	if Input.is_action_pressed("reset"):
		_on_reset_button_down()

func _on_timer_timeout() -> void:
	get_parent().lives -= 1
	Selected.selected = false
	$audio.stream = load("res://src/audio/MI_SFX 17.mp3")
	$audio.play()
	setup()

func _on_button_button_down() -> void:
	if Selected.selected:
		if Selected.itemNum == itemNum:
			#print(rot,"\t",Selected.rot,"\t",int(500*(1-absf(rot-Selected.rot)/Selected.rot)))
			#print(scl,"\t",Selected.scl,"\t",int(500*(1-absf(scl-Selected.scl)/Selected.scl)))
			get_parent().score += 100 + int(100*$Timer.time_left/$Timer.wait_time) + int(500*(1-absf(rot-Selected.rot)/Selected.rot)) + int(500*(1-absf(scl-Selected.scl)/Selected.scl))
			$audio.stream = load("res://src/audio/MI_SFX 43.mp3")
			$audio.play()
		else:
			get_parent().lives -= 1
			$audio.stream = load("res://src/audio/MI_SFX 17.mp3")
			if get_parent().lives == 0:
				$audio.stream = load("res://src/audio/MI_SFX 20.mp3")
			$audio.play()
		Selected.selected = false
		setup()

func die():
	$Timer.stop()
	$item.visible = false
	$Button.visible = false
	$reset.visible = true
	dead = true

func _on_reset_button_down() -> void:
	Selected.selected = false
	get_tree().reload_current_scene()
