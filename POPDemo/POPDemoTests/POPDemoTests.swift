//
//  POPDemoTests.swift
//  POPDemoTests
//
//  Created by Zheng Kanyan on 2021/3/10.
//

import XCTest
@testable import POPDemo

class POPDemoTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let client = LocalFileClient()
        client.send(UserURLRequest()) { users in
            XCTAssert(users != nil)
        }
    }
    
    func testRandom() throws {
        let x = 10.arc4random()
        XCTAssert(x > 0)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
