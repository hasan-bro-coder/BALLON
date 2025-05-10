extends Node2D

func play(name: String,callback=func():pass):
	$AnimationPlayer.play(name)
	await $AnimationPlayer.animation_finished
	callback.call()
