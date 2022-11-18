//
//  StringsParserMain.swift
//  
//
//  Created by Peter Easdown on 18/11/2022.
//

import Foundation
import StringsParser

@main
struct StringsParserExecutable {
    
    static func main() throws {
        // We need at least one argument (the filename).   the zeroth argument is the name of the command, and
        // the 1st is our actual argument.
        //
        if ProcessInfo.processInfo.arguments.count > 1 {
            let path = ProcessInfo.processInfo.arguments[1]
            
            // create a parser
            let parser : StringsParser = StringsParser(fileName: path)
            
            // and parse the file.
            if parser.parse() {
                exit(1)
            } else {
                exit(0)
            }
        } else {
            print("validatestrings script requires a single argument specifying the path of a *.strings file.")
            exit(1)
        }
    }
    
}
