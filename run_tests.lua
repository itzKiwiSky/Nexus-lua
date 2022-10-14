dir = require 'pl.dir'
shell = require 'src.shell'
debug = require 'src.debug'

function main()
    files = dir.getallfiles("tests")
    for i = 1, #files, 1 do
        shell.rs(files[i])
    end
end

main()