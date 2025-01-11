//
//  UIApplication.swift
//  CryptoAttic
//
//  Created by Tanmay . on 29/11/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
