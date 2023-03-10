//
//  MainPageView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct MainPageView: View {
    
    @ObservedObject var vm = TaskViewModel()
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                TitleView(vm: vm)
                 
                ScrollView{
                    
                 if let tasks = vm.tasks {
                     
                     ForEach(tasks, id: \.id) { task in
                     
                         CardView(isChecked: (task.completed != 0), task: task, vm: vm)
                         
                         }
                     }// End If
                    
                 }.background(.clear)
                  .refreshable{
                        vm.refresh()
                    }

                 
             }
             .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.90, alignment: .top)
             .onAppear{
                 vm.refresh()
             }
             
         }
            
            
        }
        
      

}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
