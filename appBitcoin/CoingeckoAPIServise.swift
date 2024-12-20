//
//  CoingeckoAPIServise.swift
//  appBitcoin
//
//  Created by jimbo on 17/12/24.
//


import Combine
import Foundation

struct CoingeckoAPIServise{
    static let shared = CoingeckoAPIServise()
    
    func fetchBitcoinPriceInMXN() -> AnyPublisher<APIResponse, Error> {
         guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=mxn") else {
             let error = URLError(.badURL)
             return Fail(error: error).eraseToAnyPublisher()
         }
    
        return URLSession.shared.dataTaskPublisher(for: url)
                    .tryMap({ data, response in
                        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                        return data
                    })
                    .decode(type: APIResponse.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
}

struct APIResponse: Decodable {
    let bitcoin: CurrencyRate
}

struct CurrencyRate: Decodable {
    let mxn: Double
}
