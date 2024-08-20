extends AudioStreamPlayer

var muted := false:
	set(value):
		muted = value
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, muted)

func _process(_delta):
	if Input.is_action_pressed("mute"):
		muted = !muted
