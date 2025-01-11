//
//  HomeViewModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 22/11/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
//        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
//        StatisticModel(title: "Title", value: "Value"),
//        StatisticModel(title: "Title", value: "Value"),
//        StatisticModel(title: "Title", value: "Value", percentageChange: -7)
    ]
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Updates allCoins:
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for:  .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
                        .sink { [weak self] returnedCoins in
                guard let self  = self else { return }
                self.allCoins = returnedCoins 
            }
            .store(in: &cancellables)
        
        // updates market data:
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink{ [weak self] returnedStats in
                guard let self = self else { return }
                self.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // updates the portfolio coins:
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{ (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels.compactMap { coin -> CoinModel? in
                    guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    // Function to filter coins (to be used inside map)
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    // Updates the marketData
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
