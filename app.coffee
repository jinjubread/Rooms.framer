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

# Way 1 
carousel = new ScrollComponent
	width: Screen.width + 850
	height: height
	backgroundColor:"Transparent"
	contentInset: {left: gutter, right: gutter}

carousel.centerY()
carousel.speedY = 0
carousel.speedX = 0.5

# Loop to create layers
for index in [0...units]
		
	cell = new Layer
		superLayer: carousel.content
		width:  width
		height: height 
		x: index * (width + gutter)
		borderRadius: 6
		backgroundColor: "hsla(#{index/units*360},60%,50%,1)"
	cellArray.push(cell)
	cell.on Events.Click, ->
	print cell.frame
				
# print Utils.modulate(cell.midX, [0, Screen.width], [0, cellArray.length]) 
	
# bg.backgroundColor = cellArray[cellIndex].backgroundColor

print cellArray[0].x

