//
//  ProgressBar.swift
//  Green4all
//
//  Created by Mounir DJIAR on 19/03/2021.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    
    var value: Float
    var filColor: Color = .white
    var bgColor: Color = Color(.systemGray4)
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.9)
                    .foregroundColor(bgColor)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(filColor)
                    .animation(.linear)
                    .overlay(
                        Text("\(Int((self.value) * 100)) %")
                            .foregroundColor(.white)
                    )
            }.cornerRadius(8.0)
        }
    }
}
