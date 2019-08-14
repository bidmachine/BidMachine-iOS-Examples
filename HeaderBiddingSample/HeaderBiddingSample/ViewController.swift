//
//  ViewController.swift
//  HeaderBiddingSample
//
//  Created by Yaroslav Skachkov on 8/14/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

final class ViewController: UIViewController {
    
    
    //MARK: - Outlets -
    
    @IBOutlet weak var showBannerButton: UIButton!
    @IBOutlet weak var removeBannerButton: UIButton!
    @IBOutlet weak var showInterstitialButton: UIButton!
    @IBOutlet weak var interstitialTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var presentRewardedButton: UIButton!
    
    private lazy var bannerView: BDMBannerView = {
        let bannerView = BDMBannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    private lazy var bannerRequest: BDMBannerRequest = {
        return BDMBannerRequest()
    }()
    
    private lazy var interstitial: BDMInterstitial = {
        return BDMInterstitial()
    }()
    
    private lazy var interstitialRequest: BDMInterstitialRequest = {
        return BDMInterstitialRequest()
    }()
    
    private lazy var rewarded: BDMRewarded = {
        return BDMRewarded()
    }()
    
    private lazy var rewardedRequest: BDMRewardedRequest = {
        return BDMRewardedRequest()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        var configEntities: [BDMAdNetworkConfiguration] = []
        HeaderBiddingProvider.shared.getConfigEntities { entities in
            entities.forEach { configEntity in
                configEntities.append(configEntity)
            }
        }
        let configuration: BDMSdkConfiguration = BDMSdkConfiguration()
        configuration.networkConfigurations = configEntities
        BDMSdk.shared().startSession(withSellerID: "5", configuration: configuration) {
            print("BidMachine SDK was successfully initialized!")
        }
        
        bannerView.delegate = self
        bannerView.rootViewController = self
        showBannerButton.isEnabled = false
        removeBannerButton.isEnabled = false
        
        interstitial.delegate = self
        showInterstitialButton.isEnabled = false
        
        rewarded.delegate = self
        presentRewardedButton.isEnabled = false
    }
}

// MARK: - Banner -

extension ViewController {
    
    @IBAction func loadBanner(_ sender: UIButton) {
        bannerRequest.adSize = .size320x50
        bannerView.populate(with: bannerRequest)
    }
    
    @IBAction func showBanner(_ sender: UIButton) {
        self.view.addSubview(self.bannerView)
        configureBannerView()
        removeBannerButton.isEnabled = true
    }
    
    @IBAction func removeBanner(_ sender: UIButton) {
        bannerView.removeFromSuperview()
        removeBannerButton.isEnabled = false
    }
    
    
    private func configureBannerView() {
        let bannerViewWidthConstraint = bannerView.widthAnchor.constraint(equalToConstant: CGSizeFromBDMSize(bannerRequest.adSize).width)
        let bannerViewHeightConstraint = bannerView.heightAnchor.constraint(equalToConstant: CGSizeFromBDMSize(bannerRequest.adSize).height)
        let bannerViewHorizontalCenter = bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let bannerViewVerticalCenter = bannerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120)
        NSLayoutConstraint.activate([bannerViewWidthConstraint,
                                     bannerViewHeightConstraint,
                                     bannerViewVerticalCenter,
                                     bannerViewHorizontalCenter])
    }
    
}

extension ViewController: BDMBannerDelegate {
    func bannerViewReady(toPresent bannerView: BDMBannerView) {
        showBannerButton.isEnabled = true
    }
    
    func bannerView(_ bannerView: BDMBannerView, failedWithError error: Error) {
        showBannerButton.isEnabled = false
    }
    
    // No-op
    func bannerViewRecieveUserInteraction(_ bannerView: BDMBannerView) {}
}

// MARK: - Interstitial -

extension ViewController {
    
    @IBAction func loadAd(_ sender: UIButton) {
        interstitialRequest.type = selectInterstitialType()
        interstitial.populate(with: interstitialRequest)
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

extension ViewController: BDMInterstitialDelegate {
    func interstitialReady(toPresent interstitial: BDMInterstitial) {
        showInterstitialButton.isEnabled = true
    }
    
    func interstitialDidDismiss(_ interstitial: BDMInterstitial) {
        showInterstitialButton.isEnabled = false
    }
    
    func interstitial(_ interstitial: BDMInterstitial, failedWithError error: Error) {
        showInterstitialButton.isEnabled = false
    }
    
    func interstitial(_ interstitial: BDMInterstitial, failedToPresentWithError error: Error) {
        showInterstitialButton.isEnabled = false
    }
    
    // No-op
    func interstitialWillPresent(_ interstitial: BDMInterstitial) {}
    func interstitialRecieveUserInteraction(_ interstitial: BDMInterstitial) {}
}

// MARK: - Rewarded Video -

extension ViewController {
    
    @IBAction func loadRewardedVideo(_ sender: UIButton) {
        rewarded.populate(with: rewardedRequest)
    }
    
    @IBAction func presentRewardedVideo(_ sender: UIButton) {
        rewarded.present(fromRootViewController: self)
    }
    
}

extension ViewController: BDMRewardedDelegate {
    func rewardedReady(toPresent rewarded: BDMRewarded) {
        presentRewardedButton.isEnabled = true
    }
    
    func rewardedDidDismiss(_ rewarded: BDMRewarded) {
        presentRewardedButton.isEnabled = false
    }
    
    func rewarded(_ rewarded: BDMRewarded, failedWithError error: Error) {
        presentRewardedButton.isEnabled = false
    }
    
    func rewarded(_ rewarded: BDMRewarded, failedToPresentWithError error: Error) {
        presentRewardedButton.isEnabled = false
    }
    
    // No-op
    func rewardedRecieveUserInteraction(_ rewarded: BDMRewarded) {}
    func rewardedFinishRewardAction(_ rewarded: BDMRewarded) {}
    func rewardedWillPresent(_ rewarded: BDMRewarded) {}
}
