//
//  NavigationBarView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI
import Foundation

typealias Action = () -> Void
typealias BoolAction = (Bool) -> Void

struct NavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String? = nil
    @State var titleColor: Color = .white
    @State var font: Font = .headline
    @State var leftImageSystemName: String = "line.horizontal.3"
    @State var leftImageColor: Color = .white
    @State var showAccessory: Bool = false
    @State var accessoryTitle: String = ""
    @State var accessoryImage: String = "trash"
    @State var accessoryColor: Color = .gray
    @State var leftAction: Action? = nil
    @State var rightAction: Action = {}
    @State var rightDestination: (any View)? = nil
    
    var body: some View {
        
        HStack {
            Image(systemName: leftImageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(leftImageColor)
                .frame(width: 30, height: 30, alignment: .center)
                .padding()
                .onTapGesture {
                    if let left = leftAction {
                        left()
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                  
                }
            
            Spacer()
            if let title = title {
                if title.lowercased() == "sign up" || title.lowercased() == "sign in" || title.lowercased() == "welcome"{
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                }else{
                    Text(title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 3)
                        .font(.title)
                        .bold()
                }
               
                
            } else {
                
            }
            Spacer()
            HStack {
                if !accessoryTitle.isEmpty && !showAccessory {
                    Text(accessoryTitle)
                        .foregroundColor(accessoryColor)
                    
                } else if !accessoryTitle.isEmpty && showAccessory {
                    Text(accessoryTitle)
                        .foregroundColor(accessoryColor)
                    Image(systemName: accessoryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding()
                        .foregroundColor(accessoryColor)
                        .onTapGesture {
                            rightAction()
                            
                        }
                } else {
                    if rightDestination != nil {
                        NavigationLink{
                            AnyView(rightDestination!)
                        }label: {
                            Image(systemName: accessoryImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding()
                                .foregroundColor(accessoryColor)
                                .opacity(showAccessory ? 1 : 0)
                        }
                    }else{
                        Image(systemName: accessoryImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding()
                            .foregroundColor(accessoryColor)
                            .opacity(showAccessory ? 1 : 0)
                            .onTapGesture {
                                rightAction()
                            }
                    }
                    
                }
            }
        }
        
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(0)
        .background(Color.clear.ignoresSafeArea())
    
    
    }
    
    
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
    }
}
