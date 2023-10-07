//
//  KnobView.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI


struct KnobView: View {
    
    @State var isGestureEnabled: Bool
    
    @Binding var knob: Knob
    
    @State var dragOffset: CGSize = .zero
    
    let sensitivity: Float = 0.00005

    
    private func maxTrin(for level: Float) -> CGFloat {
        return CGFloat(0.75 * level)
    }
    
    private var roundedLevel: Int {
        Int(round(knob.level * 100))
    }
    
    func dragAction(value: CGSize) {
        knob.level += sensitivity * Float(value.width)
        knob.level -= sensitivity * Float(value.height)
        
        // Limita o valor de level entre 0.0 e 1.0
        knob.level = min(1.0, max(0.0, knob.level))
    }
    
    func dragEnded() {
        dragOffset = .zero
    }
    
    var body: some View {
        VStack {
            Text(knob.parameter)
                .font(.subheadline)
            
            Text("\(roundedLevel) %")
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
        .gesture(
            // Use um gesto condicional com base na variável de estado
            isGestureEnabled ?
            DragGesture().onChanged { value in
                self.dragAction(value: value.translation)
            }.onEnded { _ in
                self.dragEnded()
            } : nil
        )
    }
}


struct KnobView_Previews: PreviewProvider {
    static var knob = Knob(parameter: "Drive", level: 0.5)
    static var previews: some View {
        KnobView(isGestureEnabled: true, knob: .constant(knob), dragOffset: .zero)
    }
}
