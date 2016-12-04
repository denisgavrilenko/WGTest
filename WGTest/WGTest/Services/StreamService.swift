//
//  StreamService.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/4/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol StreamService {
    
    func startStream(stream: ((JSON?, StreamServiceError?) -> ())?)
    
    func stopStream()
}
