//
//  TwitsStreamer.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON

struct TwitsStreamer: TwitsStreaming {
    let streamService: StreamService
    
    func startStream() -> SignalProducer <Twit, TwitsStreamError> {
        return SignalProducer{ observer, disposable in
            self.streamService.startStream(stream: { (json, error) in
                if let error = error {
                    observer.send(error: TwitsStreamError.from(serviceError: error))
                    observer.sendCompleted()
                    return
                }
                guard let json = json else { return }
                
                if let twit = Twit(json: json) {
                    observer.send(value: twit)
                }
            })
        }
    }
    
    func stopStream() {
        streamService.stopStream()
    }
}
