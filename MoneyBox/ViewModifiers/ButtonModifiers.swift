//
//  ButtonModifiers.swift
//  MoneyBox
//
//  Created by James Penny on 24/01/2024.
//

import SwiftUI

struct FilledButtonModifier: ViewModifier {
    
    let accentColor = UIColor(red: 0.343, green: 0.750, blue: 0.710, alpha: 1)
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
//            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 360, height: 44)
            .background(Color.init((accentColor)))
            .cornerRadius(8)
            .padding()
    }
}

#Preview {
    FilledButtonModifier() as! any View
}
