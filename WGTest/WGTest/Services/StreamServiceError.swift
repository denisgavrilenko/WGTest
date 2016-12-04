//
//  StreamServiceError.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation

enum StreamServiceError {
    case wrongURL
    case streamResponse(description: String)
}
