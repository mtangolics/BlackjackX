//
//  AppDelegate.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 11/30/15.
//  Copyright (c) 2015 Mike Tangolics. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var masterViewController: MasterViewController!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        
        window.contentView!.addSubview(masterViewController.view)
        masterViewController.view.frame = window.contentView!.bounds
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

