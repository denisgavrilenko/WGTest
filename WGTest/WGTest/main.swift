//
//  main.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/3/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass? = NSClassFromString("WGTestTests.TestingAppDelegate") ?? AppDelegate.self
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))
