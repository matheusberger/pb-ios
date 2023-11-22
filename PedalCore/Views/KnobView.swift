//
//  KnobView.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

struct KnobView: View {
    var knob: Knob
    
    private func maxTrin(for level: Float) -> CGFloat {
        return CGFloat(0.75 * level)
    }
    
    var body: some View {
           VStack {
               Text(knob.name)
                   .font(.subheadline)
               
               ZStack {
                   Circle()
                       .trim(from: 0.0, to: maxTrin(for: 1))
                       .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                       .foregroundColor(.accentColor)
                       .rotationEffect(.degrees(135))
                       .frame(width: 100, height: 100)
                       .opacity(0.15)
                   
                   Circle()
                       .trim(from: 0.0, to: maxTrin(for: knob.level))
                       .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                       .foregroundColor(.accentColor)
                       .rotationEffect(.degrees(135))
                       .frame(width: 100, height: 100)
                   
                   Circle()
                       .foregroundColor(.accentColor)
                       .frame(width: 10, height: 10)
               }
           }
       }
}


struct KnobView_Previews: PreviewProvider {
    static var previews: some View {
        KnobView(knob: Knob(name: "Drive", level: 0.5))
            .preferredColorScheme(.dark)
    }
}
