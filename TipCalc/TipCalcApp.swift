//
//  TipCalcApp.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI

@main
struct TipCalcApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TipViewModel())
        }
    }
}
