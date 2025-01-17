//
//  DetailViewModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 16/01/25.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    // Adding Functions:
    
    // Function to add subscribers:
    func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
        // Using .map to convert the data to statistcis without using a function:
        /*
         .map({ (coinDetailModel, coinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) in
             
             // Logic for the overviewArray to be used in the DetailView:
             let price = coinModel.currentPrice.asCurrencyWith6Decimals()
             let pricePercentChange = coinModel.priceChangePercentage24H
             let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
             
             let marketCap = "$\(coinModel.marketCap?.formattedWithAbbreviations() ?? "")"
             let marketCapPercentChange = coinModel.marketCapChangePercentage24H
             let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
             
             let rank = "\(coinModel.rank)"
             let rankStat = StatisticModel(title: "Rank", value: rank)
             
             let volume = "$\(coinModel.totalVolume?.formattedWithAbbreviations() ?? "")"
             let volumeStat = StatisticModel(title: "Volume", value: volume)
             
             let overviewArray: [StatisticModel] = [
                 priceStat, marketCapStat, rankStat, volumeStat
             ]
             
             // Logic for the additionalArray to be used in the DetailView:
             let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
             let highStat = StatisticModel(title: "24H High", value: high)
             
             let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
             let lowStat = StatisticModel(title: "24H Low", value: low)
             
             let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
             let pricePercentChange2 = coinModel.priceChangePercentage24H
             let priceChangeStat = StatisticModel(title: "24H Price Chnage", value: priceChange, percentageChange: pricePercentChange2)
             
             let marketCapChange = "$\(coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a")"
             let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
             let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
             
             let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
             let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
             let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
             
             let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
             let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
             
             let additionalArray: [StatisticModel] = [
                 highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
             ]
             
             return (overviewArray, additionalArray)
         })
         */
        // Using .map to map the data to statistics using a function:
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                guard let self = self else { return }
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                guard let self = self else { return }
                self.coinDescription = returnedCoinDetails?.readableDescription
                self.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
        
    }
    
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    // Function to create overview array:
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        // Logic for the overviewArray to be used in the DetailView:
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$\(coinModel.marketCap?.formattedWithAbbreviations() ?? "")"
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$\(coinModel.totalVolume?.formattedWithAbbreviations() ?? "")"
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    // Function to create additionalArray:
    private func createAdditionalArray(coinDetailModel: CoinDetailModel? ,coinModel: CoinModel ) -> [StatisticModel]{
        // Logic for the additionalArray to be used in the DetailView:
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Chnage", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$\(coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a")"
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return additionalArray
    }
    
}
