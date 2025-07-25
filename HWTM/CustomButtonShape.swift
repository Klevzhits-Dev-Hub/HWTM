//
//  CustomButtonShape.swift
//  HWTM
//
//  Created by Дарья on 25.07.2025.
//

import SwiftUI

struct CustomButtonView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CustomButtonShape()
                    .frame(width: geometry.size.width * 0.9, height: 56)
                    .overlay {
                        CustomButtonShape()
                            .stroke(Color.red, lineWidth: 3)
                    }
            }
        }
    }
}
    
struct CustomButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        
        let h = rect.height
        let w = rect.width
        
        var path = Path()

        path.move(to: CGPoint(x: w * 0, y: h * 28/56))
        path.addLine(to: CGPoint(x: w * 12/311, y: h * 10/56))
        path.addQuadCurve(to: CGPoint(x: w * 24/311, y: h * 4/56), control: CGPoint(x: w * 18/311, y: h * 4/56))
        path.addLine(to: CGPoint(x: w * 287/311, y: h * 4/56))
        path.addQuadCurve(to: CGPoint(x: w * 299/311, y: h * 10/56), control: CGPoint(x: w * 293/311, y: h * 4/56))
        path.addLine(to: CGPoint(x: w * 311/311, y: h * 28/56))
        path.addLine(to: CGPoint(x: w * 299/311, y: h * 46/56))
        path.addQuadCurve(to: CGPoint(x: w * 287/311, y: h * 52/56), control: CGPoint(x: w * 293/311, y: h * 52/56))
        path.addLine(to: CGPoint(x: w * 24/311, y: h * 52/56))
        path.addQuadCurve(to: CGPoint(x: w * 12/311, y: h * 46/56), control: CGPoint(x: w * 18/311, y: h * 52/56))
        path.addLine(to: CGPoint(x: w * 0, y: h * 28/56))
        path.closeSubpath()
        return path
    }
}


#Preview {
    CustomButtonView()
}
