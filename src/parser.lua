parser = {}

-- create memory 
-- memory cells
mem = {}
-- string bank
strbank = {}
-- stack cache
stkch = {}

function parser.init()
    for mc = 1, 19, 1 do
        table.insert(mem, 1, 0)
    end
    if shellDebugMode then
        print(debug.showTableContent(mem))
    end
end

function parser.reset()
    mp = 1
    for mc = 1, #mem, 1 do
        mem[mc] = 0
    end
    for mc = #strbank, 1, -1 do
        table.remove(strbank, mc)
    end
    clearTokens()
end

-- memory variables --
mp = 1


-- local functions --
tkn = {}
function clearTokens()
    for i = #tkn, 1, -1 do
        table.remove(tkn, 1)
    end
end

-- parser --
function parser.runFile(filename)
    script = io.open(filename)
    lines = script:lines()
    for line in lines do  
        --print(line)
        parser.run(line)
    end
end

function parser.run(inst)
    clearTokens()
    tkn = stringx.split(inst, " ")
    --print(debug.showTableContent(tkn))

    if mp < 1 then
        error("out of range")
    end
    if mp > #mem then
        error("out of range")
    end

    if tkn[1] == "jmp" then
        if tkn[2] ~= nil then
            mp = tonumber(tkn[2])
        else
            error("Token 2 cant be null")
        end
    end
    ------------------
    -- Pop commands --
    ------------------
    if tkn[1] == "pop" then
        if tkn[2] == "+" then
            if tkn[3] ~= nil then
                curvalue = mem[mp]
                mem[mp] = curvalue + tonumber(tkn[3])
                if mem[mp] < 0 then
                    mem[mp] = 256
                end
                if mem[mp] > 256 then
                    mem[mp] = 0
                end
            else
                error("can't do operation with null values")
            end
        elseif tkn[2] == "-" then
            if tkn[3] ~= nil then
                curvalue = mem[mp]
                mem[mp] = curvalue - tonumber(tkn[3])
                if mem[mp] < 0 then
                    mem[mp] = 256
                end
                if mem[mp] > 256 then
                    mem[mp] = 0
                end
            else
                error("can't do operation with null values")
            end
        else
            error("Invalid operation")
        end 
    end
    ------------------
    -- Out commands --
    ------------------
    if tkn[1] == "out" then
        if tkn[2] ~= nil then
            print(tonumber(mem[mp]))
        else
            error("Token 2 cant be null")
        end
    end

    if tkn[1] == "outS" then
        if tkn[2] ~= nil then
            print(string.char(mem[mp]))
        else
            error("Token 2 cant be null")
        end
    end

    -- out string bank command --

    if tkn[1] == "osb" then
        if tkn[2] ~= nil then
            print(strbank[tonumber(tkn[2])])
        else
            error("Token 2 cant be null")
        end
    end

    -------------------
    -- Match command --
    -------------------
    if tkn[1] == "mtc" then
        -- create temp banks
        str_bytes = {}
        -- split parameters
        param = stringx.split(tkn[2], ";")
        -- convert bytes to chars
        for b = 1, #param, 1 do
            table.insert(str_bytes, b, string.char(mem[b]))
        end
        table.insert(strbank, 1, table.concat(str_bytes, ""))

    end

    -------------------
    -- Input command --
    -------------------

    if tkn[1] == "inp" then
        if tkn[2] ~= nil then
            val = io.read("*l")
            if tonumber(val) < 256 and tonumber(val) > 0 then
                mem[tonumber(tkn[2])] = tonumber(val)
            else
                error("value out of range")
            end
        else
            error("Token 2 cant be null")
        end
    end

    ----------------------
    -- compare commands --
    ----------------------

    if tkn[1] == "cmp" then
        if string.gmatch(tkn[2], "%d:%d") then
            args = stringx.split(tkn[2], ":")
            if mem[tonumber(args[1])] == mem[tonumber(args[2])] then
                cmd = string.gsub(inst, "cmp%s%d:%d%s", "")
                parser.run(cmd)
            end
        end
        for i = #args, 1, -1 do
            table.remove(args, 1)
        end
    end

    -------------------
    -- Push commands --
    -------------------

    if tkn[1] == "psh" then
        args = stringx.split(tkn[2], "->")
        mem[tonumber(args[2])] = mem[tonumber(args[1])]
    end

    --------------------
    -- reset commands --
    --------------------

    if tkn[1] == "rst" then
        if tkn[2] ~= nil then
            mem[tonumber(tkn[2])] = 0
        end
    end

    if tkn[1] == "frst" then
        for mc = 1, #mem, 1 do
            mem[mc] = 0
        end
    end

    -- string bank --

    if tkn[1] == "srin" then
        if tkn[2] ~= nil then
            table.remove(strbank, tonumber(tkn[2]))
        end
    end

    if tkn[1] == "strm" then
        for mc = #strbank, 1, -1 do
            table.remove(strbank, mc)
        end
    end
end


return parser