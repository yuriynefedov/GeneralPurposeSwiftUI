//
//  SnapCarousel.swift
//  CarouselList (iOS)
//
//  Created by Manuel Duarte on 26/2/22.
//

import SwiftUI


// To for acepting List....
public struct SnapCarousel: View {
    var list: [any CarouselItem]
    
    // Properties....
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    public init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [any CarouselItem]) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
    }
    
    // Offset...
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    public var body: some View {
        GeometryReader{ proxy in
            let width = proxy.size.width - ( trailingSpace - spacing )
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack (spacing: spacing) {
                ForEach(list, id: \.id) { item in
                    item.view
                        .frame(width: proxy.size.width - trailingSpace)
                }

            }
            
            // Spacing will be horizontal padding...
            .padding(.horizontal, spacing)
            // Setting only after 0th index...
            .offset(x: (CGFloat(currentIndex) * -width) + ( adjustMentWidth ) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        // Updating Current Index....
                        let offsetX = value.translation.width
                        
                        // Were going to convert the tranlsation into progreess ( 0 - 1 )
                        // and round the value...
                        // based on the progress increasing or decreasing the currentInde....
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                    
                        // setting max....
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                        // updating index....
                        currentIndex = index
                    })
                    .onChanged({ value in
                        // updating only index...
                        
                        // Updating Current Index....
                        let offsetX = value.translation.width
                        
                        // Were going to convert the tranlsation into progreess ( 0 - 1 )
                        // and round the value...
                        // based on the progress increasing or decreasing the currentInde....
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                    
                        // setting max....
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                    })
            )
            
        }
        // Animatiing when offset = 0
        .animation(.easeInOut, value: offset == 0)
        
    }

}
