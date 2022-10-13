parser = {}
debug = require 'src.debug'

-- create memory 
mem = {}
strbank = {}

function parser.init()
    for mc = 1, 256, 1 do
        table.insert(mem, 1, 0)
    end
    if shellDebugMode then
        print(debug.showTableContent(mem))
    end
    
end

-- memory variables --
mp = 1
strbkP = 1

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
    tkn = stringx.split(inst, " ")

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
    if tkn[1] == "pop[+]" then
        if tkn[2] ~= nil then
            curvalue = mem[mp]
            mem[mp] = curvalue + tonumber(tkn[2])
            if mem[mp] < 0 then
                mem[mp] = 256
            end
            if mem[mp] > 256 then
                mem[mp] = 0
            end
        else
            error("Token 2 cant be null")
        end 
    end
    if tkn[1] == "pop[-]" then
        if tkn[2] ~= nil then
            curvalue = mem[mp]
            mem[mp] = curvalue - tonumber(tkn[2])
            if mem[mp] < 0 then
                mem[mp] = 256
            end
            if mem[mp] > 256 then
                mem[mp] = 0
            end
        else
            error("Token 2 cant be null")
        end 
    end
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

    if tkn[1] == "osb" then
        if tkn[2] ~= nil then
            print(strbank[tonumber(tkn[2])])
        else
            error("Token 2 cant be null")
        end
    end


    clearTokens()
end


return parser