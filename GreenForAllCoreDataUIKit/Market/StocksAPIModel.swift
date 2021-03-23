//
//  StocksAPIModel.swift
//  ProtocolAFPEexample
//
//  Created by yoko on 11/03/2021.
//

import Foundation

struct StockPrice : Codable{
    let open: String
    let close: String
    let high: String
    let low: String
    let volume: String
    
    private enum CodingKeys: String, CodingKey {
        
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

struct StocksDaily : Codable {
    let timeSeriesDaily: [String: StockPrice]?
    
    private enum CodingKeys: String, CodingKey {
        case timeSeriesDaily = "Time Series (Daily)"
    }
    
    /*
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        timeSeriesDaily = try (values.decodeIfPresent([String : StockPrice].self, forKey: .timeSeriesDaily))
    }
 */
}
/*
let aaa = StockPrice(open: "1", close: "2", high: "3", low: "4", volume: "5")
let bbb = StockPrice(open: "11", close: "22", high: "33", low: "44", volume: "55")
let cc = StocksDaily(timeSeriesDaily: ["2021-03-23": aaa, "2021-3-22": bbb])
*/
