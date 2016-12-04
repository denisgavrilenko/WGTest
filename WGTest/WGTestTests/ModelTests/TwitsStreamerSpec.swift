//
//  TwitsStreamerSpec.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import ReactiveSwift

class TwitsStreamerSpec: QuickSpec {
    // MARK: Stub
    class GoodStubStreamService: StreamService {
        func startStream(stream: ((JSON?, StreamServiceError?) -> ())?) {
            let json = JSON(dictionaryLiteral: ("text", "Test twit message"))
            
            stream?(json, nil)
        }
        
        func stopStream() {
            
        }
    }
    
    class BadStubStreamService: StreamService {
        func startStream(stream: ((JSON?, StreamServiceError?) -> ())?) {
            stream?(nil, .streamResponse(description: "Stream common error"))
        }
        
        func stopStream() {
            
        }
    }
    
    class ErrorURLStubStreamService: StreamService {
        func startStream(stream: ((JSON?, StreamServiceError?) -> ())?) {
            stream?(nil, .wrongURL)
        }
        
        func stopStream() {
            
        }
    }
    
    override func spec() {
        describe("Stream") { 
            it("returns latest twit if stream service works correctly.") {
                var response: Twit? = nil
                let streamer = TwitsStreamer(streamService: GoodStubStreamService())
                streamer.startStream()
                .on(value: { response = $0 })
                .start()
                
                expect(response).toEventuallyNot(beNil())
                expect(response?.twit).toEventually(equal("Test twit message"))
            }
            it("sends an error if the stream returns incorrect data.") {
                var error: TwitsStreamError? = nil
                let streamer = TwitsStreamer(streamService: BadStubStreamService())
                streamer.startStream()
                .on(failed: { error = $0 })
                .start()
                
                expect(error).to(matchError(TwitsStreamError.service(message: "")))
            }
            it("sends an error if wrong URL.") {
                var error: TwitsStreamError? = nil
                let streamer = TwitsStreamer(streamService: BadStubStreamService())
                streamer.startStream()
                    .on(failed: { error = $0 })
                    .start()
                
                expect(error).to(matchError(TwitsStreamError.service(message: "")))
            }
        }
    }
}

