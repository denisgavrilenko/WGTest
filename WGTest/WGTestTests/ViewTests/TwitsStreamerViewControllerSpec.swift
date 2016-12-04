//
//  TwitsStreamerViewControllerSpec.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/5/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import Quick
import Nimble
import ReactiveCocoa
import ReactiveSwift

class TwitsStreamerViewControllerSpec: QuickSpec {
    
    class MockTwitsStreamerViewModel: TwitsStreamerViewModeling {
        let twits = Property(MutableProperty<[TwitViewModel]>([]))
        let errorMessage = Property(MutableProperty<String?>(nil))
        
        var startStreamCount = 0
        
        func startStream() {
            startStreamCount += 1
        }
        
        func stopStream() {
            
        }
    }
    
    override func spec() {
        it("starts searching images when the view is about to appear.") {
            let viewModel = MockTwitsStreamerViewModel()
            let viewController = TwitsStreamerViewController()
            viewController.viewModel = viewModel
            
            expect(viewModel.startStreamCount) == 0
            viewController.viewWillAppear(true)
            expect(viewModel.startStreamCount) == 1
        }
    }
    
}
