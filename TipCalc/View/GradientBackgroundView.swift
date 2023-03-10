//
//  GradientBackgroundView.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.blue, .gray],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

// MARK: - Preview

struct GradientBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackgroundView()
    }
}
