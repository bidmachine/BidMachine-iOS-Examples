//
//  ViewController.swift
//  Rewarded
//
//  Created by Yaroslav Skachkov on 1/8/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

class RewardedVC: UIViewController {
    private lazy var rewarded: BDMRewarded = {
        return BDMRewarded()
    }()
    
    private lazy var request: BDMRequest = {
        return BDMRequest()
    }()
    
    @IBOutlet weak var presentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentButton.isEnabled = false
        rewarded.delegate = self
    }

    @IBAction func loadRewardedVideo(_ sender: UIButton) {
        rewarded.make(request)
    }
    
    @IBAction func presentRewardedVideo(_ sender: UIButton) {
        rewarded.present(fromRootViewController: self)
    }
}

extension RewardedVC: BDMRewardedDelegate {
    func rewarded(_ rewarded: BDMRewarded, readyToPresentAd auctionInfo: BDMAuctionInfo) {
        print("Rewarded is ready to present ad")
        presentButton.isEnabled = true
    }
    
    func rewarded(_ rewarded: BDMRewarded, failedWithError error: Error) {
        print("Rewarded failed on loading with error: \(error)")
        presentButton.isEnabled = false
    }
    
    func rewarded(_ rewarded: BDMRewarded, failedToPresentWithError error: Error) {
        print("Rewarded failed to present with error with error: \(error)")
        presentButton.isEnabled = false
    }
    
    func rewardedWillPresent(_ rewarded: BDMRewarded) {
        print("Rewarded will present ad")
    }
    
    func rewardedDidExpire(_ rewarded: BDMRewarded) {
        print("Rewarded expired")
        presentButton.isEnabled = false
    }
    
    func rewardedDidDismiss(_ rewarded: BDMRewarded) {
        print("Rewarded dismissed")
        presentButton.isEnabled = false
    }
    
    func rewardedRecieveUserInteraction(_ rewarded: BDMRewarded) {
        print("Rewarded received user interaction")
    }
    
    func rewardedFinishRewardAction(_ rewarded: BDMRewarded) {
        print("Rewarded video has finished")
    }
}

