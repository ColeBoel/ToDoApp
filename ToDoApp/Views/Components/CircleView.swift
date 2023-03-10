//
//  CircleView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/9/23.
//

import SwiftUI


struct CircleView: View {
    @State var isFilled: Bool
    
    var body: some View {
        
        ZStack{
            Circle()
                .foregroundColor(isFilled ? .black : .white)
                .frame(width: 18, height: 18)
                .onTapGesture {
                    isFilled.toggle()
                }
                .zIndex(1)
            
            Circle()
                .strokeBorder(Color.black,lineWidth: 3)
                .frame(width: 30, height: 30)
                
                
        }
       
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(isFilled: true)
    }
}
