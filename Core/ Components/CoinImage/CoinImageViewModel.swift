//
//  CoinImageViewModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 22/11/24.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.isLoading = false
            } receiveValue: {[weak self] returnedImage in
                guard let self = self else { return }
                self.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
