extends Node2D


func _on_pit_area_entered(area):
	%ResetTimer.start()

func _on_reset_timer_timeout():
	%Ball.reset_ball()
