# Rooms by Facebook
# Animations created by Jinju Jang

#Checklist
# - Carousel (done)
# - Snaps when scrolling is stopped
# - Click event = Enlarge current (center) frame (done)

# Set up BG
bg = new BackgroundLayer backgroundColor: "#F2f2f2"
bg.bringToFront()
# bg.backgroundColor = currentIndex.backgroundColor
# Unit Variables
units = 8
gutter = 24
width  = 480 
height = 720
cellArray = []
cellXArray = []
xDistance = width + gutter

# Carousel Layer

carousel = new ScrollComponent
	width: Screen.width
	height: Screen.height
	backgroundColor: "transparent"
	contentInset: {left: 0, right: gutter}

	
carousel.center()
carousel.speedX = 1
carousel.speedY = 0
 
	

# Container for our Array
Layers = []
# Retreive the y position of a layer by reading its index
getFrameByIndex = (index) ->
	return { x: index * xDistance, width: width }

# Retreive the index of a layer by reading its y position
getIndexByFrame = (frame) ->
	index = parseInt((frame.x + (frame.width / 2)) / xDistance)

# Retreive the layer by reading an index
layerAtIndex = (index) ->
	for cell in Layers
		if cell.listIndex is index
			return cell
	

for index in [0...units]
	cell = new Layer
		superLayer: carousel.content
		width:  width
		height: height 
		x: gutter + index * xDistance
		borderRadius: 6
		backgroundColor: "hsla(#{index/units*360},60%,50%,1)"
	
	cellArray.push(cell)
	cellXArray.push(cell.x)
	
	cell.centerY()

	cover = new Layer
		opacity: 0.0
	cover.center()
	# Assign indeces
	cell.listIndex = index

	cell.on Events.Move, (event, layer) ->
		# Get the index of the layer being dragged
		currentIndex = getIndexByFrame(cell.frame)
		# When dragged at enough index...
		if currentIndex != this.listIndex && currentIndex >= 0 && currentIndex <= 3
			# When the index of the dragged layer equals that of another layer
			hoveredLayer = layerAtIndex(currentIndex)
			# Switch indeces of said layers
			cell.listIndex = currentIndex	

	
	# On DragStart
	cell.on Events.TouchStart, (event, layer) ->
		currentIndex = getIndexByFrame(this.frame)
		this.bringToFront()
		this.shadowColor = "rgba(0,0,0,0.2)"
		
		this.animate
			properties:
				shadowY: 16
				shadowBlur: 32
			curve: "ease"
			
		this.animate 
			properties:
				scale: 1.1
			curve: "spring(600,50,0)"
		
			
	# On DragEnd		
	cell.on Events.TouchEnd, (event, layer) ->
		this.animateStop()
		this.animate 
			properties:
				scale: 1
			curve: "spring(300,50,0)"
			# Reset index when dragging too far out of array
		
		cover.backgroundColor = this.backgroundColor

