# Rooms by Facebook
# Animations created by Jinju Jang

#Checklist
# - Snaps when scrolling is stopped
# - Click event = Enlarge current (center) frame

# Set up BG
bg = new BackgroundLayer backgroundColor: "#F2f2f2"
bg.bringToFront()

# Unit Variables
units = 3
gutter = 24
width  = 480 / 3
height = 720
cellArray = []
cellXArray = []
xDistance = width + gutter

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
		width:  width
		height: height 
		x: gutter + index * xDistance
		borderRadius: 6
		backgroundColor: "hsla(#{index/units*360},60%,50%,1)"
	
	cellArray.push(cell)
	cellXArray.push(cell.x)
	
# 	cell.centerY()
	
	# Assign indeces
	cell.listIndex = index
	
	# Make draggable
	cell.draggable.enabled = true
	cell.draggable.speedX = 1
	cell.draggable.speedY = 0
	cell.html = cell.listIndex + 1
	cell.style.color = "#999"
	cell.style.lineHeight = height + 6 + "px"
	cell.style.paddingLeft = "32px"
	cell.style.fontSize = "24px"
	cell.style.fontWeight = "400"
	cell.shadowY = 1
	cell.shadowBlur = 2
	cell.style.boxShadow = "0 1px 3px rgba(0,0,0,0.2)"
	
	cell.on Events.DragMove, (event, layer) ->
		# Get the index of the layer being dragged
		currentIndex = getIndexByFrame(cell.frame)
# 		print currentIndex
		# When dragged at enough index...
		if currentIndex != this.listIndex && currentIndex >= 0 && currentIndex <= 3
			# When the index of the dragged layer equals that of another layer
			hoveredLayer = layerAtIndex(currentIndex)
			# Switch indeces of said layers
			hoveredLayer.listIndex = this.listIndex
			this.listIndex = currentIndex	
			
			# Label layers
			layer.html = layer.listIndex+1
			hoveredLayer.html = hoveredLayer.listIndex+1
			
			# Stop previous animation
			hoveredLayer.animateStop()
			# Animate to new position
			hoveredLayer.animate
				properties: getFrameByIndex(hoveredLayer.listIndex)
				curve: "spring(300,40,0)"
	
	# On DragStart
	cell.on Events.DragStart, (event, layer) ->
		currentIndex = getIndexByFrame(this.frame)
		this.bringToFront()
		this.shadowColor = "rgba(0,0,0,0.2)"
		
		this.animate
			properties:
				shadowY: 16
				shadowBlur: 32
			curve: "ease"
			time: 0.4
			
		this.animate 
			properties:
				scale: 1.1
			curve: "spring(600,50,0)"
			
	# On DragEnd		
	cell.on Events.DragEnd, (event, layer) ->
		this.animateStop()
		this.animate 
			properties:
				scale: 1
			curve: "spring(300,50,0)"
		
		# Reset index when dragging too far out of array
		currentIndex = getIndexByFrame(this.frame)
		if currentIndex < 0
			currentIndex = 0
		if currentIndex > 3
			currentIndex = 3
		
		this.animate 
			properties:
				shadowY: 1
				shadowBlur: 2
				x: currentIndex * xDistance
			curve: "spring(300,40,0)"
			
		# Reset index, delayed to prevent shadow cut-off
		Utils.delay 0.4, ->
			this.shadowColor = "rgba(0,0,0,0.2)"
			
				
# print Utils.modulate(cell.midX, [0, Screen.width], [0, cellArray.length]) 
	
# bg.backgroundColor = cellArray[cellIndex].backgroundColor

