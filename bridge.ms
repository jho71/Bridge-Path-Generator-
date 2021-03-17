struct Turtle(   --struct Turtle
	-- data members
	position_ = [0,0,0], -- initially at origin
	heading_ = [1,0,0], -- initially pointing up
	heading1_ = [0,1,0],
	heading2_ = [1,1,0],
	
	rotationQuat_ = quat 0 0 0 1,  -- identity quaternion
	
	-- member functions
	fn bridge boardColor =(
			angleVal = 25
			reduceAngle = 0
			for i = 1 to 8 do (
				
		p = box pos:[position_.x, position_.y, position_.z+5 ] length:80	width:16 height:5 wirecolor:boardColor
				position_.z +=(-i+10)
				q = quat -angleVal [0,1,0]  -- creates a quaternion representing a turn of
		                                         --turnAngle around the y axis
				
				angleVal = angleVal - (3 - reduceAngle)
				reduceAngle += -.10
		rotate p (q * rotationQuat_)
		position_=position_ + 19.12 * heading_
		
			)
				for i = 1 to 4 do (
					
			p = box pos:[position_.x, position_.y, position_.z +6] length:80	width:16 height:5 wirecolor:boardColor
				
				q = quat 0 [0,1,0]  -- creates a quaternion representing a turn of
		                                         --turnAngle around the y axis
				if i ==2 do (
					position1_= position_ + 8.6 * heading_
		
					support = box pos:[position1_.x, position1_.y, position1_.z +6] length:400 width:5 height:16 wirecolor:boardColor lengthsegs:10 widthsegs:1
					
					
					position1_= position1_ - 20 * heading1_
					support1 = box pos:[position1_.x, position1_.y, position1_.z +6] length:400 width:5 height:16 wirecolor:boardColor lengthsegs:10 widthsegs:1
					
					addmodifier support (bend())
					support.bend.bendangle = -60
					support.bend.bendAxis = 1
					
						
					addmodifier support1 (bend())
					support1.bend.bendangle = -60
					support1.bend.bendAxis = 1
	
					q = quat -90 [0,0,1]  -- creates a quaternion representing a turn of
		            q1 = quat -90 [0,1,0]                       --turnAngle around the y axis
					rotationQuat1_ = (q + q1) * rotationQuat_  -- update the quaternion that represents
					rotate support1 rotationQuat1_
					rotate support rotationQuat1_
	
					
					)
					
		position_=position_ + 19.12 * heading_
				)
				
				angleVal = 0.5

			for i = 1 to 8 do (
				
		p = box pos:[position_.x, position_.y, position_.z +5 ] length:80	width:16 height:5 wirecolor:boardColor
				position_.z -=(i+2.3)
				q = quat -angleVal [0,1,0]  -- creates a quaternion representing a turn of
		                                         --turnAngle around the y axis
				
				angleVal = angleVal - (3+ reduceAngle)
	
				reduceAngle += .30
		rotate p (q * rotationQuat_)
		position_=position_ + 19.12 * heading_
		
			)
			
	),

	fn straight boardColor=(
		
			for i = 1 to 10 do (
		p = box pos:position_ length:80	width:16 height:5 wirecolor:boardColor

		position_=position_ + 19.12 * heading_
				
		rotate p rotationQuat_
		

			)

			
	
	),
	fn left includeLamp boardColor lampColor  = (
		for i = 1 to 10 do (
		
		p= box pos:position_ length:80	width:11.5 height:5 wirecolor:boardColor
				if  includeLamp == true then  ( 
				if i == 5 then  (
				lampPost = Cylinder pos:[p.pos.x*1.3  ,p.pos.y*1.3 - 60 ,p.pos.z ] radius:2.5 height:50 wirecolor:lampColor
				lampBase = cone pos:[p.pos.x*1.3  ,p.pos.y*1.3 - 60 ,p.pos.z ] radius2:.5  height:5  wirecolor:lampColor
				lamp = sphere pos:[p.pos.x*1.3  ,p.pos.y*1.3 - 60 ,p.pos.z+50 ] radius:5 wirecolor:yellow
			)
				)
			
		--	convertToPoly(p)
		q = quat 4.5 [0,0,1]  -- creates a quaternion representing a turn of
		                                         --turnAngle around the y axis
		rotationQuat_ = q * rotationQuat_  -- update the quaternion that represents
														    -- the rotation we need to apply to our object
		rotate p rotationQuat_
		
		invq = inverse q                             -- calculate the inverse quaternion to upedate turtle
		heading_=heading_* invq               -- use inverse quat to update our heading 
			position_=position_ + 15*heading_
		)
	),
	fn right includeLamp  boardColor lampColor=(
		for i = 1 to 10 do (
		p = box pos:position_ length:80	width:11.5 height:5 wirecolor:boardColor
			if  includeLamp == true then  ( 
				if i == 5 then  (
				lampPost = Cylinder pos:[p.pos.x*1.3 +120 ,p.pos.y*1.3 + 60 ,p.pos.z ] radius:2.5 height:50 wirecolor:lampColor
				lampBase = cone pos:[p.pos.x*1.3 +120 ,p.pos.y*1.3 + 60 ,p.pos.z  ] radius2:1 radius1:12 height:5  wirecolor:lampColor
	            lamp = sphere pos:[p.pos.x*1.3 +120 ,p.pos.y*1.3 + 60 ,p.pos.z +50 ] radius:5 wirecolor:yellow
				)
				)
				
		q = quat -4.5 [0,0,1]  -- creates a quaternion representing a turn of
		                                         --turnAngle around the y axis
		
		rotationQuat_ = q * rotationQuat_  -- update the quaternion that represents
														    -- the rotation we need to apply to our object
		
			rotate p rotationQuat_
		
		invq = inverse q                             -- calculate the inverse quaternion to update turtle
		heading_=heading_* invq               -- use inverse quat to update our heading 
	position_=position_ + 15 * heading_
	)
)
)

fn generatePath thePath includeLamp boardColor lampColor = (
	t = Turtle()
	for i = 1 to thePath.count+1 do (
		if thePath[i] == "left" then (
			t.left includeLamp boardColor lampColor
		)
				else if thePath[i] == "straight" then (
			t.straight boardColor
			)
				else if thePath[i] == "right" then(
			t.right includeLamp boardColor lampColor
					
			)  else if thePath[i] == "bridge" do (
			t.bridge(boardColor)
			)
				
			)
		)
	fn parsePath txt =(
		arrayPath =#()
		if txt.count == 0 then (
		arrayPath = #("left","left","left","left","left", "left", "straight", "straight", "right", "right", "right", "right", "right", "right", "bridge")
			)
		for i = 1 to txt.count do (
			if txt[i] =="s" then (
				append arrayPath  "straight"
				)
				else if txt[i] == "b"then(
					append arrayPath "bridge"
					)
					else if txt[i] == "l"then(
					append arrayPath  "left"
					)
					else if txt[i] == "r"then(
					append arrayPath  "right"
					)
					else (
						messageBox "error, only insert letters (s,b,r,l no spaces)"
						break
						)
					
			)
		return arrayPath
		)
function deleteObj = (
	delete objects
	)
--picketFence 0 0 0 10 4 white -- z, y, z, diretion, numSeg, colour
	try(destroyDialog myUIExample )catch()
rollout myUIExample "Path Generator" (
    group "Settings" (
        
		checkbox decorations "Include lamps"
		
		colorpicker boardColor "Boardwalk color :" color:brown 
		colorpicker lampColor "Lamp color :" color:black  
		
		edittext list_txt "List peices:(s = Straight, b = Bridge, l = Left, r = Right)" fieldWidth:200 labelOnTop:true 
		
		button generatePathButton "Generate path (if List pieces blank then figure 8!)"	
		
		button deleteButton "Delete all objects"
    )
    on generatePathButton pressed do(
		
     
		thePath = parsePath list_txt.text

		generatePath thePath decorations.state boardColor.color lampColor.color
	
 	
    )
	on deleteButton pressed do (
		deleteObj()
		)
)
createDialog myUIExample 400 300
