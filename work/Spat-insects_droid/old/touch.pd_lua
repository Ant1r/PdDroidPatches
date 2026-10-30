local class = pd.Class:new():register("touch")

-- rendering speed (slows down rendering by the given factor)
-- In most cases it should be fine to just set this to 1 to run at full speed,
-- if you have a modern high-speed CPU and GPU. But we use a larger value as
-- default here to deal with low frame rates on some systems. You may have to
-- increase the value even further when running on low-spec systems like the
-- Raspberry Pi.
local R = 3

function class:initialize(sel, atoms)
    self.snd = "touch"
    self.W = 200
    self.H = 200
    if(atoms) then
        if(atoms[1]) then self.W = atoms[1] end
        if(atoms[2]) then self.H = atoms[2] end
        if(atoms[3]) then self.snd = atoms[3] end
    end
    self:set_size(self.W, self.H)
    return true
end

function math.clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function class:mouse_down(x, y)
    pd.send(self.snd, "list", {x / self.W, y / self.H})
end

function class:mouse_up(x, y)
    pd.send(self.snd, "list", {-1, -1})
end

function class:mouse_drag(x, y)
    pd.send(self.snd, "list", {x / self.W, y / self.H})
end

function class:paint(g)
    g:set_color(200, 200, 200)
    g:fill_all()
end

