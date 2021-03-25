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
            .onAppear {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.init(Color("greenSearchBar"))], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.init(Color("greenSearchBar"))], for: .normal)
            }
            .background(Color.white.opacity(0.7))
            .cornerRadius(7)
            .padding(.horizontal)
        }
    }
}

struct CategorySegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CategorySegmentedControl(selectedCategory: .constant(CategoryProject.energie))
    }
}
