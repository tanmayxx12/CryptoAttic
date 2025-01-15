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
    @Published var isLoading: Bool = false
    
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
        
        // updates the portfolio coins:
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates market data:
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink{ [weak self] returnedStats in
                guard let self = self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    // Function to reload data from the titleColumn:
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()

        HapticManager.notification(type: .success)
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    
    // Updates the marketData
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map{ coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100 // Say percentChange was 25% -> .25 -. 0.25(thats why we divide by 100)
                let previousValue = currentValue / (1 + percentChange)
                // If the current value is 110, then the logic works like this: 110 / (1 + 0.1) = 100
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
