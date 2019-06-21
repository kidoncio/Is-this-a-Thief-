extends Node

const LENGTH: int = 4

func generate_combination(length: int = LENGTH) -> Array:
	var combination = []
	
	for number in range(length):
		randomize()
		
		combination.append(randi() % 10)
	
	return combination