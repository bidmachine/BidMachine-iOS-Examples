//
//  ViewController.swift
//  Interstitial
//
//  Created by Yaroslav Skachkov on 1/8/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

class InterstitialVC: UIViewController {

    @IBOutlet weak var presentButton: UIButton!
    
    @IBOutlet weak var interstitialTypeSegmentedControl: UISegmentedControl!
    
    private lazy var interstitial: BDMInterstitial = {
        return BDMInterstitial()
    }()
    
    private lazy var request: BDMInterstitialRequest = {
        return BDMInterstitialRequest()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentButton.isEnabled = false
        interstitial.delegate = self
    }

    @IBAction func loadNonVideoAd(_ sender: UIButton) {
        request.type = selectInterstitialType()
        request.perform(with: self)
    }
    
    @IBAction func presentInterstitial(_ sender: UIButton) {
        interstitial.present(fromRootViewController: self)
    }
    
    private func selectInterstitialType() -> BDMFullscreenAdType {
        var type: BDMFullscreenAdType
        switch interstitialTypeSegmentedControl.titleForSegment(at: interstitialTypeSegmentedControl.selectedSegmentIndex) {
        case "Video" : type = .fullscreenAdTypeVideo
        case "NonVideo" : type = .fullsreenAdTypeBanner
        default : type = .fullscreenAdTypeAll
        }
        return type
    }
}

extension InterstitialVC: BDMRequestDelegate {
    func request(_ request: BDMRequest, failedWithError error: Error) {
        print("Auctuion failed")
    }
    
    func request(_ request: BDMRequest, completeWith info: BDMAuctionInfo) {
        print("Auctuion complete")
        interstitial.populate(with: request as! BDMInterstitialRequest)
    }
    
    func requestDidExpire(_ request: BDMRequest) {
        print("Auction expired")
    }
}

extension InterstitialVC: BDMInterstitialDelegate {
    func interstitialReady(toPresent interstitial: BDMInterstitial) {
        print("Interstitial is ready to present ad")
        presentButton.isEnabled = true
    }
    
    func interstitialWillPresent(_ interstitial: BDMInterstitial) {
        print("Interstitial will present ad")
    }
    
    func interstitialDidDismiss(_ interstitial: BDMInterstitial) {
        print("Interstitial dismissed")
        presentButton.isEnabled = false
    }
    
    func interstitialRecieveUserInteraction(_ interstitial: BDMInterstitial) {
        print("Interstitial received user interaction")
    }
    
    func interstitial(_ interstitial: BDMInterstitial, failedWithError error: Error) {
        print("Interstitial failed on loading with error: \(error)")
        presentButton.isEnabled = false
    }
    
    func interstitial(_ interstitial: BDMInterstitial, failedToPresentWithError error: Error) {
        print("Interstitial failed to present ad with error: \(error)")
        presentButton.isEnabled = false
    }
}

