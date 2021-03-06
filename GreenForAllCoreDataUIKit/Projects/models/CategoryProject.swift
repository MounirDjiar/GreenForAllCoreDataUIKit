//
//  CategoryProject.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 21/03/2021.
//

import Foundation


enum CategoryProject : Int64, CaseIterable {
    case energie, batiment, transport
    
    var categoryProjectTitle : String {
        switch self {
        case .energie: return "Enérgie"
        case .batiment: return "Batiment"
        case .transport: return "Transport"
        }
    }
    
    var categoryProjectImage : String {
        switch self {
        case .energie: return "energie"
        case .batiment: return "batiment"
        case .transport: return "transport"
        }
    }
}
