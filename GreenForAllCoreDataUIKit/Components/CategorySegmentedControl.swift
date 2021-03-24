//
//  CategorySegmentedControl.swift
//  GreenForAllCoreDataUIKit
//
//  Created by Mounir DJIAR on 22/03/2021.
//

import SwiftUI

struct CategorySegmentedControl: View {
    
    @Binding var selectedCategory:CategoryProject
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $selectedCategory, label: Text("")) {
                    ForEach(CategoryProject.allCases, id: \.self) {
                        Text("\($0.categoryProjectTitle)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)
        }
    }
}

struct CategorySegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CategorySegmentedControl(selectedCategory: .constant(CategoryProject.energie))
    }
}
