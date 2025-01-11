//
//  XmarkButton.swift
//  CryptoAttic
//
//  Created by Tanmay . on 02/12/24.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button{
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(.trailing, 8)
        }
    }
}

#Preview {
    XMarkButton()
}
