extends Node

#@onready var music_slow: AudioStreamPlayer = $music_slow
#@onready var lose: AudioStreamPlayer = $lose
#@onready var win: AudioStreamPlayer = $win
#@onready var next_round: AudioStreamPlayer = $next_round


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func fade(node: Node):
	pass

func play_sound(soundName):
	var sound = get_node_or_null(soundName)
	if sound:
		sound.play()
	else:
		print("couldnt play " + soundName)
		#push_warning("AudioManager: sound not found: " + soundName)

func stop_sound(soundName):
	var sound = get_node_or_null(soundName)
	if sound:
		sound.stop()
	else:
		print("couldnt find " + soundName)
		

func pause_sound(soundName):
	var sound = get_node_or_null(soundName)
	if sound:
		sound.stream_paused = true
	else:
		print("couldnt find " + soundName)

func unpause_sound(soundName):
	var sound = get_node_or_null(soundName)
	if sound:
		sound.stream_paused = false
	else:
		print("couldnt find " + soundName)

#func play(soundName):
	#
	
	#for i in get_children():
		#if i.name == soundName:
			#i.play()
			#print()
			#break
	
	#print(find_child(soundName, false, true))
	#find_child(name, false, true) #.play()
	#get_node(name)
