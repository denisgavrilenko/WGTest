//
//  SwinjectStoryboard+Setup.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import OAuthSwift

extension SwinjectStoryboard {
    class func setup() {
        let url = URL(string: "https://stream.twitter.com/1.1/statuses/filter.json?track=london")!
        let credentials = OAuthSwiftCredential(consumerKey: "XnCOyemdiqdUdRABqf1S8lfTX", consumerSecret: "3uVW7wsPD2CTakRKU6a0kVtgzeug4h2WwuFyqWrqHFhYQBoBtk")
        credentials.oauthToken = "110512989-Cu2hWDBIVpZXlO5QKC2LMTxx22uFno1IG50VnS8X"
        credentials.oauthTokenSecret = "V8WqoMDopeVnXbvrNqZtJzUMYg1oVWIqybe7HyEpWN4ya"
        
        defaultContainer.register(StreamService.self) { _ in TwitterStreamService(url: url, credentials: credentials) }
        defaultContainer.register(TwitsStreaming.self) { r -> TwitsStreaming in TwitsStreamer(streamService: r.resolve(StreamService.self)!) }
        defaultContainer.register(TwitsStreamerViewModeling.self) { r -> TwitsStreamerViewModeling in TwitsStreamerViewModel(twitsStreamer: r.resolve(TwitsStreaming.self)!) }
        defaultContainer.registerForStoryboard(TwitsStreamerViewController.self) { (r, c) in
            c.viewModel = r.resolve(TwitsStreamerViewModeling.self)
        }
    }
}
