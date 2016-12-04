//
//  TwitsStreamerViewModeling.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol TwitsStreamerViewModeling {
    
    var twits: Property<[TwitViewModel]> { get }
    var errorMessage: Property<String?> { get }
    
    func startStream()
    func stopStream()
}
