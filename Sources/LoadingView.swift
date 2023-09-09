//
//  File.swift
//  
//
//  Created by Yuriy Nefedov on 09.09.2023.
//

import Foundation

//
//  ProgressView.swift
//  My Golf Skill
//
//  Created by Yuriy Nefedov on 09.09.2023.
//

import SwiftUI

public struct Sector: Shape {
    public var percentage: Double
    
    public func path(in rect: CGRect) -> Path {
        let startAngle: Angle = .degrees(-90)
        let endAngle: Angle = startAngle + .degrees(360 * percentage)
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

public struct LoadingView: View {
    public var style: Style = .spinner
    public var progress: Double = Self.defaultProgress
    public var primaryColor: Color = Self.defaultPrimaryColor
    public var secondaryColor: Color = Self.defaultSecondaryColor
    
    public init(
        style: Style,
        progress: Double,
        primaryColor: Color = Self.defaultPrimaryColor,
        secondaryColor: Color = Self.defaultSecondaryColor
    ) {
        self.style = style
        self.progress = progress
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    public var body: some View {
        switch style {
        case .spinner:
            ProgressView()
        case .cirular:
            circular(progress)
        case .bar:
            bar(progress)
        }
    }
    
    @ViewBuilder
    private func circular(_ progress: Double) -> some View {
        let maxSize: CGFloat = 50
        let stroke: CGFloat = 6
        ZStack {
            Circle()
                .stroke(primaryColor, lineWidth: stroke)
                .foregroundColor(.clear)
            Sector(percentage: progress)
        }
        .frame(maxWidth: maxSize, maxHeight: maxSize)
        .foregroundColor(primaryColor)
    }
    
    @ViewBuilder
    private func bar(_ progress: Double) -> some View {
        let maxWidth: CGFloat = 200
        let height: CGFloat = 4
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height/2)
                    .frame(height: height)
                    .frame(width: min(maxWidth, proxy.size.width))
                    .foregroundColor(secondaryColor)
                RoundedRectangle(cornerRadius: height/2)
                    .frame(height: height)
                    .frame(width: min(maxWidth, proxy.size.width)*progress)
                    .foregroundColor(primaryColor)
            }
        }
        .frame(maxWidth: maxWidth)
    }
}

extension LoadingView {
    public enum Style {
        case spinner
        case bar
        case cirular
    }
    public static var defaultProgress: Double { 0.66 }
    public static var defaultPrimaryColor: Color {
        .init(
            red: 0.612,
            green: 0.612,
            blue: 0.612
        )
    }
    public static var defaultSecondaryColor: Color {
        .init(
            red: 0.871,
            green: 0.871,
            blue: 0.871
        )
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(
            style: .cirular,
            progress: LoadingView.defaultProgress,
            primaryColor: .red
        )
    }
}
