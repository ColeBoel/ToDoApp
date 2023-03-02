//
//  IconViewModifier.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation
import SwiftUI

struct IconViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30)
            .padding()
            .foregroundColor(.black)
    }
}
