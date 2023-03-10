//
//  SectionTitleView.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI

struct SectionTitleView: View {
    
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.subheadline)
    }
}

// MARK: - Preview

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView("Test")
            .preferredColorScheme(.dark)
    }
}
