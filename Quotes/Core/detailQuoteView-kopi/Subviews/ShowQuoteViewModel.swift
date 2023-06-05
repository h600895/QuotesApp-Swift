//
//  ShowQuoteViewModel.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 04/06/2023.
//

import SwiftUI

struct ShowQuoteViewModel: View {
    
    var quote: Quote
    var db = DatabaseService()
    @State var quoteInput: String = "Dette er en placeholder"
    @State var authorInput: String = ""
    @State var showInfoSheet: Bool = false
    @State var showingQuoteSheet: Bool = false
    
    
    var databaseReferance: DatabaseService
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("quoteViewBackground").ignoresSafeArea();
                VStack{
                    HStack{
                        Spacer()
                    }
                    
                    Spacer()
                    Text("‘‘" + quote.quote + "’’")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30).bold())
                        .padding(.all, 20)
                    
                    Text(quote.author).font(.system(size: 20))
                    
                    Spacer()
                    
                }
            }
            
        }
        .navigationBarItems(trailing: Button(action: {
            showInfoSheet.toggle()
            
        }) {
            Image(systemName: "ellipsis.circle")
                .foregroundColor(Color("logoColor"))
                .font(.system(size: 18))
            
            
            
        }.sheet(isPresented: $showInfoSheet) {
            VStack{
                HStack {
                    Text("Information").font(.system(size: 28).bold()).padding(.top, 10).padding(.horizontal, 20)
                    Spacer()
                }
                
                HStack {
                    Text("Writer: " + quote.writer).padding(.top, 10).padding(.horizontal, 20)
                    Spacer()
                }
                HStack {
                    Text("Date: " + String(quote.date.prefix(10))).padding(.top, 10).padding(.horizontal, 20)
                    Spacer()
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
                            showInfoSheet.toggle()
                            
                        },
                              secondaryButton: .cancel()
                              
                        )}
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    
                }
                
                
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.hidden)
        }
                            
        )
    }
}

/*struct ShowQuoteViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ShowQuoteViewModel()
    }
}*/
