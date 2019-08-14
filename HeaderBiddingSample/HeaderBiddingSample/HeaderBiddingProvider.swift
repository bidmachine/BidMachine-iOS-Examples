//
//  HeaderBiddingProvider.swift
//  HeaderBiddingSample
//
//  Created by Yaroslav Skachkov on 8/14/19.
//  Copyright © 2019 Appodeal. All rights reserved.
//

import Foundation
import BidMachine.HeaderBidding

final class HeaderBiddingProvider {
    
    static let shared: HeaderBiddingProvider = HeaderBiddingProvider()
    
    private var json: [[String: Any]] {
        return Bundle(for: HeaderBiddingProvider.self)
            .url(forResource: "HeaderBiddingFixture", withExtension: "json")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: []) } as! [[String: Any]]
    }
    
    func getConfigEntities(completion: @escaping ([BDMAdNetworkConfiguration]) -> Void) {
        let entities: [BDMAdNetworkConfiguration] = self.json
            .compactMap { $0.adConfig() }
        completion(entities)
    }
    
}

fileprivate extension Dictionary
where Key == String, Value == Any {
    func adConfig() -> BDMAdNetworkConfiguration? {
        return BDMAdNetworkConfiguration.build { builder in
            let _ = (self["network_class"] as? String)
                .flatMap { NSClassFromString($0) }
                .flatMap { $0 as? BDMNetwork.Type }
                .flatMap { builder.appendNetworkClass($0) }
            let _ = (self["network"] as? String)
                .flatMap(builder.appendName)
            let _ = builder.appendInitializationParams(self)
            (self["ad_units"] as? [[String: Any]])?
                .forEach { data in
                    let _ = builder.appendAdUnit(BDMAdUnitFormatFromString(data["format"] as? String),
                                                 data.filter { $0.key != "format" })
            }
        }
    }
}
