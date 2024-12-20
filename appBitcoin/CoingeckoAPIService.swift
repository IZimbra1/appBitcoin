//
//  CoingeckoAPIService.swift
//  appBitcoin
//
//  Created by jimbo on 17/12/24.
//
import Combine
import Foundation

struct CoingeckoAPIService{
    
    public static let shared = CoingeckoAPIService()
    
    public func fetchBitcoinPrice() -> AnyPublisher<APIResponse, Error>{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=mxn") else{
            let error = URLError(.badURL)
            
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                guard httpResponse.statusCode == 200 else {
                    let code = URLError.Code(rawValue: httpResponse.statusCode)
                    throw URLError(code)
                }
                
                return data
            })
        
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    struct APIResponse: Decodable{
        let time: APITime
        let bpi: APIBitcoinPriceIndex
    }

    struct APITime: Decodable{
        let updated: String
    }


    struct APIBitcoinPriceIndex: Decodable {
        let USD: APIPriceData
        let GBP: APIPriceData
        let EUR: APIPriceData
        let MXN: APIPriceData
      
    }


    struct APIPriceData: Decodable{
        let rate: String
    }

    
}
