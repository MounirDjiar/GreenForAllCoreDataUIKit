//
//  MarketDetailJson.swift
//  Green4all
//
//  Created by vincent schmitt on 23/03/2021.
//

import SwiftUI

struct MarketDetailJson: View {
    /*
    @ObservedObject var stockGRNB = StockData(stockSymbol: "GRNB")
    @ObservedObject var stockMGGAX = StockData(stockSymbol: "MGGAX")
    @ObservedObject var stockCGAFX = StockData(stockSymbol: "CGAFX")
    @ObservedObject var stockBGRN = StockData(stockSymbol: "BGRN")
    @ObservedObject var stockIQQHDE = StockData(stockSymbol: "IQQH.DE")
    @ObservedObject var stockQCLN = StockData(stockSymbol: "QCLN")
    @ObservedObject var stockPBW =  StockData(stockSymbol: "PBW")
    @ObservedObject var stockAAPL = StockData(stockSymbol: "AAPL")
    @ObservedObject var stockIBM = StockData(stockSymbol: "IBM")
    @ObservedObject var stockMSFT = StockData(stockSymbol: "MSFT")
    *//*
    @EnvironmentObject var stockGRNB: StockData
    @EnvironmentObject var stockMGGAX: StockData
    @EnvironmentObject var stockCGAFX: StockData
    @EnvironmentObject var stockBGRN: StockData
    @EnvironmentObject var stockIQQHDE: StockData
    @EnvironmentObject var stockQCLN: StockData
    @EnvironmentObject var stockPBW: StockData
    @EnvironmentObject var stockAAPL: StockData
    @EnvironmentObject var stockIBM: StockData
    @EnvironmentObject var stockMSFT: StockData
    */
    @ObservedObject var stockGRNB: StockData
    @ObservedObject var stockMGGAX: StockData
    @ObservedObject var stockCGAFX: StockData
    @ObservedObject var stockBGRN: StockData
    @ObservedObject var stockIQQHDE: StockData
    @ObservedObject var stockQCLN: StockData
    @ObservedObject var stockPBW: StockData
    @ObservedObject var stockAAPL: StockData
    @ObservedObject var stockIBM: StockData
    @ObservedObject var stockMSFT: StockData
    
    @EnvironmentObject var modelData: ModelData
    
    @State var assetInfo: AssetInfo// = aaplInfo
    
    var assetInfoIndex: Int {
            modelData.assetInfos.firstIndex(where: { $0.id == assetInfo.id })!
        }
    
    private func assign(item: String) -> StockData {
        switch(item) {
        case "GRNB": return stockGRNB
        case "MGGAX": return stockMGGAX
        case "CGAFX": return stockCGAFX
        case "BGRN": return stockBGRN
        case "IQQH.DE": return stockIQQHDE
        case "QCLN": return stockQCLN
        case "PBW": return stockPBW
        case "AAPL": return stockAAPL
        case "IBM": return stockIBM
        case "MSFT": return stockMSFT
        default:
            return stockAAPL
        }
    }
    
    var body: some View {
        List {
            //VStack(alignment: .leading) {
            Group {
                HStack {
                //Text(item.symbol).font(.title)
                    Text(assetInfo.name).font(.title2)
                    Spacer()
                    FavoriteButton(isSet: $modelData.assetInfos[assetInfoIndex].isFavorite)
                }
                HStack {
                    //Text("\(itemData.lastRefreshedTimeSeries.assetDatas[0].close, specifier: "%.2f")").font(.title)
                    Text("\(Double("\(assign(item: assetInfo.symbol).currentPrice)") ?? 0.00, specifier: "%.2f") ").font(.title)
                    Text("USD").font(.caption).baselineOffset(-10)
                    //Spacer()
                    change//(element: assetInfo)
                    
                }
                //shortDate(now)
            
            //graph
            //GeometryReader{ geom in
                LineView(data: assign(item: assetInfo.symbol).prices, title: assetInfo.symbol, price: "\(assign(item: assetInfo.symbol).currentPrice) USD")
                    .frame(minWidth: 300, idealWidth: 400, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 100, idealHeight: 260, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)  //(width: 300, height: 250,  alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //(width: geom.frame(in: .local).width , height: 250)
                    .padding()
                    .background(colorTransparentClear)
            //}
            //datas
                /*
                dataListView(title: "High", data: itemData.lastRefreshedTimeSeries.assetDatas[0].high )
                dataListView(title: "Low", data: itemData.lastRefreshedTimeSeries.assetDatas[0].low)
                */
                dataListView(title: "Open", data: assign(item: assetInfo.symbol).open).listRowBackground(colorBackgroundMedium).foregroundColor(colorForeGroundGreenDark)
                dataListView(title: "Close", data: assign(item: assetInfo.symbol).close)
                    .listRowBackground(colorBackgroundClear).foregroundColor(colorForeGroundGreenDark)
                dataListView(title: "High", data: assign(item: assetInfo.symbol).high ).listRowBackground(colorBackgroundMedium).foregroundColor(colorForeGroundGreenDark)
                dataListView(title: "Low", data: assign(item: assetInfo.symbol).low).listRowBackground(colorBackgroundClear).foregroundColor(colorForeGroundGreenDark)
                dataListView(title: "Volume", data: assign(item: assetInfo.symbol).volume).listRowBackground(colorBackgroundMedium).foregroundColor(colorForeGroundGreenDark)
                
            }
            .listRowBackground(
                colorBackground
            )
        .navigationBarTitle(
            assetInfo.symbol
            //originalTitle
        )
        
    }
    .background(Color.green)
    .edgesIgnoringSafeArea(.all)
    .foregroundColor(.white)
    
    }
}

struct MarketDetailJson_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        MarketDetailJson(stockGRNB: StockData(stockSymbol: "GRNB"),stockMGGAX: StockData(stockSymbol: "MGGAX"), stockCGAFX: StockData(stockSymbol: "CGAFX"), stockBGRN: StockData(stockSymbol: "BGRN"), stockIQQHDE: StockData(stockSymbol: "IQQH.DE"), stockQCLN: StockData(stockSymbol: "QCLN"), stockPBW: StockData(stockSymbol: "PBW"), stockAAPL: StockData(stockSymbol: "AAPL"), stockIBM: StockData(stockSymbol: "IBM"), stockMSFT: StockData(stockSymbol: "MSFT"), assetInfo: modelData.assetInfos[0]).environmentObject(modelData)
        
        
    }
}

extension MarketDetailJson {
/*    private var change : some View {
        
        let open = Double(stocks.open)
        let close = Double(stocks.close) ?? 0
        let priceChange = open ?? 0 - close
        let percentChange = priceChange / (open ?? 0) * 100
    let colorChange = priceChange > 0 ? Color.green : Color.red
        
    return
            
    HStack {
        Spacer()
        Text("\(priceChange, specifier: "%.2f")").font(.title2).padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/).background(colorChange)
        Spacer()
        Text("(\(percentChange, specifier: "%.2f")%)").font(.title2).padding(.horizontal).background(colorChange)
    }
    }
*/
    private var change: some View {
        let open = Double(assign(item: assetInfo.symbol).open) ?? 0.0 //Double(stockAAPL.open) ?? 0
        let currentPrice = Double(assign(item: assetInfo.symbol).currentPrice) ?? 0.0 //Double(stockAAPL.open) ?? 0
        let close = Double(assign(item: assetInfo.symbol).close) ?? 0.0//Double(stockAAPL.close) ?? 0
        let priceChange = currentPrice - open
        let percentChange = priceChange / currentPrice * 100
        
        let colorChange = priceChange >= 0 ? Color.green : Color.red
    
    return
        HStack {
        Spacer()
        Text("\(priceChange, specifier: "%.2f")").font(.title2).padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/).background(colorChange)
        //Spacer()
            Text("(\(percentChange, specifier: "%.2f")%)").font(.title2).background(colorChange)
        }
    }
}


extension MarketDetailJson {
    //private func dataListView(title: String, data: Double) -> some View {
    private func dataListView(title: String, data: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
                //Text("\(data, specifier: "%.2f")")
            Text("\(Double(data) ?? 0, specifier: "%.2f")")
                .fontWeight(.bold)
        }
    }
}

