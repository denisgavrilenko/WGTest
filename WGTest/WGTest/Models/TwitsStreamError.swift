//
//  TwitsStreamError.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation

enum TwitsStreamError: Error {
    case service(message: String)
    
    static func from(serviceError: StreamServiceError) -> TwitsStreamError {
        switch serviceError {
        case .wrongURL:
            return .service(message: NSLocalizedString("Wrong URL", comment: "Can't connect to URL"))
        case .streamResponse(description: let desc):
            return .service(message: desc)
        }
    }
}
