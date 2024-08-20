extends Node2D

var itemBall = preload("res://assets/objects/item.tscn")
var lives := 3:
	set(value):
		lives = value
		if lives < 3:
			$hearts.get_child(lives).visible = false
		if lives == 0:
			$req.die()
var score := 0:
	set(value):
		score = value
		$score.text = "SCORE: "+str("%010d" % score)

func _ready() -> void:
	var nums = []
	for i in 350:
		nums.append(i)
	while !nums.is_empty():
		var item = itemBall.instantiate()
		var num = nums.pick_random()
		item.itemNum = num
		nums.erase(num)
		item.position = Vector2(randi_range(200,700),-100)
		$items.add_child(item)
