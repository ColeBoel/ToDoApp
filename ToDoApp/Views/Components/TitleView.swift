//
//  TitleView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct TitleView: View {
    @ObservedObject var vm : TaskViewModel

    var body: some View {
        
        HStack{
            
            NavigationLink{
                
                SettingsView(vm: vm)
                
                } label: {
                    
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding()
                        .foregroundColor(.black)
                    
                }
            Spacer()
            Text("Task List")
                .font(.title)
                .bold()
                .padding()
            Spacer()
            NavigationLink{
                CreateView()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
                    .foregroundColor(.black)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.clear.ignoresSafeArea())
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(vm: TaskViewModel())
    }
}
