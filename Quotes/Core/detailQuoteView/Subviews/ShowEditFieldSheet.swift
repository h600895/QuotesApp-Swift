//
//  ShowEditFieldSheet.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 12/04/2023.
//

import SwiftUI

struct ShowEditFieldSheet: View {
    
    @State var inputFieldData: String
    var quote: Quote
    var db: DatabaseService
    @Binding var closeEditView: Bool
    //@Binding closeEditView: Bool
    
    var body: some View {
        VStack {
            HStack {
                
                TextField("", text: $inputFieldData, axis: .vertical).foregroundColor(Color("fontPriColor"))
                        //.background(Color.green)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(20)
                
            }
            Button {
                var newData = quote.getMap()
                newData["quote"] = inputFieldData
                db.editDatabase(id: quote.id, data: newData)
                closeEditView.toggle()
                
                    
            } label: {
                Text("Edit").foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
            }

        }.background(Color("boxColor"))
            .cornerRadius(10)
            .padding()
            .shadow(radius: 10)
            .presentationDetents([.fraction(0.4)])
    }
}

/*struct ShowEditFieldSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShowEditFieldSheet(inputFieldData: "Dette er en test setning, og enda en får å se hvordan dette ser ut")
    }
}
*/
