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
    fileprivate struct Keys  {
        static let networkClass = "network_class"
        static let networkName = "network"
        static let adUnits = "ad_units"
        static let format = "format"
    }
    
    static let shared: HeaderBiddingProvider = HeaderBiddingProvider()
    
    private var json: [[String: Any]] {
        return Bundle(for: HeaderBiddingProvider.self)
            .url(forResource: "HeaderBiddingFixture", withExtension: "json")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: []) } as! [[String: Any]]
    }
    
    func getConfigEntities(completion: @escaping ([BDMAdNetworkConfiguration]) -> Void) {
        let entities: [BDMAdNetworkConfiguration] = json.compactMap { $0.adConfig() }
        completion(entities)
    }
}

fileprivate extension Dictionary
where Key == String, Value == Any {
    func adConfig() -> BDMAdNetworkConfiguration? {
        return BDMAdNetworkConfiguration.build { builder in
            // Append initialisation paramters
            let _ = builder.appendInitializationParams(self)
            // Append ad network class
            let _ = (self[HeaderBiddingProvider.Keys.networkClass] as? String)
                .flatMap { NSClassFromString($0) }
                .flatMap { $0 as? BDMNetwork.Type }
                .flatMap { builder.appendNetworkClass($0) }
            // Append ad networn name
            let _ = (self[HeaderBiddingProvider.Keys.networkName] as? String)
                .flatMap(builder.appendName)
            // Append ad units
            let _ = (self[HeaderBiddingProvider.Keys.adUnits] as? [[String: Any]])?
                .map { data in
                    builder.appendAdUnit(BDMAdUnitFormatFromString(data[HeaderBiddingProvider.Keys.format] as? String),
                                         data.filter { $0.key != HeaderBiddingProvider.Keys.format })
            }
        }
    }
}
