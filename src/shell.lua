shell = {}

parser = require 'src.parser'
stringx = require 'pl.stringx'
debug = require 'src.debug'
shellDebugMode = true

parser.init()

function shell.rs(filename)
    
    parser.reset()
    print("running " .. filename)
    parser.runFile(filename)
    if shellDebugMode then
        print(debug.showTableContent(mem))
        print(debug.showTableContent(strbank))
    end
end


return shell