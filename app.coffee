# Rooms by Facebook
# Animations created by Jinju Jang

#Checklist
# - Snaps when scrolling is stopped
# - Click event = Enlarge current (center) frame

# Set up BG
bg = new BackgroundLayer backgroundColor: "#F2f2f2"
bg.bringToFront()

# Unit Variables
units = 10
gutter = 24
width  = 480
height = 720
cellArray = []
cellXArray = []
xDistance = width + gutter
# Way 1 
# carousel = new ScrollComponent
# 	width: Screen.width + 850
# 	height: height
# 	backgroundColor:"Transparent"
# 	contentInset: {left: gutter, right: gutter}
# 
# carousel.centerY()
# carousel.speedY = 0
# carousel.speedX = 0.5

# Loop to create layers
for index in [0...units]
		
	cell = new Layer
		width:  width
		height: height 
		x: gutter + index * xDistance
		borderRadius: 6
		backgroundColor: "hsla(#{index/units*360},60%,50%,1)"
	
	cell.centerY()	
	cellArray.push(cell)
	cellXArray.push(cell.x)
	
	# Assign indeces
	cell.listIndex = index
			
	# Make draggable
	cell.draggable.enabled = true
	cell.draggable.speedX = 0
	cell.draggable.speedY = 1
		

cell.on Events.Click, ->
	cell.animate
		properties:
			x: cellXArray[index] + xDistance
		currentIndex = parseInt((cell.frame.y + (cell.frame.height / 2)) / xDistance)

	
	print cell.frame
	print cellXArray[0]
	
				
# print Utils.modulate(cell.midX, [0, Screen.width], [0, cellArray.length]) 
	
# bg.backgroundColor = cellArray[cellIndex].backgroundColor

