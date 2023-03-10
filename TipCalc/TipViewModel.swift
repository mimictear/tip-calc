//
//  TipViewModel.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI
import Combine

class TipViewModel: ObservableObject {
    
    // Output
    @Published var tip: NSDecimalNumber?
    @Published var guestTip: NSDecimalNumber?
    @Published var toPay: NSDecimalNumber?
    @Published var footerText: String = ""
    
    // Input
    @Published var amount: Decimal?
    @Published var guests = 2
    @Published var selectedTipIndex = 0
    
    let tipPercentages = [10, 15, 20, 25]
    var tipPercentage = 0
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $amount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $guests
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $selectedTipIndex
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    }
    
    // MARK: - Methods & Functions
    
    func calculateTip() {
        guard let amount = amount else {
            return
        }
        footerText = makeFooterText(by: amount)
        let tipPercentage = calculateTipPercentage(amount: amount)
        tip = NSDecimalNumber(value: tipPercentage)
        guestTip = NSDecimalNumber(value: tipPercentage / Double(guests))
        if let tip {
            toPay = NSDecimalNumber(decimal: amount).adding(tip)
        }
    }
    
    private func calculateTipPercentage(amount: Decimal) -> Double {
        (Double(tipPercentages[selectedTipIndex]) / 100) * NSDecimalNumber(decimal: amount).doubleValue / Double(guests)
    }
    
    private func makeFooterText(by amount: Decimal) -> String {
        switch amount {
        case 1000...10_000:
            return "Wow! You are so rich :)"
        case 10_001...50_000:
            return "Wow! You are sooo rich :)"
        case 50_001...:
            return "Wow! You are soooooooo rich :)"
        default:
            return ""
        }
    }
}
