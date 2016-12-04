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
    
    @IBOutlet weak var tableView: UITableView?
    private static let identifier = "CommonCell"
    
    public var viewModel: TwitsStreamerViewModel? {
        didSet {
            if let viewModel = viewModel {
                viewModel.twits.producer
                .observe(on: UIScheduler())
                .on(value: { twits in
                    print(twits)
                    self.dataSource.update(twits: twits)
                    if let tableView = self.tableView {
                        tableView.reloadData()
                    }
                })
                .start()
                
                viewModel.errorMessage.producer
                .observe(on: UIScheduler())
                .on(value: { message in
                    if let message = message {
                        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .`default`))
                        self.present(alert, animated: true)
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
        
        viewModel?.startStream()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel?.stopStream()
    }
    

    func customizeTableView() {
        tableView?.register(UINib(nibName: "TwitTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: TwitsStreamerViewController.identifier)
        tableView?.dataSource = dataSource
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 100
    }

}

