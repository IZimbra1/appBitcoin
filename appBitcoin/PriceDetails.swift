//
//  PriceDetails.swift
//  appBitcoin
//
//  Created by Guest User on 17/12/24.
//

import Foundation


enum Currency: CaseIterable{
case usd
case gbp
case eur
case mxn

    
    
    
    
    
    
    var icon: String {
        
        switch self {
        case .usd:
            
            return "💵"
            
        case .gbp:
            return "💷"
            
        case .eur:
            return "💶"
            
        case .mxn:
            return "🇲🇽"
        }
        
        
        
    }
    
    
    var code: String {
        switch self {
        case .usd:
            return "USD"
            
        case .gbp:
            return "GBP"
   
        case .eur:
            return "EUR"
     
        case .mxn:
            return "MXN"
        }
    }
    
}


struct PriceDetails {
    
    let currency: Currency
    let rate: String
    
    
    public init(currency: Currency, rate: String = "-----") {
        self.currency = currency
        self.rate = rate
    }
}
