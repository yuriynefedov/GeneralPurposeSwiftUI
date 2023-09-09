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
    
    public init(style: Style, progress: Double) {
        self.style = style
        self.progress = progress
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
                .stroke(Self.primaryColor, lineWidth: stroke)
                .foregroundColor(.clear)
            Sector(percentage: progress)
        }
        .frame(maxWidth: maxSize, maxHeight: maxSize)
        .foregroundColor(Self.primaryColor)
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
                    .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: height/2)
                    .frame(height: height)
                    .frame(width: min(maxWidth, proxy.size.width)*progress)
                    .foregroundColor(.primary)
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
    private static var primaryColor: Color { .primary }
    private static var secondaryColor: Color { .secondary }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(style: .cirular, progress: LoadingView.defaultProgress)
    }
}
