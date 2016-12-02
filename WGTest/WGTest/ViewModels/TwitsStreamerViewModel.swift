//
//  TwitsStreamerViewModel.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import ReactiveSwift

class TwitsStreamerViewModel {
    
    public var twits: Property<TwitViewModel?> {
        return Property(_twits)
    }
    
    private let twitsStreamer: TwitsStreamer
    private let _twits = MutableProperty<TwitViewModel?>(nil)
    
    init(twitsStreamer: TwitsStreamer) {
        self.twitsStreamer = twitsStreamer
    }
    
    func startStream() {
        twitsStreamer.startStream()
        .map { TwitViewModel(twit: $0) }
        .on(value: { twit in
            self._twits.value = twit
        })
        .start()
    }
}
