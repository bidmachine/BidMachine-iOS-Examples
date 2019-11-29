//
//  TableViewController.swift
//  NativeAd
//
//  Created by Ilia Lozhkin on 11/26/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import UIKit
import BidMachine

class TableViewController: UITableViewController {
    
    struct TableViewContentEntity {
        var image: UIImage
        var title: String
        var description: String
    }
    
    private struct Constants {
        static let contentTitle = "Lorem ipsum"
        static let contentDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    private let native = BDMNativeAd()
    private var cellsCount = 0
    
    private var fakeEntityArray: [TableViewContentEntity] = [
        TableViewContentEntity(image: UIImage(named: "ManPic")!, title: Constants.contentTitle, description: Constants.contentDescription),
        TableViewContentEntity(image: UIImage(named: "KittyPic")!, title: Constants.contentTitle, description: Constants.contentDescription),
        TableViewContentEntity(image: UIImage(named: "ManPic")!, title: Constants.contentTitle, description: Constants.contentDescription)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContentTableViewCell.nib, forCellReuseIdentifier: ContentTableViewCell.reuseIdentifier)
        self.tableView.register(NativeAdViewCell.nib, forCellReuseIdentifier: NativeAdViewCell.reuseIdentifier)
        native.delegate = self
        native.producerDelegate = self
        
        native.make(BDMNativeAdRequest())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row.quotientAndRemainder(dividingBy: 20).remainder == 0 {
            let nativeAdViewCell = tableView.dequeueReusableCell(withIdentifier: NativeAdViewCell.reuseIdentifier, for: indexPath) as! NativeAdViewCell
            native.unregisterViews()
            native.present(on: nativeAdViewCell,
                           clickableViews: [],
                           adRendering: nativeAdViewCell,
                           controller: self,
                           error: nil)
            return nativeAdViewCell
        }
        
        let fakeCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.reuseIdentifier, for: indexPath) as! ContentTableViewCell
        
        let entity = fakeEntityArray[Int.random(in: 0...2)]
        
        fakeCell.fakeIcon.image = entity.image
        fakeCell.fakeTitle.text = entity.title
        fakeCell.fakeDescription.text = entity.description
        
        return fakeCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row.quotientAndRemainder(dividingBy: 20).remainder == 0 {
            return 375
        }
        return 86
    }
}

extension TableViewController: BDMNativeAdDelegate {
    func nativeAd(_ nativeAd: BDMNativeAd, readyToPresentAd auctionInfo: BDMAuctionInfo) {
        cellsCount = 100
        tableView.reloadData()
        print("Native ad did load")
    }

    func nativeAd(_ nativeAd: BDMNativeAd, failedWithError error: Error) {
        print("Native ad failed")
    }
}

extension TableViewController: BDMAdEventProducerDelegate {

    func didProduceImpression(_ producer: BDMAdEventProducer) {
        print("Native ad received impression")
    }
    
    func didProduceUserAction(_ producer: BDMAdEventProducer) {
        print("Native ad received user interaction")
    }
}

