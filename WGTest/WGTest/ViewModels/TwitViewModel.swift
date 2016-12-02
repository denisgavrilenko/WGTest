//
//  TwitViewModel.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation

struct TwitViewModel {
    let twitMessage: String
    
    init(twit: Twit) {
        twitMessage = twit.twit
    }
}
