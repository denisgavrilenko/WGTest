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

enum TwitsStreamError: Error {
    
}

struct TwitsStreamer {
    let streamService: TwitterStreamService
    
    func startStream() -> SignalProducer <Twit, TwitsStreamError> {
        return SignalProducer{ observer, disposable in
            self.streamService.startStream(stream: { (json, error, errorString) in
                guard let json = json else {
                    // error
                    return
                }
                if let text = json["text"].string {
                    observer.send(value: Twit(owner: "me", twit: text))
                }
            })
        }
    }
}
