//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var vm : TaskViewModel
    
    @State var all = true
    @State var completed = false
    @State var incomplete = false

    @State var due = true
    @State var created = false
    
    @State var asc = true
    @State var desc = false


    
    
    var body: some View {
    
        VStack{
            Text("Settings")
                .font(.title)
                .bold()
                .padding()
            
            HStack{
                VStack(alignment:.leading, spacing: 25){
                    
                Text("Filters")
                        .bold()
                        .font(.title3)
                   
                    Toggle("All", isOn: $all)
                      .onChange(of: all) { newValue in
                          if newValue {
                              completed = false
                              incomplete = false
                          }
                      }
                      .toggleStyle(CheckToggleStyle())
                  
                  Toggle("Completed", isOn: $completed)
                      .onChange(of: completed) { newValue in
                          if newValue {
                              all = false
                              incomplete = false
                          }
                      }
                      .toggleStyle(CheckToggleStyle())
                  
                  Toggle("Incomplete", isOn: $incomplete)
                      .onChange(of: incomplete) { newValue in
                          if newValue {
                              all = false
                              completed = false
                          }
                      }
                      .toggleStyle(CheckToggleStyle())
                
                    
                //SORT BY
                Text("Sort By")
                        .bold()
                        .font(.title3)
                
                Toggle("Due", isOn: $due)
                    .onChange(of: due) { d in
                        created = !d
                    }
                    .toggleStyle(CheckToggleStyle())
                
                Toggle("Created", isOn: $created)
                    .onChange(of: created) { e in
                        due = !e
                    }
                    .toggleStyle(CheckToggleStyle())
                  
                    
                    
                //DATE DIRECTION
                Text("Sort Date Direction")
                        .bold()
                        .font(.title3)
                Toggle("Ascending", isOn: $asc)
                    .onChange(of: asc) { f in
                        desc = !f
                    }
                    .toggleStyle(CheckToggleStyle())
                
                Toggle("Descending", isOn: $desc)
                    .onChange(of: desc) { g in
                        asc = !g
                    }
                    .toggleStyle(CheckToggleStyle())
                    
                    
                }
                Spacer()
            }
            .padding(25)
            
            HStack{
                Button(action: {
                    DispatchQueue.main.async {
                        vm.all = all
                        vm.completed = completed
                        vm.incomplete = incomplete
                        vm.due = due
                        vm.created = created
                        vm.ascending = asc
                        vm.descending = desc
                        
                        vm.refresh()
                    }
                  
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .padding()
                        .frame(width: 100)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                        
                }
            }
            .padding(30)
            Spacer()
          
        }
        .onAppear{
            all = vm.all
            completed = vm.completed
            incomplete = vm.incomplete
            due = vm.due
            created = vm.created
            asc = vm.ascending
            desc = vm.descending
        }
        //End Main vstack
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vm: TaskViewModel())
    }
}
