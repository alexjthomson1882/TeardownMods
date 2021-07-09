function init()
	-- get audio:
	jetpackLoop = LoadLoop("jetpack_loop.ogg")
	-- get power:
	power = GetFloat("savegame.mod.power")
	if power <= 0.0 then power = 22.0 end
	-- create keybind table:
	local keybindTable = {
		"space", -- 1
		"ctrl",  -- 2
		"shift", -- 3
		"z",     -- 4
		"x",     -- 5
		"c",     -- 6
		"v",     -- 7
		"g",     -- 8
		"q",     -- 9
		"alt"    -- 10
	}
	-- get keybind:
	local keybindValue = GetFloat("savegame.mod.keybind") -- get keybind value
	if keybindValue <= 0.0 or keybindValue > table.getn(keybindTable) then keybind = "space" -- out of range check
	else
		keybindValue = math.floor(keybindValue) -- floor keybind value
		if keybindValue < 1.0 then
			keybindValue = 1.0
		elseif keybindValue > table.getn(keybindTable) then
			keybindValue = table.getn(keybindTable)
		end
		keybind = keybindTable[keybindValue]
	end
	active = false
end

function update(deltaTime)
	if GetPlayerVehicle() == 0 then -- player not in vehicle
		if InputDown(keybind) then -- keybind is held
			local transform = GetCameraTransform() -- get reference to camera transform
			local thrust = TransformToParentVec(transform, Vec(0, power * deltaTime, 0)) -- calculate thrust vector
			local velocity = GetPlayerVelocity() -- get player velocity
			velocity = VecAdd(velocity, thrust) -- add thrust vector to player velocity
			SetPlayerVelocity(velocity) -- update the player velocity
			PlayLoop(jetpackLoop, transform.pos, 0.5) -- play the jetpack loop at the transform position
		end
	end
end