//
//  ListView.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/22.
//

import SwiftUI
import RealmSwift

struct SwitchView: View {
    
    @ObservedObject var editVM = EditViewModel()
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            if editVM.users.count == 0 {
                EmptyStateView(isPresented: self.$isPresented)
            } else {
                UserListView(isPresented: self.$isPresented,
                             users: editVM.users)
            }
        }
    }
}

struct UserListView: View {
    
    @Binding var isPresented: Bool
    var users: Results<User>
    
    var body: some View {
        List {
            ForEach(users) { (user: User) in
                NavigationLink(destination: EditView(user: user)) {
                    HStack {
                        Text("\(user.firstname)")
                        Text("\(user.lastname)")
                        Text("\(user.age)")
                    }
                }
            }
        }.listStyle(PlainListStyle())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action:{
                                    self.isPresented = true
                                }){
                                    Image(systemName: "person.badge.plus.fill")
                                }
            .sheet(isPresented: self.$isPresented) {
                RegisterView()
            }
        )
    }
}


struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
    }
}
