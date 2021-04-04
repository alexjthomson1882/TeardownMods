function init()
	snd = LoadLoop("jetpack.ogg")
	power = GetFloat("savegame.mod.power")
	if power == 0 then power = 20 end
end

function update(dt)
	--Only available if not in vehicle
	if GetPlayerVehicle() == 0 then
		--Check if space bar is down
		if InputDown("space") then
			--Add upwards velocity to player
			local t = GetCameraTransform()
			local d = TransformToParentVec(t, Vec(0, power * dt, 0))
			local vel = GetPlayerVelocity()
			vel = VecAdd(vel, d)
			SetPlayerVelocity(vel)

			--Play jet pack sound effect
			PlayLoop(snd, t.pos, 0.5)
		end
	end
end