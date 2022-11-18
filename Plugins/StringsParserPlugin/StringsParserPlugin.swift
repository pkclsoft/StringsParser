//
//  File.swift
//  
//
//  Created by Peter Easdown on 18/11/2022.
//

import Foundation
import PackagePlugin

/// Make sure that this script is not included in any targets, as this @main declaration will conflict with that of your actual target.
@main
struct StringsParserPlugin : BuildToolPlugin {
    
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let outputPath = context.pluginWorkDirectory
            .appending(["StringsParserOutput.swift"])
        
        return [
            .buildCommand(
                displayName: "Strings Parser",
                executable: try context.tool(named: "StringsParserExecutable").path,
                arguments: [ ProcessInfo.processInfo.arguments[1] ],
                outputFiles: [outputPath]
            )
        ]
    }

}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension StringsParserPlugin : XcodeBuildToolPlugin {
    
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [PackagePlugin.Command] {
        
        let stringsPaths = target.inputFiles
            .filter({ $0.path.lastComponent.hasSuffix("strings")})
            .map { $0.path }

        if stringsPaths.count > 0 {
            return [
                .buildCommand(
                    displayName: "Strings Parser",
                    executable: try context.tool(named: "StringsParserExecutable").path,
                    arguments: [ stringsPaths[0] ],
                    outputFiles: []
                )
            ]
        } else {
            return []
        }
    }

}
#endif
