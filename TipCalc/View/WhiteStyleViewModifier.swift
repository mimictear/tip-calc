//
//  WhiteStyleViewModifier.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI

struct WhiteStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color(UIColor.lightGray.withAlphaComponent(0.3)))
            .foregroundColor(.white)
    }
}
