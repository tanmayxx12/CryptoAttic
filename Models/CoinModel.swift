//
//  CoinModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import Foundation

// CoinGecko API info:
/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 97552,
     "market_cap": 1929307663421,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 2047742766801,
     "total_volume": 102552184737,
     "high_24h": 98311,
     "low_24h": 93330,
     "price_change_24h": 3710.88,
     "price_change_percentage_24h": 3.95443,
     "market_cap_change_24h": 73551636339,
     "market_cap_change_percentage_24h": 3.96343,
     "circulating_supply": 19785425,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 98311,
     "ath_change_percentage": -0.94193,
     "ath_date": "2024-11-21T11:10:30.919Z",
     "atl": 67.81,
     "atl_change_percentage": 143515.96528,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-11-21T13:08:10.058Z",
     "sparkline_in_7d": {
       "price": [91557.6772042968, 91292.9912638905, 90759.0665522221, 88990.3063827792, 87991.2937427918, 89193.4938009753, 89297.6869386294, 89134.7938005786, 89479.8021444136, 87622.6663114814, 88297.2089612439, 87388.4951475077, 87407.5127371013, 87997.4166511566, 87929.0031830515, 88363.5593115567, 88247.0504933321, 87482.2684986625, 87741.2044478721, 88210.6530251226, 87675.1571017323, 88161.8675410656, 89093.3341294549, 89465.3409614393, 89838.9261134544, 89713.2974868307, 90162.7734958013, 88887.3017910324, 88823.3143819269, 89483.7706056713, 89409.7702872273, 89300.5789642204, 90652.179785891, 91248.4835128307, 91665.9088620945, 91238.9045023836, 91291.1318452483, 91202.153913598, 91237.1819791662, 91453.604121957, 91215.0652948323, 91311.7504197232, 91342.4637997932, 91222.7474511714, 91150.9762385174, 91413.2781589377, 91378.2277120562, 91346.9527221259, 91219.3763453195, 90906.8269195682, 90726.362349229, 91034.8581513298, 90408.3398406952, 90655.7524809398, 90870.965612478, 91150.5867643849, 91149.7406642989, 90874.956640939, 91070.9570412842, 90514.9443964408, 90596.7362382927, 90846.625421431, 89938.591712392, 90087.8365116415, 90333.9276736795, 90539.180669052, 90476.2674337044, 90483.4677667843, 90486.4857338097, 91439.3386568074, 91317.4512488743, 91061.2314552801, 90822.8600990333, 90825.4881160347, 90660.8413761539, 90256.0581604807, 90131.1008831464, 90399.5280174711, 90323.7740231388, 89842.9452785861, 90110.8801378505, 89603.0279804257, 89066.6638477386, 89574.7472750456, 89794.9817929793, 89903.4672138004, 90801.3176701142, 90340.7162195974, 90645.8783193493, 90514.6756052752, 90644.9533174999, 92029.4483621048, 91746.1122011194, 91782.9618226931, 91919.5901479509, 91767.9041915474, 90285.011509212, 90298.1324928689, 89442.9491271893, 90478.4781344859, 92154.9721568814, 91485.3476393811, 91476.322349369, 90445.4338930811, 90755.9776363985, 91836.7002239105, 91350.0976040857, 91145.9013221998, 90456.6927867799, 91112.0829803115, 90739.2765548068, 91292.9941216552, 91438.429503869, 91664.6919786892, 91947.315231526, 92041.9127881023, 91799.8890032111, 91816.2031489251, 91765.5499054232, 91844.090941937, 91725.1925863255, 92496.8440660628, 91310.0133991552, 92070.4303067129, 92381.5938911111, 92586.920332828, 93255.7114373146, 93799.1768107835, 93448.5314794465, 92402.4746198208, 92352.9515491435, 91757.2118314815, 92351.0303341436, 92228.6483949917, 91964.1642940626, 91873.0799910065, 92059.512957755, 92203.1672296674, 92682.2661333509, 92393.5899260742, 92867.7306935129, 93270.1564889949, 93231.830167103, 93265.39728397, 93681.3448870722, 94244.9149552528, 94500.5928436493, 94677.2971763401, 94521.8729533256, 94213.1999212873, 94099.9966572066, 93906.1822997384, 94136.7839854972, 94332.4649676055, 94417.0532571613, 94201.3617246574, 94217.0222963421, 94937.2994727348, 94600.6381954203, 94704.0644942335, 95898.30691266, 97516.950253966, 97417.9519713438, 97038.0493728357, 97025.2665500636, 97254.1862855929, 97689.2096860521, 98310.5703851254]
     },
     "price_change_percentage_24h_in_currency": 3.95443486965354
   }
 
 */

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}

