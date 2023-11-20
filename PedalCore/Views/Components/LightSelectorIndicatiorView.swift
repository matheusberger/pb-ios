//
//  LightSelectorIndicatiorView.swift
//  PedalCore
//
//  Created by Lucas Migge on 20/11/23.
//

import SwiftUI

struct LightSelectorIndicatiorView: View {
    
    var body: some View {
        Group {
            Circle()
                .scaledToFit()
                .shadow(color: .green, radius: 2)
                .foregroundColor(.green)

        }
        .frame(width: 15, height: 15)
        
    }
}


struct LightSelectorIndicatiorView_Previews: PreviewProvider {
    static var previews: some View {
        LightSelectorIndicatiorView()
    }
}
