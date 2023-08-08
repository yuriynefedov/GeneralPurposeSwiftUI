//
//  Post.swift
//  CarouselList (iOS)
//
//  Created by Manuel Duarte on 26/2/22.
//

import SwiftUI

public protocol CarouselItem: Identifiable {
    var id: String { get }
    var view: AnyView { get }
}


// Post Model And Sample Data...
public struct SimpleCarouselTile: CarouselItem {
    var id: String = UUID().uuidString
    var color: Color
    var text: String
    
    var view: AnyView {
        AnyView(
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(color)
                Text(text)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
        )
    }
    
    static let examples: [SimpleCarouselTile] = [
        .init(color: .red, text: "Red"),
        .init(color: .orange, text: "Orange"),
        .init(color: .yellow, text: "Yellow"),
        .init(color: .green, text: "Green"),
        .init(color: .cyan, text: "Cyan"),
        .init(color: .blue, text: "Blue"),
        .init(color: .purple, text: "Purple"),
    ]
}
