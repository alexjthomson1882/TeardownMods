function init()
	power = GetFloat("savegame.mod.power")
	if power == 0.0 then power = 20.0 end
end

function draw()
	UiTranslate(UiCenter(), 350)
	UiAlign("center middle")

	UiFont("bold.ttf", 48)
	UiText("QuackyBoi's Jetpack")
	UiFont("regular.ttf", 26)
	UiTranslate(0, 70)
	UiPush()
		UiText("Power")
		UiAlign("right")
		UiTranslate(95, 40)
		power = optionsSlider(power, 5, 100)
		UiTranslate(-75, 20)
		UiColor(0.2, 0.6, 1)
		UiText(power)
		SetFloat("savegame.mod.power", power)
	UiPop()

	UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)

	UiTranslate(0, 120)
	if UiTextButton("Close", 80, 40) then
		Menu()
	end
end

function optionsSlider(val, min, max)
	UiColor(0.2, 0.6, 1)
	UiPush()
		UiTranslate(0, -8)
		val = (val-min) / (max-min)
		local w = 195
		UiRect(w, 3)
		UiAlign("center middle")
		UiTranslate(-195, 1)
		val = UiSlider("ui/common/dot.png", "x", val*w, 0, w) / w
		val = round((val*(max-min)+min), 2)
	UiPop()
	return val
end

function round(number, decimals)
    local p = 10^decimals
    return math.floor(number * p) / p
end