//
//  PointingHandCursor.swift
//  ClipBoardWatcher
//
//  Created by Thanmay Prebeesh on 23/08/2026.
//

import SwiftUI
import AppKit

struct PointingHandCursor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onHover { hovering in
                if hovering {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
    }
}

extension View {
    func pointingHandCursor() -> some View {
        modifier(PointingHandCursor())
    }
}
