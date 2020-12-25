//
//  EditView.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/25.
//

import SwiftUI

struct EditView: View {
    
    var user: User
    
    @State var firstname = ""
    @State var lastname = ""
    @State var age = ""
    @State var showAlert = false
    
    @ObservedObject var editVM = EditViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("firstname", text: $firstname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("lastname", text: $lastname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("age", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                Button(action: {
                    // 削除
                    editVM.delete(id: self.user.id)
                }) {
                    Text("削除")
                }
                .frame(width: 100, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: self.$editVM.alert.flag) {
                    Alert(title: Text(self.editVM.alert.title),
                          message: Text(self.editVM.alert.message),
                          dismissButton: .default(Text("OK")){
                            self.presentationMode.wrappedValue.dismiss()
                          })
                }
                
                Button(action: {
                    // 更新
                    let userInfo = User()
                    userInfo.firstname = self.firstname
                    userInfo.lastname = self.lastname
                    userInfo.age = Int(self.age)!
                    editVM.update(id: self.user.id, userInfo)
                }) {
                    Text("更新")
                }
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: self.$editVM.alert.flag) {
                    Alert(title: Text(self.editVM.alert.title),
                          message: Text(self.editVM.alert.message),
                          dismissButton: .default(Text("OK")){
                            self.presentationMode.wrappedValue.dismiss()
                          })
                }
            }
        }.padding()
        .onAppear() {
            print(user)
            self.firstname = user.firstname
            self.lastname = user.lastname
            self.age = user.age.description
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(user: User(value: 0))
    }
}
