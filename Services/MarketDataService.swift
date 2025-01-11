//
//  MarketDataService.swift
//  CryptoAttic
//
//  Created by Tanmay . on 01/12/24.
//

import Combine
import Foundation


class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self ] returnedGlobalData in
                guard let self = self else { return }
                self.marketData = returnedGlobalData.data
                self.marketDataSubscription?.cancel()
            })
    }
    
}
