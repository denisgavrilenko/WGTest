//
//  TwitterStreamService.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Foundation
import Alamofire
import OAuthSwift
import SwiftyJSON

class TwitterStreamService {
    private let url: URL
    private var streamRequest: Request?
    
    init(url: URL) {
        self.url = url
    }
    
    func startStream(withCredentials credentials: OAuthSwiftCredential, stream: ((JSON? ,Error? , String? ) -> ())? = nil) {
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            stream?(nil, nil, nil)
            return
        }
        
        var parameters = [String: String]()
        if let params = components.queryItems?.dictionary(transform: { [$0.name : $0.value!] }) {
            parameters = params
        }
        
        var componentsWithoutParams = components
        componentsWithoutParams.queryItems = nil
        
        guard let urlWithoutParams = componentsWithoutParams.url else {
            stream?(nil, nil, nil)
            return
        }
        
        let headers = credentials.makeHeaders(urlWithoutParams, method: .POST, parameters: parameters)
        
        streamRequest = Alamofire.request(url.absoluteString, method: .post, headers: headers)
            .stream { (data) in
                let json = JSON(data: data)
                print(json)
                stream?(json, nil, nil)
            }
            .responseJSON { (response) in
                print(response)
                switch response.result {
                case .failure(let error):
                    stream?(nil, error, response.result.description)
                default: break
                }
            }

    }
    
    func stopStream() {
        
    }
}

extension Collection {
    func dictionary<K, V>(transform:(_ element: Iterator.Element) -> [K : V]) -> [K : V] {
        var dictionary = [K : V]()
        self.forEach { element in
            for (key, value) in transform(element) {
                dictionary[key] = value
            }
        }
        return dictionary
    }
}
