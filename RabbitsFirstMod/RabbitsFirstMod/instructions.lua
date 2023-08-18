-- Local references for shorter names and avoiding global lookup on every use
local Get, GetNum, GetId, GetEntity, AreEqual, Set = InstGet, InstGetNum, InstGetId, InstGetEntity, InstAreEqual, InstSet

local cat = { 'Rabbit', 'Rabbit.Binary' }

data.instructions.rabbit_modulo =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num % GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "Modulo",
	desc = "Returns remainder of division",
	category = cat[1],
	icon = "RabbitsFirstMod/img/modulo.png",
}

data.instructions.rabbit_random =
{
	func = function(comp, state, cause, from, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = math.random(r.num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "out", "To" },
	},
	name = "Random",
	desc = "Random integer. LUA: math.random(r.num)",
	category = cat[1],
}

data.instructions.rabbit_random_between =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		local g = GetNum(comp, state, num)
		if g > r.num then
			r.num = math.random(r.num, g)
		elseif g < r.num then
			r.num = math.random(g, r.num)
		end
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "Random Between",
	desc = "Random integer between two values",
	category = cat[1],
}

data.instructions.rabbit_print =
{
	func = function(comp, state, cause, from)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		print(r.num)
	end,
	args = {
		{ "in", "From", nil, "num" },
	},
	name = "Print",
	desc = "Print to debug console",
	category = cat[1],
}

-- Bitwise, Binary

data.instructions.rabbit_bwand =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num & GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "AND",
	desc = "Bitwise AND",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwand.png",
}

data.instructions.rabbit_bwor =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num | GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "OR",
	desc = "Bitwise OR",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwor.png",
}

data.instructions.rabbit_bwxor =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num ~ GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "XOR",
	desc = "Bitwise XOR",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwxor.png",
}

data.instructions.rabbit_bwl =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num << GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "Left Shift",
	desc = "Bitwise Left Shift",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwl.png",
}

data.instructions.rabbit_bwr =
{
	func = function(comp, state, cause, from, num, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = r.num >> GetNum(comp, state, num)
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "in",  "Num",  nil, "num" },
		{ "out", "To" },
	},
	name = "Right Shift",
	desc = "Bitwise Right Shift",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwr.png",
}

data.instructions.rabbit_bwnot =
{
	func = function(comp, state, cause, from, to)
		local r = Tool.NewRegisterObject(Get(comp, state, from)) -- copy to avoid changing from
		r.num = ~r.num
		Set(comp, state, to, r)
	end,
	args = {
		{ "in",  "From", nil, "num" },
		{ "out", "To" },
	},
	name = "NOT",
	desc = "Bitwise NOT",
	category = cat[2],
	icon = "RabbitsFirstMod/img/bwnot.png",
}
