//
//  HomeView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // To Animate right
    @State private var showPortfolioView: Bool = false // To Show portfolio Sheet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPortfolioView) {
                        PortfolioView()
                            .environmentObject(vm)
                    }
                
                // Content Layer:
                VStack {
                    homeHeader
                    
                    HomeStatsView(showPortfolio: $showPortfolio)
                    
                    SearchBarView(searchText: $vm.searchText)
                    
                    columnTitle
                    
                    if !showPortfolio {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    
                    if showPortfolio {
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    
                    Spacer(minLength: 0)
                }
            }
            /*
             .background(
                 NavigationLink(destination: DetailView(coin: selectedCoin)),
                                isActive: $showDetailView,
                                label: { EmptyView() })
             )
             */
            .navigationDestination(isPresented: $showDetailView) {
                DetailView(coin: selectedCoin ?? DeveloperPreview.instance.coin)
            }
        }
 
    }
    
}

#Preview {
    NavigationStack{
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio{
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
    // Coin list for the Home View:
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                // Instead of using a NavigationLink we are using .onTapGesture{} for lazy loading:
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    // Coin list for the Portfolio View:
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin: CoinModel) {
        // Add logic for segueing to the DetailView() for the tapped coin
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitle: some View {
        HStack{
            HStack(spacing: 4) {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                  
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReveresed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReveresed : .holdings
                    }
                }
                
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReveresed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReveresed : .price
                }
            }
            
            
            Button {
                withAnimation(.linear(duration: 0.75)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    
}
