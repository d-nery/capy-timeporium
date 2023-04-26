extends AnimatableBody2D

func change_to_front():
    var frame = $Sprite2D.frame
    if frame > 4:
        return
    $Sprite2D.frame = frame + 4
