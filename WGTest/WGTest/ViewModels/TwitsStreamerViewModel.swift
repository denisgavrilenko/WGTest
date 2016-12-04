//
//  TwitsStreamerViewModel.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import ReactiveSwift

class TwitsStreamerViewModel: TwitsStreamerViewModeling {
    
    public var twits: Property<[TwitViewModel]> { return Property(_twits) }
    public var errorMessage: Property<String?> { return Property(_errorMessage) }

    
    private let twitsStreamer: TwitsStreaming
    private let twitsMaxCount = 5
    private let _twits = MutableProperty<[TwitViewModel]>([])
    private let _errorMessage = MutableProperty<String?>(nil)
    
    init(twitsStreamer: TwitsStreaming) {
        self.twitsStreamer = twitsStreamer
    }
    
    func startStream() {
        twitsStreamer.startStream()
        .map { TwitViewModel(twit: $0) }
        .observe(on: UIScheduler())
        .on(value: { twit in
            self.appendNewTwit(twit: twit)
            },
            failed: { error in
                switch error {
                case .service(message: let message):
                    self._errorMessage.value = message
                }
                self.startStream()
        })
        .start()
    }
    
    func stopStream() {
        twitsStreamer.stopStream()
    }
    
    private func appendNewTwit(twit: TwitViewModel) {
        var twits = _twits.value
        twits.insert(twit, at: 0)
        _twits.value = Array(twits.prefix(twitsMaxCount))
    }
}
