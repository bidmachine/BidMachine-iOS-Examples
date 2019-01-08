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
        print("Rewarded failed with error")
        presentButton.isEnabled = false
    }
    
    func rewarded(_ rewarded: BDMRewarded, failedToPresentWithError error: Error) {
        print("Rewarded failed to present with error")
        presentButton.isEnabled = false
    }
    
    func rewardedWillPresent(_ rewarded: BDMRewarded) {
        print("Rewarded will present ad")
    }
    
    func rewardedDidExpire(_ rewarded: BDMRewarded) {
        print("Rewarded did expire")
        presentButton.isEnabled = false
    }
    
    func rewardedDidDismiss(_ rewarded: BDMRewarded) {
        print("Rewarded did dismiss")
        presentButton.isEnabled = false
    }
    
    func rewardedRecieveUserInteraction(_ rewarded: BDMRewarded) {
        print("Rewarded did receive user interaction")
    }
    
    func rewardedFinishRewardAction(_ rewarded: BDMRewarded) {
        print("Rewarded video has been finished")
    }
}

