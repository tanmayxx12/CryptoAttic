//
//  DetailView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 15/01/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 20, maximum: 200)),
        GridItem(.flexible(minimum: 20, maximum: 200))
    ]
    private let spacing: CGFloat = 30
    
    
    init(coin: CoinModel) {
        // We need to initialize the @StateObject vm from the init like this:
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("HI")
                    .frame(height: 150)
                
                overviewTitle
                Divider()
                overviewGrid
                Divider()
                additionalTitle
                additionalGrid
                

            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
    
}


extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    
}