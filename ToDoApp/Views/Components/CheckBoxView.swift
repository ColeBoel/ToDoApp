//
//  CheckBoxView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    
    
    var body: some View {
        if isChecked{
            Image(systemName: "checkmark.square.fill")
        } else {
            Image(systemName: "square")
        }
    }
}

