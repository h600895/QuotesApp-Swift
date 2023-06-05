//
//  AddQuoteView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 12/04/2023.
//

import SwiftUI

@MainActor
final class AddQuoteViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
}

struct AddQuoteView: View {
    
    var db: DatabaseService
    @StateObject private var viewModel = AddQuoteViewModel()
    //@Binding var newQuoteSheet: Bool
    @Binding var newQuoteSheet: Bool
    
    @State var quoteInputField = ""
    @State var authorInputField = ""
    @State private var dateInputField = Date()
    @State private var isAlertShowing = false
    
    let username: String = ""
    
    /*if (viewModel.user?.displayName != nil) {
        username = viewModel.user!.displayName
    } else{
        username = ""
    }*/
    
    
    
    //let user = viewModel.loadCurrentUser()
    

    
            
    
    
    var body: some View {
        VStack {
            Form {
                TextField("Quote", text: $quoteInputField, axis: .vertical)
                TextField("Author", text: $authorInputField, axis: .vertical)
                DatePicker("Date", selection: $dateInputField)
                
            }
            Button {
                if !quoteInputField.elementsEqual("") && !authorInputField.elementsEqual("") {

                    
                    db.writeDatabase(data: ["quote": quoteInputField, "author": authorInputField, "date": "\(dateInputField)", "writer": "Siri"])
                    newQuoteSheet.toggle()
                        
                } else {
                    isAlertShowing.toggle()
                    print("Missing data in field")
                }
                
            } label: {
                Text("Create quote")
            }

        }.alert(isPresented: $isAlertShowing) {
            Alert(title: Text("Error"), message: Text("There is missing data in field(s)"), dismissButton: .cancel())}
    }
}

/*struct AddQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuoteView(db: DatabaseService())
    }
}*/
