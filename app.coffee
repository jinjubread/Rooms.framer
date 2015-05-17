# Rooms

# Set up BG
bg = new BackgroundLayer backgroundColor: "#F2f2f2"
bg.bringToFront()

# Unit Variables
units = 3
gutter = 20
width  = 480
height = 720
xDistance = width + gutter
cellIndex = 1
cellArray = []

# Carousel Layer
carousel = new Layer
	width: ((units-1) * gutter) + units * width
	height: height
	backgroundColor:"Transparent"
carousel.centerY()

# Loop to create layers
for index in [0...units]
		
	cell = new Layer
		superLayer: carousel
		width:  width
		height: height 
		x: -360 + index * (width + gutter)
		borderRadius: 6
		backgroundColor: "hsla(#{index/units*360},60%,50%,1)"
	cellArray.push(cell)
	
	cell.on Events.Click, ->
		print "clicked"
				
# print Utils.modulate(cell.midX, [0, Screen.width], [0, cellArray.length]) 
	
# bg.backgroundColor = cellArray[cellIndex].backgroundColor
