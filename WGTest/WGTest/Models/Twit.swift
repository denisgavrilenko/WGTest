//
//  Twit.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Twit {
    let owner: String
    let twit: String
    
    init?(json: JSON) {
        owner = ""
        guard let twit = json["text"].string else {
            return nil
        }
        self.twit = twit
    }
}
