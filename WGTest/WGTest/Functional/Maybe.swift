//
//  Maybe.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/3/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation

extension Optional {
    func maybe(other: @autoclosure () -> Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return other()
        }
    }
}
