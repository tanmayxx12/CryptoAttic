//
//  DetailView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 15/01/25.
//

import SwiftUI

struct DetailView: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing Detail View for: \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
