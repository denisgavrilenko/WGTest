//
//  TwitsStreaming.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol TwitsStreaming {
    func startStream() -> SignalProducer <Twit, TwitsStreamError>
    func stopStream()
}
