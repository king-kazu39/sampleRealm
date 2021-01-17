//
//  SwitchView.swift
//  sampleRealm
//
//  Created by kazuya on 2021/01/17.
//

import SwiftUI

struct EmptyStateView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("データがありません")
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

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(isPresented: .constant(false))
    }
}
