//
//  CircleButtonAnimationView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
//    @State private var animate: Bool = false
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 0.8) : .none, value: animate)
            
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
