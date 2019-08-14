//
//  AppDelegate.swift
//  HeaderBiddingSample
//
//  Created by Yaroslav Skachkov on 8/14/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = BDMSdkConfiguration()
        configuration.testMode = true
        BDMSdk.shared().startSession(withSellerID: "5", configuration: configuration) {
            print("BidMachine SDK has initialized")
        }
        
        return true
    }


}

