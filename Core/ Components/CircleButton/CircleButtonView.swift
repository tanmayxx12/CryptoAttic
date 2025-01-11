//
//  CircleButtonView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10)
            .padding()
    }
}

#Preview("Circle Button View", traits: .sizeThatFitsLayout) {
    Group{
        CircleButtonView(iconName: "info")
            .environment(\.colorScheme, .dark)
        
        CircleButtonView(iconName: "plus")
            .environment(\.colorScheme, .light)
    }
    
}
