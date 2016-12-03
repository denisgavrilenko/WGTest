//
//  TwitterStreamServiceTests.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import XCTest

import OAuthSwift

class TwitterStreamServiceTests: XCTestCase {
    
    let creds = OAuthSwiftCredential(consumerKey: "XnCOyemdiqdUdRABqf1S8lfTX", consumerSecret: "3uVW7wsPD2CTakRKU6a0kVtgzeug4h2WwuFyqWrqHFhYQBoBtk")
    var service: TwitterStreamService?
    
    override func setUp() {
        super.setUp()
        
        creds.oauthToken = "110512989-Cu2hWDBIVpZXlO5QKC2LMTxx22uFno1IG50VnS8X"
        creds.oauthTokenSecret = "V8WqoMDopeVnXbvrNqZtJzUMYg1oVWIqybe7HyEpWN4ya"
        service = TwitterStreamService(url: URL(string: "https://stream.twitter.com/1.1/statuses/filter.json?track=london")!, credentials: creds)
    }
    
    override func tearDown() {
        super.tearDown()
        
        service?.stopStream()
    }
    
    func testStartTwitterStream() {
        let asyncExpectation = expectation(description: "Stream")
        
        service!.startStream { (json, error) in
            XCTAssertNil(error);
            XCTAssertNotNil(json)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Something went wrong")
        }
    }
    
    func testStopTwitterStream() {
        
        let asyncExpectation = expectation(description: "Cancel Stream Response")
        
        service!.startStream { (json, error) in
//            XCTAssertNil(error);
//            XCTAssertNotNil(json)
//            asyncExpectation.fulfill()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { 
            self.service!.stopStream()
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Something went wrong")
        }
    }
    
}
