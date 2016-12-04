//
//  TwitsStreamerViewModelSpec.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/5/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Quick
import Nimble
import ReactiveSwift
import ReactiveCocoa

class TwitsStreamerViewModelSpec: QuickSpec {
    // MARK: Stub
    class StubTwitsStreamer: TwitsStreaming {
        func startStream() -> SignalProducer<Twit, TwitsStreamError> {
            return SignalProducer { observer, disposable in
                observer.send(value: Twit(owner: "", twit: "Test twit"))
            }
            .observe(on: QueueScheduler())
        }
        
        func stopStream() {
            
        }
    }
    
    class ErrorStubTwitsStreamer: TwitsStreaming {
        func startStream() -> SignalProducer<Twit, TwitsStreamError> {
            return SignalProducer { observer, disposable in
                observer.send(error: .service(message: "Common Error"))
                }
                .observe(on: QueueScheduler())
        }
        
        func stopStream() {
            
        }
    }
    
    override func spec() {
        var viewModel: TwitsStreamerViewModel!
        beforeEach {
            viewModel = TwitsStreamerViewModel(twitsStreamer: StubTwitsStreamer())
        }
        describe("Start Stream") { 
            it("receives latest twit.") {
                var twits: [TwitViewModel]? = nil
                viewModel.twits.producer
                .on(value: { (latestTwits) in
                    twits = latestTwits
                })
                .start()
                
                viewModel.startStream()

                expect(twits).toEventuallyNot(beNil())
                expect(twits?.count).toEventually(equal(1))
            }
            it("sets viewModels property on the main thread.") {
                var onMainThread = false
                viewModel.twits.producer
                    .on(value: { _ in onMainThread = Thread.isMainThread })
                    .start()
                viewModel.startStream()
                
                expect(onMainThread).toEventually(beTrue())
            }
            context("on error") {
                it("sets errorMessage property.") {
                    let viewModel = TwitsStreamerViewModel(twitsStreamer: ErrorStubTwitsStreamer())
                    viewModel.startStream()
                    expect(viewModel.errorMessage.value).toEventuallyNot(beNil())
                }
            }
        }
    }
}
