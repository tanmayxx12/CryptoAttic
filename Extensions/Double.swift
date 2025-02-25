//
//  Double.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import Foundation

extension Double {
    
    
    /// Convert a Double into a currency with 2 decimal places
    ///  ```
    ///    Convert 1234.56 to $1,234.56
    ///  ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- Default Value
        formatter.currencyCode = "usd" // <- Change Currency
        formatter.currencySymbol = "$" // <- Change currency symbol
        formatter.minimumFractionDigits = 2 // Minimum number of digits after decimal
        formatter.maximumFractionDigits = 2 // Maximum number of digits after decimal
        return formatter
    }
    
    /// Convert a Double into a currency as a String with 2 decimal places
    ///  ```
    ///    Convert 1234.56 to  "$1,234.56"
    ///  ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Convert a Double into a currency with 2-6 decimal places
    ///  ```
    ///    Convert 1234.56 to $1,234.56
    ///    Convert 12.3456 to $12.3456
    ///    Convert 0.123456 to $0.123456
    ///  ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- Default Value
        formatter.currencyCode = "usd" // <- Change Currency
        formatter.currencySymbol = "$" // <- Change currency symbol
        formatter.minimumFractionDigits = 2 // Minimum number of digits after decimal
        formatter.maximumFractionDigits = 6 // Maximum number of digits after decimal
        return formatter
    }
    
    /// Convert a Double into a currency as a String with 2-6 decimal places
    ///  ```
    ///    Convert 1234.56 to  "$1,234.56"
    ///    Convert 12.3456 to  "$12.3456"
    ///    Convert 0.123456 to "$0.123456"
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into a String representation
    ///  ```
    ///    Convert 1.2345 to "1.23"
    ///  ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert a Double into a String representation
    ///  ```
    ///    Convert 1.2345 to "1.23%"
    ///  ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
    
    
}
