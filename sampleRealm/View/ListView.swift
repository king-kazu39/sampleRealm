//
//  ListView.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/22.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    
    @ObservedObject var editVM = EditViewModel()
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(editVM.users) { (user: User) in
                    if user.isInvalidated {
                        Text("データがありません")
                    } else {
                        NavigationLink(destination: EditView(user: user)) {
                            HStack {
                                Text("\(user.firstname)")
                                Text("\(user.lastname)")
                                Text("\(user.age)")
                            }
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
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
