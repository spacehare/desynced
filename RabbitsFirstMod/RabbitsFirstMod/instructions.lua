-- Local references for shorter names and avoiding global lookup on every use
local Get, GetNum, GetId, GetEntity, AreEqual, Set, BeginBlock  = InstGet, InstGetNum, InstGetId, InstGetEntity, InstAreEqual, InstSet, InstBeginBlock

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

data.instructions.for_each_input_x_10 =
{
	func = function(comp, state, cause, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, out_data, exec_done)
        --set to 2 as the first spot is used to store our current position
        local it = { 2 }
        it[#it+1] = in1
        it[#it+1] = in2
        it[#it+1] = in3
        it[#it+1] = in4
        it[#it+1] = in5
        it[#it+1] = in6
        it[#it+1] = in7
        it[#it+1] = in8
        it[#it+1] = in9
        it[#it+1] = in10
		return BeginBlock(comp, state, it)
	end,

	next = function(comp, state, it, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, out_data, exec_done)
		local i = it[1]
        while i <= #it do
            local value = Get(comp, state, it[i])
            if not value or value.is_empty then
                i = i + 1
            else
                Set(comp, state, out_data, value )
		        it[1] = i + 1
                return
            end
        end
        --if we get here then we reached the end of the items so return true to stop looping
        it[1] = i
		return true
	end,

	last = function(comp, state, it, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, out_data, exec_done)
		Set(comp, state, out_data, nil)
		state.counter = exec_done
	end,

	args = {
		{ "in", "Input 1", "Input 1", "data" },
        { "in", "Input 2", "Input 2", "data" },
        { "in", "Input 3", "Input 3", "data" },
        { "in", "Input 4", "Input 4", "data", true },
        { "in", "Input 5", "Input 5", "data", true },
        { "in", "Input 6", "Input 6", "data", true },
        { "in", "Input 7", "Input 7", "data", true },
        { "in", "Input 8", "Input 8", "data", true },
        { "in", "Input 9", "Input 9", "data", true },
        { "in", "Input 10", "Input 10", "data", true },
		{ "out", "Current", "Current Input the loop is up to" },
		{ "exec", "Done", "Finished looping through all inputs" },
	},
	name = "Loop Inputs",
	desc = "Loops though and performs code for all 10 inputs if they have a value",
	category = "Flow",
	icon = "Main/skin/Icons/Special/Commands/Make Order.png",
}