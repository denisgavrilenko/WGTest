//
//  ViewController.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/1/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit
import ReactiveSwift

class TwitsStreamerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private static let identifier = "CommonCell"
    
    public var viewModel: TwitsStreamerViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.twits.producer
                .observe(on: UIScheduler())
                .on(value: { twit in
                    if let twit = twit {
                        print(twit)
                        self.dataSource.add(twit: twit)
                        self.tableView.reloadData()
                    }
                })
                .start()
            }
        }
    }
    
    private let dataSource = TwitsTableViewDataSource(identifier: identifier) { (cell, item) in
        print(item)
        cell.setText(text: item.twitMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.startStream()
    }
    

    func customizeTableView() {
        tableView.register(UINib(nibName: "TwitTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: TwitsStreamerViewController.identifier)
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

}

