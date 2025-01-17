//
//  ChartView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 17/01/25.
//

import Charts
import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
        
        
    }
    
    // Logic Explanation:
    /*
     300
     100
     3
     1 * 3 = 3
     2 * 3 = 6
     3 * 3 = 9
     .
     .
     100 * 3 = 300
     
     if max is 60,000 and min is 50,000:
     yAxis = 60,000 - 50,000 = 10,000
     if dataPoint = 52,000
     52,000 - 50,000 = 2,000 / 10,000 = 20% of the screen
     */
    
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxisLabels.padding(.horizontal, 4), alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = ( 1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                        
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor ,style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 5, x: 0.0, y: 5)
//            .shadow(color: lineColor.opacity(0.4), radius: 5, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 5, x: 0.0, y: 15)
            .shadow(color: lineColor.opacity(0.1), radius: 5, x: 0.0, y: 20)
        }
    }
    
    private var chartBackground: some View {
        VStack {
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            
        }
    }
    
    private var chartYAxisLabels: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
    
    
}
