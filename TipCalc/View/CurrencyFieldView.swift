//
//  CurrencyField.swift
//  TipCalc
//
//  Created by ANDREW VORONTSOV on 10.03.2023.
//

import SwiftUI

public struct CurrencyField: View {
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let currencyEditingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let title: String
    let foregroundColor: Color
    let value: Binding<NSNumber?>
    @State private var valueWhileEditing: String = ""
    @State private var isEditing: Bool = false
    
    public init(_ title: String,
                foregroundColor: Color,
                value: Binding<NSNumber?>
    ) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.value = value
    }
    
    public var body: some View {
        TextField(
            title,
            text: Binding(
                get: {
                    self.isEditing ?
                    self.valueWhileEditing :
                    self.formattedValue
                }, set: { newValue in
                    let strippedValue = newValue.filter{ "0123456789.".contains($0) }
                    if strippedValue.filter({$0 == "."}).count <= 1 {
                        self.valueWhileEditing = strippedValue
                        self.updateValue(with: strippedValue)
                    } else {
                        let newValue = String(
                            strippedValue.dropLast(strippedValue.count - self.valueWhileEditing.count)
                        )
                        self.valueWhileEditing = newValue
                        self.updateValue(with: newValue)
                    }
                }
            ), onEditingChanged: { isEditing in
                self.isEditing = isEditing
                self.valueWhileEditing = self.formattedValue
            }
        )
        .foregroundColor(foregroundColor)
    }
    
    // MARK: - Methods
    
    private var formattedValue: String {
        guard let value = self.value.wrappedValue else {
            return ""
        }
        let formatter = isEditing ? currencyEditingFormatter : currencyFormatter
        guard let formattedValue = formatter.string(for: value) else {
            return ""
        }
        return formattedValue
    }
    
    private func updateValue(with string: String) {
        let newValue = currencyEditingFormatter.number(from: string)
        if let newString = newValue.map({ currencyEditingFormatter.string(for: $0) }),
           let specificValue = newString.map({ currencyEditingFormatter.number(from: $0) }) {
            value.wrappedValue = specificValue
        }
    }
}
