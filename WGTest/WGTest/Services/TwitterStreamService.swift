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

enum StreamServiceError {
    case wrongURL
    case streamResponse(description: String)
}

class TwitterStreamService {
    private let url: URL
    private let credentials: OAuthSwiftCredential
    private var streamRequest: Request?
    
    init(url: URL, credentials: OAuthSwiftCredential) {
        self.url = url
        self.credentials = credentials
    }
    
    func startStream(stream: ((JSON?, StreamServiceError?) -> ())? = nil) {
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            stream?(nil, .wrongURL)
            return
        }
        
        guard let urlWithoutParams = components.urlWithoutParameters() else {
            stream?(nil, .wrongURL)
            return
        }
        
        let parameters = components.queryItems?.dictionary(transform: { [$0.name : $0.value!] })

        let headers = credentials.makeHeaders(urlWithoutParams, method: .POST, parameters: parameters.maybe(other: [String: String]()))
        
        streamRequest = Alamofire.request(url.absoluteString, method: .post, headers: headers)
            .stream { (data) in
                let json = JSON(data: data)
                guard json.null == nil else { return }
                
                print(json)

                stream?(json, nil)
            }
            .responseJSON { (response) in
                print(response)
                if response.response?.statusCode != 200 {
                    switch response.result {
                    case .failure(let error):
                        stream?(nil, .streamResponse(description: error.localizedDescription))
                    default: break
                    }
                }
                else {
                    // send finished
                    stream?(nil, nil)
                }
            }

    }
    
    func stopStream() {
        streamRequest?.cancel()
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

extension URLComponents {
    public func urlWithoutParameters() -> URL? {
        var componentsWithoutParams = self
        componentsWithoutParams.queryItems = nil
        return componentsWithoutParams.url
    }
}
