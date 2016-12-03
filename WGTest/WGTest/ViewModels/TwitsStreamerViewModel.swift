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
    
    public var twits: Property<TwitViewModel?> { return Property(_twits) }
    public var errorMessage: Property<String?> { return Property(_errorMessage) }

    
    private let twitsStreamer: TwitsStreamer
    private let _twits = MutableProperty<TwitViewModel?>(nil)
    private let _errorMessage = MutableProperty<String?>(nil)
    
    init(twitsStreamer: TwitsStreamer) {
        self.twitsStreamer = twitsStreamer
    }
    
    func startStream() {
        twitsStreamer.startStream()
        .map { TwitViewModel(twit: $0) }
        .on(value: { twit in
            self._twits.value = twit
            },
            failed: { error in
                switch error {
                case .service(message: let message):
                    self._errorMessage.value = message
                }
        })
        .start()
    }
}
