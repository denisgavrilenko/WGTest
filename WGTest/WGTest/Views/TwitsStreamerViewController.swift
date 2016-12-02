//
//  ViewController.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/1/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit

class TwitsStreamerViewController: UIViewController {
    
    public var viewModel: TwitsStreamerViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.twits.producer
                .on(value: { twit in
                    print(twit)
                })
                .start()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.startStream()
    }
    
}

