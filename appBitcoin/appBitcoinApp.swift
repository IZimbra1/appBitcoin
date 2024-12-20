//
//  appBitcoinApp.swift
//  appBitcoin
//
//  Created by Guest User on 17/12/24.
//

import SwiftUI

@main
struct appBitcoinApp: App {
    var body: some Scene {
        WindowGroup {
            BitcoinPriceView(viewModel: BitcoinPriceViewModel())
        }
    }
}
