function main()
    parser = require 'src.parser'
    stringx = require 'pl.stringx'
    switch = require 'src.switch'
    debug = require 'src.debug'
    shellDebugMode = false

    parser.init()

    str = io.read("*l")
    if str ~= nil then
        parser.reset()
        print("running " .. str)
        parser.runFile(str)
        if shellDebugMode then
            print(debug.showTableContent(mem))
            print(debug.showTableContent(strbank))
        end
    else
        error("type a valid filename")
    end
end

main()