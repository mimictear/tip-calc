//
//  ContentView.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel: TipViewModel
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    init(viewModel: TipViewModel) {
        self.viewModel = viewModel
        customizeViews()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackgroundView().navigationTitle("Tip Calculator")
                
                Form {
                    Section(content: {
                        
                        Stepper(
                            "Guests: \(viewModel.guests.description)",
                            value: $viewModel.guests,
                            in: 1...10
                        )
                        .applyWhiteStyle()
                        
                        CurrencyField(
                            "Enter meal cost",
                            foregroundColor: .white,
                            value: Binding(get: {
                                viewModel.amount.map { NSDecimalNumber(decimal: $0) }
                            }, set: { number in
                                viewModel.amount = number?.decimalValue
                            })
                        )
                        .applyWhiteStyle()
                    },
                            header: { SectionTitleView("Enter Your Meal Information") },
                            footer: { SectionTitleView(viewModel.footerText) })
                    
                    
                    Section(header: SectionTitleView("Select Tip Percentage"),
                            content: {
                        
                        Picker(selection: $viewModel.selectedTipIndex) {
                            ForEach(Range(0...3), id: \.self) { value in
                                Text("\(viewModel.tipPercentages[value].description)%")
                                    .tag(value)
                                    .font(.title)
                            }
                        } label: {}
                            .pickerStyle(.segmented)
                            .applyWhiteStyle()
                    })
                    
                    Section(header: SectionTitleView("To Pay"),
                            content: {
                        
                        Text("Tip to Pay: \(currencyFormatter.string(from: viewModel.tip ?? 0) ?? "0")")
                            .applyWhiteStyle()
                        
                        Text("Tip Per Guest: \(currencyFormatter.string(from: viewModel.guestTip ?? 0) ?? "0")")
                            .applyWhiteStyle()
                        
                        Text("Total to Pay: \(currencyFormatter.string(from: viewModel.toPay ?? 0) ?? "0")")
                            .applyWhiteStyle()
                    })
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    private func customizeViews() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .highlighted)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .selected)
    }
}

fileprivate extension View {
    
    func applyWhiteStyle() -> some View {
        modifier(WhiteStyle())
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: TipViewModel())
    }
}
