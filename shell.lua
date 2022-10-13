function main()
    parser = require 'src.parser'
    stringx = require 'pl.stringx'
    switch = require 'src.switch'
    shellDebugMode = false

    parser.init()

    str = io.read("*l")
    if str ~= nil then
        print("running")
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