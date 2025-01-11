//
//  MarketDataModel.swift
//  CryptoAttic
//
//  Created by Tanmay . on 01/12/24.
//

import Foundation

// JSON Data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 15771,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1178,
     "total_market_cap": {
       "btc": 36908865.9587969,
       "eth": 975191709.161302,
       "ltc": 34905923551.6958,
       "bch": 6731321142.06392,
       "bnb": 5469270788.68225,
       "eos": 3802951489255.54,
       "xrp": 1881004546427.62,
       "xlm": 6723256839625.97,
       "link": 189156688657.163,
       "dot": 397503759792.809,
       "yfi": 449526731.183204,
       "usd": 3578110848637.24,
       "aed": 13142401147044.6,
       "ars": 3615681012547926,
       "aud": 5498021364801.37,
       "bdt": 426769707368012,
       "bhd": 1348407495198.09,
       "bmd": 3578110848637.24,
       "brl": 21375276398674,
       "cad": 5013827826652.91,
       "chf": 3152941827047.92,
       "clp": 3484543249945369,
       "cny": 25911605332576.3,
       "czk": 85452801098239.4,
       "dkk": 25231048649165.4,
       "eur": 3382595715646,
       "gbp": 2810108714196.59,
       "gel": 9786133171022.83,
       "hkd": 27843248474213.1,
       "huf": 1.39646510200614e+15,
       "idr": 56662963399019350,
       "ils": 13002471966086.9,
       "inr": 302569883810410,
       "jpy": 535839859930216,
       "krw": 4993322217252242,
       "kwd": 1099585666783.86,
       "lkr": 1.03801585391634e+15,
       "mmk": 7506876560440908,
       "mxn": 72905797596408.1,
       "myr": 15904702722192.5,
       "ngn": 6010359589372447,
       "nok": 39520949945367.9,
       "nzd": 6139215250766.32,
       "php": 209682659318304,
       "pkr": 993025189041093,
       "pln": 14544276352653.8,
       "rub": 380934780081807,
       "sar": 13442819333896.1,
       "sek": 38998903572552,
       "sgd": 4792163859579.85,
       "thb": 122665043002630,
       "try": 124099257174089,
       "twd": 116124009481673,
       "uah": 148547136076927,
       "vef": 358276239274.046,
       "vnd": 90692586624983740,
       "zar": 64622614106246.9,
       "xdr": 2731977085705.75,
       "xag": 116870618091.349,
       "xau": 1350307472.05872,
       "bits": 36908865958796.9,
       "sats": 3690886595879691
     },
     "total_volume": {
       "btc": 2147084.04936637,
       "eth": 56729420.1385648,
       "ltc": 2030567716.97927,
       "bch": 391578334.360701,
       "bnb": 318161606.080077,
       "eos": 221227509190.066,
       "xrp": 109422892129.195,
       "xlm": 391109213061.956,
       "link": 11003733073.2444,
       "dot": 23123820254.1111,
       "yfi": 26150130.8483639,
       "usd": 208147948478.019,
       "aed": 764527414759.766,
       "ars": 210333501937039,
       "aud": 319834101340.819,
       "bdt": 24826296003392,
       "bhd": 78440346235.9931,
       "bmd": 208147948478.019,
       "brl": 1243455029412.84,
       "cad": 291667312804.824,
       "chf": 183414768500.119,
       "clp": 202704879625319,
       "cny": 1507344998493.27,
       "czk": 4971010120346.91,
       "dkk": 1467755258692.75,
       "eur": 196774328277.284,
       "gbp": 163471280964.646,
       "gel": 569284639087.383,
       "hkd": 1619713668479.13,
       "huf": 81235981332001.4,
       "idr": 3.29623091209792e+15,
       "ils": 756387372938.635,
       "inr": 17601271523031.8,
       "jpy": 31171188449822,
       "krw": 290474448550586,
       "kwd": 63965737898.8316,
       "lkr": 60384062881292.5,
       "mmk": 436694395906884,
       "mxn": 4241118524213.89,
       "myr": 925217630984.797,
       "ngn": 349638138969211,
       "nok": 2299035720529.42,
       "nzd": 357134005560.132,
       "php": 12197781794586.7,
       "pkr": 57766839717842.6,
       "pln": 846078115789.865,
       "rub": 22159959915202.9,
       "sar": 782003516513.98,
       "sek": 2268666934846.49,
       "sgd": 278772547396.611,
       "thb": 7135742331931.9,
       "try": 7219174274120.34,
       "twd": 6755233519905.64,
       "uah": 8641370526146.14,
       "vef": 20841854081.1041,
       "vnd": 5275821976098122,
       "zar": 3759264349405.22,
       "xdr": 158926162361.68,
       "xag": 6798665670.83506,
       "xau": 78550872.7966351,
       "bits": 2147084049366.37,
       "sats": 214708404936637
     },
     "market_cap_percentage": {
       "btc": 53.6161312083972,
       "eth": 12.350933322604,
       "usdt": 3.7449650277825,
       "sol": 3.17496655525938,
       "xrp": 3.03477574601163,
       "bnb": 2.66744696064815,
       "doge": 1.73800725532501,
       "usdc": 1.11357014406367,
       "ada": 1.08346148781888,
       "steth": 1.00516143176846
     },
     "market_cap_change_percentage_24h_usd": -0.190536263742809,
     "updated_at": 1732994206
   }
 }
 
 */


struct GlobalData: Codable {
    let data: MarketDataModel?
}


struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        // Accessing only "usd" from the dictionary
        /*
         if let item = totalMarketCap.first(where: { (key, value) -> Bool in
             return key == "usd"
         }) {
             return "\(item.value)"
         }
         */
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key ==  "btc" }) {
            return "\(item.value.asPercentString())"
        }
        return ""
    }
    
}
