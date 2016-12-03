//
//  TwitsTableViewDataSource.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit

class TwitsTableViewDataSource: NSObject {
    fileprivate var items = [TwitViewModel]()
    fileprivate let identifier: String
    fileprivate let customization: (TwitTableViewCell, TwitViewModel) -> ()
    
    func update(twits: [TwitViewModel]) {
        items = twits
    }
    
    init(identifier: String, customization: @escaping (TwitTableViewCell, TwitViewModel) -> ()) {
        self.identifier = identifier
        self.customization = customization
    }
}

extension TwitsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TwitTableViewCell
        
        customization(cell, items[indexPath.row])
        return cell
    }
}
