//
//  SelectPedalRow.swift
//  PedalBoard
//
//  Created by Lucas Migge on 23/11/23.
//

import SwiftUI

struct SelectPedalRow: View {
    
    let pedal: Pedal.Model
    let isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(pedal.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(pedal.brand)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if isOn {
                Circle()
                    .scaledToFit()
                    .shadow(color: .green, radius: 2)
                    .foregroundColor(.green)
                    .frame(width: 15, height: 15)
            }
            
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    SelectPedalRow(pedal: Pedal.pedalSample().first!, isOn: true)
}
