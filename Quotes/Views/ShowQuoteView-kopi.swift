//
//  ShowQuoteView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 09/04/2023.
//

import SwiftUI

let wuote = Quote(id: "10000", quote: "Dette er en test", author: "Test", date: "28.04.2023", writer: "Test1")



struct ShowQuoteView: View {
    
    var quote: Quote
    var db = DatabaseService()
    @State var quoteInput: String = "Dette er en placeholder"
    @State var authorInput: String = ""
    
    @State var showingQuoteSheet: Bool = false
    
    
    var databaseReferance: DatabaseService
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showDeleteAlert: Bool = false
    
    
    let pencilView: some View = Image(systemName: "pencil").resizable().frame(width: 20, height: 20)
    
    var body: some View {
        
        NavigationView {
            VStack{
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text(quote.quote)
                        //Spacer()
                        Button {
                            print(quote.quote)
                            showingQuoteSheet.toggle()
                        }
                    label: {
                        pencilView
                    }.foregroundColor(Color("logoColor"))
                            .sheet(isPresented: $showingQuoteSheet) {
                                ShowEditFieldSheet(inputFieldData: quote.quote, quote: quote, db: db, closeEditView: $showingQuoteSheet)
                            }
                    }
                    //Spacer()
                    HStack {
                        HStack {
                            Text("Writer " + quote.writer)
                        }
                        Spacer()
                        HStack {
                            Button {
                                print("Test")
                                
                            }
                        label: {
                            pencilView
                        }.foregroundColor(Color("logoColor"))
                            Text("-" + quote.author)
                            
                            
                        }
                    }
                }
                
                .padding()
                .background(Color("boxColor"))
                .cornerRadius(20)
                .padding(.horizontal, 15).padding(.vertical, 10)
                .shadow(radius: 10)
                
                VStack {
                    
                    /*Button {
                     var data = quote.getMap()
                     
                     // Hard coded for testing:
                     
                     data["quote"] = data["quote"].unsafelyUnwrapped + "This is the edited part"
                     
                     
                     
                     db.editDatabase(id: quote.id, data: data)
                     } label: {
                     Text("Edit")
                     .foregroundColor(Color.white)
                     .padding()
                     .padding(.horizontal, 10)
                     .background(Color.gray)
                     .cornerRadius(10)
                     
                     }*/
                    
                    
                }
              Spacer()
                Button {
                    // Må legge inn en allertbox her
                    //db.deleteDatabase(id: quote.id)
                    showDeleteAlert = true
                } label: {
                    Text("Delete").alert(isPresented: $showDeleteAlert) {
                        Alert(title: Text("Do you really want to delete this quote?"), primaryButton: .destructive(Text("Yes")) {
                            db.deleteDatabase(id: quote.id)
                            
                            databaseReferance.readDatabase()
                            
                        },
                              secondaryButton: .cancel()
                        )}
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    
                }
            }
        }
        
    }
    func dismissBackToView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ShowQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ShowQuoteView(quote: quote, databaseReferance: DatabaseService())
    }
}



/*
 
 .alert(isPresented: $showingQuoteAlert) {
 TextField("", text: $quoteInput, axis: .vertical)
 }
 
 
 
 */
