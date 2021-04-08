function init()
	jetpackLoop = LoadLoop("jetpack_loop.ogg")
	power = GetFloat("savegame.mod.power")
	if power == 0 then power = 20 end
	local keybindTable = {
		"space", -- 1
		"ctrl",  -- 2
		"shift", -- 3
		"z",     -- 4
		"x",     -- 5
		"c",     -- 6
		"v",     -- 7
		"g",     -- 8
		"q"      -- 9
	}
	local keybindValue = math.floor(GetFloat("savegame.mod.keybind"))
	if keybindValue < 1 then
		keybindValue = 1
	elseif keybindValue > table.getn(keybindTable) then
		keybindValue = table.getn(keybindTable)
	end
	keybind = keybindTable[keybindValue]
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