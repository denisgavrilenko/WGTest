//
//  TwitTableViewCell.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/2/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit

class TwitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var twitMessageLabel: UILabel!
    
    func setText(text: String) {
        twitMessageLabel.text = text
    }
}
