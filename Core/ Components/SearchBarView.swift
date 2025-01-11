//
//  SearchBarView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 29/11/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding  var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                   // To dismiss the keyboard when the xmark is tapped using UIApplication extension: 
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        SearchBarView(searchText: .constant(""))
            .environment(\.colorScheme, .dark)
        
        SearchBarView(searchText: .constant(""))
            .environment(\.colorScheme, .light)
    }
}
