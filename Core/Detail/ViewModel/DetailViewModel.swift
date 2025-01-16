//
//  DetailViewModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 16/01/25.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    // Adding Functions:
    
    // Function to add subscribers:
    func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received coin detail data.")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
        
        
    }
    
    
}
