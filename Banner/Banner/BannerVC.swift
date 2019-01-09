//
//  ViewController.swift
//  Banner
//
//  Created by Yaroslav Skachkov on 1/8/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

class BannerVC: UIViewController {
    
    @IBOutlet weak var removeBannerButton: UIButton!
    
    private lazy var bannerView: BDMBannerView = {
        let bannerView = BDMBannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }()
    
    private lazy var request: BDMRequest = {
        return BDMRequest()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBannerButton.isEnabled = false
        bannerView.delegate = self
        bannerView.rootViewController = self
    }

    @IBAction func loadBanner(_ sender: UIButton) {
        bannerView.adSize = .size320x50
        bannerView.make(request)
    }
    
    @IBAction func removeBanner(_ sender: UIButton) {
        bannerView.removeFromSuperview()
        removeBannerButton.isEnabled = false
    }
    
    private func configureBannerView() {
        let bannerViewWidthConstraint = bannerView.widthAnchor.constraint(equalToConstant: CGSizeFromBDMSize(bannerView.adSize).width)
        let bannerViewHeightConstraint = bannerView.heightAnchor.constraint(equalToConstant: CGSizeFromBDMSize(bannerView.adSize).height)
        let bannerViewHorizontalCenter = bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let bannerViewVerticalCenter = bannerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120)
        NSLayoutConstraint.activate([bannerViewWidthConstraint, bannerViewHeightConstraint, bannerViewVerticalCenter, bannerViewHorizontalCenter])
    }
}

extension BannerVC: BDMBannerDelegate {
    func bannerViewDidExpire(_ bannerView: BDMBannerView) {
        print("Banner view expired")
    }
    
    func bannerViewRecieveUserInteraction(_ bannerView: BDMBannerView) {
        print("Banner view received user interaction")
    }
    
    func bannerView(_ bannerView: BDMBannerView, readyToPresentAd auctionInfo: BDMAuctionInfo) {
        print("Banner view is ready to present ad")
        removeBannerButton.isEnabled = true
        self.view.addSubview(self.bannerView)
        configureBannerView()
    }
    
    func bannerView(_ bannerView: BDMBannerView, failedWithError error: Error) {
        print("Banner view failed on loading with error: \(error)")
    }
}
