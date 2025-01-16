//
//  DetailView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 15/01/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        // We need to initialize the @StateObject vm from the init like this:
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for: \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
