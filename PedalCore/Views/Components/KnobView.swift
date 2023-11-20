//
//  KnobView.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

struct KnobView: View {
  
    @Binding var knob: Knob
    
    @State var dragOffset: CGSize = .zero
    
    let sensitivity: Float = 0.00005
    
    private func maxTrin(for level: Float) -> CGFloat {
        return CGFloat(0.75 * level)
    }
    
    private var roundedLevel: Int {
        Int(round(knob.level * 100))
    }
    
    private func dragAction(value: CGSize) {
        knob.level += sensitivity * Float(value.width)
        knob.level -= sensitivity * Float(value.height)
        
        // Limita o valor de level entre 0.0 e 1.0
        knob.level = min(1.0, max(0.0, knob.level))
    }
    
    private func dragEnded() {
        dragOffset = .zero
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text(knob.name)
                .font(.subheadline)
                .foregroundStyle(.primary)
                        
            ZStack {
                Circle()
                    .trim(from: 0.0, to: maxTrin(for: 1))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(135))
                    .frame(width: 80, height: 80)
                    .opacity(0.15)
                
                
                Circle()
                    .trim(from: 0.0, to: maxTrin(for: knob.level))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(135))
                    .frame(width: 80, height: 80)
                
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 8, height: 8)
                
                Text("\(roundedLevel) %")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .offset(y: 40)

            }
            
        }
        .gesture(
            DragGesture().onChanged { value in
                self.dragAction(value: value.translation)
            }.onEnded { _ in
                self.dragEnded()
            }
        )
    }
}


struct KnobView_Previews: PreviewProvider {
    static var previews: some View {
        KnobView(knob: .constant(Knob(name: "Drive", level: 0.5)))
    }
}
