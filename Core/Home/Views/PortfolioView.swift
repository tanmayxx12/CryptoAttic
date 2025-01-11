//
//  PortfolioView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 02/12/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                }
                .animation(.none, value: selectedCoin?.id)
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
                      
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}


extension PortfolioView {
    private var  coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 75)
                        .padding(12)
                        .onTapGesture{
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                    , lineWidth: 1)
                        )
                }
            }
            .frame(height: 110)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id} ),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
    }
    
    
    private func getCurrentValue() ->  Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View{
        VStack{
            HStack(spacing: 20){
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                    .padding(.leading)
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    .padding(.trailing)
            }
            Divider()
            HStack{
                Text("Amount holding:")
                    .padding(.leading)
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                    .padding(.leading)
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
                    .padding(.trailing)
            }
        }
        .animation(.none, value: quantityText)
        .padding()
        .font(.headline)
    }
    
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button{
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0 )
        
        }
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio:
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show Checkmark:
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // Hide keyboard:
        UIApplication.shared.endEditing()
        
        // Hide Checkmark:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn) {
                showCheckMark = false
            }
        }
        
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}
