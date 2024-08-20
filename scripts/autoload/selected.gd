extends Node2D

var roundTime := 10:
	set(value):
		roundTime = clamp(value,5,30)
		$Label.text = str(roundTime)
		$Label.visible = true
		await get_tree().create_timer(1).timeout
		$Label.visible = false

var selected := false:
	set(value):
		selected = value
		if !selected:
			$Sprite2D.visible = false
			$Button.grab_focus()
var itemNum := -1:
	set(value):
		itemNum = value
		if itemNum != -1:
			$Sprite2D.frame = itemNum
			selected = true
			$Sprite2D.visible = true
		else:
			selected = false
			$Sprite2D.visible = false
var rot := 0.0
var scl := 1.0

func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("difUp"):
		roundTime += 1
	if Input.is_action_just_pressed("difDown"):
		roundTime -= 1
	
	if Input.is_action_pressed("unclick"):
		itemNum = -1
		$audio.play()
	
	if !selected: 
		return
	
	$Sprite2D.visible = true
	
	if Input.is_action_pressed("up"):
		scl += .05
	elif Input.is_action_pressed("down"):
		scl -= .05
	scl = clamp(scl,0.5,2)
	
	if Input.is_action_pressed("left"):
		rot -= TAU/90
	elif Input.is_action_pressed("right"):
		rot += TAU/90
	
	if rot < 0:
		rot += TAU
	elif rot > TAU:
		rot -= TAU
		
	$Sprite2D.rotation = rot
	$Sprite2D.scale = Vector2(1,1) * scl
	
