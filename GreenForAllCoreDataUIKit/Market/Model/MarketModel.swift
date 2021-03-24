//
//  MarketModel.swift
//  Green4all
//
//  Created by yoko on 18/03/2021.
//

import Foundation

struct AssetInfo: Hashable, Codable, Identifiable {
    var id = UUID()
    var symbol: String
    var name: String
    var company: String
    //var lastRefreshed: Date
    //var intradayInterval: Int
    //var outputSize: String  //compact or full
    var timeZone: String //US/Eastern
    //var timeSeries: Array<TimeSeries>
    var isFavorite: Bool
}
/*
struct TimeSeries: Identifiable {
    var id = UUID()
    var temporalResolutions: TypeTemporalResolution
    var lastRefreshedTimeSeries: LastRefreshedTime
}

struct LastRefreshedTime {
    var timeSeriesDate: Date
    var assetDatas: [AssetData]
}
*/
/*
struct AssetData {
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Double
}
 */
/*
enum TypeTemporalResolution {
    case intraday(min: Int), daily, weekly, monthly
}
*/
let now = Date()

//let aapl = AssetInfo(symbol: "AAPL", name: "Apple Inc.", company: "Apple Inc", lastRefreshed: now, intradayInterval: 5, outputSize: "compact", timeZone: "US/Eastern", isFavorite: false)
let aaplInfo = AssetInfo(symbol: "AAPL", name: "Apple Inc", company: "Apple Inc", timeZone: "US/Eatsern", isFavorite: true)
let ibmInfo = AssetInfo(symbol: "IBM", name: "IBM Inc", company: "IBM Inc" , timeZone: "US/Eastern", isFavorite: false)
let msftInfo = AssetInfo(symbol: "MSFT", name: "Microsoft", company: "Microsoft Corporation" , timeZone: "US/Eastern", isFavorite: false)
let grnbInfo = AssetInfo(symbol: "GRNB", name: "VanEck Vectors Green Bond ETF", company: "VanEck Vectors", timeZone: "US/Eastern", isFavorite: false)
let mggaxInfo = AssetInfo(symbol: "MGGAX", name: "Mirova Global Green Bond fund", company: "Mirova", timeZone: "US/Eastern", isFavorite: false)
let cgafxInfo = AssetInfo(symbol: "CGAFX", name: "Calvert Green Bond fund", company: "Calvert Green Bond fund", timeZone: "US/Eastern", isFavorite: false)
let bgrnInfo = AssetInfo(symbol: "BGRN", name: "iShares Global Green Bond ETF", company: "iShares", timeZone: "US/Eastern", isFavorite: false)
let iqqhdeInfo = AssetInfo(symbol: "IQQH.DE", name: "iShares Global Clean Energy UCITS ETF USD (Dist)", company: "iShares", timeZone: "US/Eastern", isFavorite: false)
let qclnInfo = AssetInfo(symbol: "QCLN", name: "First Trust NASDAQ Clean Edge Green Energy Index Fund", company: "First Trust", timeZone: "US/Eastern", isFavorite: false)
let pbwInfo = AssetInfo(symbol: "PBW", name: "Invesco WilderHill Clean Energy ETF", company: "Invesco", timeZone: "US/Eastern", isFavorite: false)

/*
let aaplTimeSeriesIntraday = TimeSeries(temporalResolutions: TypeTemporalResolution.intraday(min: 5), lastRefreshedTimeSeries: LastRefreshedTime(timeSeriesDate: now, assetDatas: [assetData1, assetData1]))
*/
/*
let assetData1 = AssetData(open: 124.05, high: 125.86, low: 122.34, close: 124.76, volume: 111440000)
*/

final class ModelData: ObservableObject {
    @Published var assetInfos: [AssetInfo] = [grnbInfo, mggaxInfo, cgafxInfo, bgrnInfo, iqqhdeInfo, qclnInfo, pbwInfo, aaplInfo, ibmInfo, msftInfo]
    //= load("landmarkData.json")
    
    /*
    var categories: [String: [AssetInfo]] {       // create list by categories
        Dictionary(grouping: assetInfos, by: { $0.category.rawValue })
    }
     */
}


//let modelData = ModelData()

/*
let stockApple = Stocks(stockSymbol: "AAPL")
let stockIBM = Stocks(stockSymbol: "IBM")
let stockMicrosoft = Stocks(stockSymbol: "MSFT")
*/

/*

struct GreenFinanceCollection {
    var id = UUID()
    var assetInfo: AssetInfo// = aaplInfo
    var stock: Stocks// = stockApple
}

let aapl = GreenFinanceCollection(assetInfo: aaplInfo, stock: stockApple)
let ibm = GreenFinanceCollection(assetInfo: ibmInfo, stock: stockIBM)
let msft = GreenFinanceCollection(assetInfo: msftInfo, stock: stockMicrosoft)

let greenFinanceCollections = ["AAPL": aapl, "IBM": ibm, "MSFT": msft]
*/
