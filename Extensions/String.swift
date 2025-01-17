//
//  String.swift
//  CryptoAttic
//
//  Created by Tanmay . on 17/01/25.
//

import Foundation


extension String {
    
    var removingHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
}
