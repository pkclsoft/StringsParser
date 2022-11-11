import XCTest
@testable import StringsParser

final class StringsParserTests: XCTestCase {
    
    func testfile(withName: String) -> String {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourcesDirectory = thisDirectory.deletingLastPathComponent().appendingPathComponent("Resources")
        
        let resourceURL = resourcesDirectory.appendingPathComponent("Localizable \(withName).strings")
        let path: String
        
        if #available(macOS 13.0, *) {
            path = resourceURL.path()
        } else {
            // Fallback on earlier versions
            path = resourceURL.path
        }

        return path
    }
    
    func testValidSyntax() throws {
        let path = testfile(withName: "Good")
        
        if FileManager.default.fileExists(atPath: path) {
            let parser = StringsParser(fileName: path)
            
            XCTAssert(!parser.parse(), "File failed to parse.")
        } else {
            XCTAssert(false, "unable to find test file: \(path)")
        }
    }
    
    func testInvalidSyntax() throws {
        for testNumber in 1 ... 12 {
            let path = testfile(withName: "Bad\(testNumber)")
            
            if FileManager.default.fileExists(atPath: path) {
                let parser = StringsParser(fileName: path)
                
                XCTAssert(parser.parse(), "File failed to parse.")
            } else {
                XCTAssert(false, "unable to find test file: \(path)")
            }
        }
    }
}
