//
//  RegisterView.swift
//  sampleRealm
//
//  Created by kazuya on 2020/12/25.
//

import SwiftUI

struct RegisterView: View {
    
    @State var firstname = ""
    @State var lastname = ""
    @State var age = ""
    
    @ObservedObject var editVM = EditViewModel()
    
    // モーダルを閉じるときの制御に使用するプロパティ
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                  Text("閉じる")
                }
            }.padding()
            
            Spacer()
            
            VStack {
                TextField("firstname", text: $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("lastname", text: $lastname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("age", text: $age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    // 登録
                    let user = User()
                    user.id = UUID().uuidString
                    user.firstname = firstname
                    user.lastname = lastname
                    user.age = Int(age)!
                    editVM.create(user)
                }) {
                    Text("登録")
                }
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $editVM.alert.flag) {
                    Alert(title: Text(editVM.alert.title),
                          message: Text(editVM.alert.message),
                          dismissButton: .default(Text("OK")){
                            self.presentationMode.wrappedValue.dismiss()
                          })
                }
            }.padding()
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
