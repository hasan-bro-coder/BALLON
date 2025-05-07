extends Node2D

func play(name: String,callback):
	$AnimationPlayer.play(name)
	await $AnimationPlayer.animation_finished
	callback.call()
