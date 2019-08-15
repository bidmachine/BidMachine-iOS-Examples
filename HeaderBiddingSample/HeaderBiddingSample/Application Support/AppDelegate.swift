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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HeaderBiddingProvider.shared.getConfigEntities(completion: startBidMachine)
        return true
    }
    
    private func startBidMachine(with networksConfigurations:[BDMAdNetworkConfiguration]) {
        let configuration: BDMSdkConfiguration = BDMSdkConfiguration()
        configuration.networkConfigurations = networksConfigurations
        BDMSdk.shared().enableLogging = true
        BDMSdk.shared().startSession(withSellerID: "5",
                                     configuration: configuration) {
            print("BidMachine SDK was successfully initialized!")
        }
    }
}

