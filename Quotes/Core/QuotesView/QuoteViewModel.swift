//
//  QuoteViewModel.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 04/06/2023.
//

import SwiftUI

struct QuoteViewModel: View {
    @Binding var showSignInView: Bool

    @State var showDeleteAlert: Bool = false
    @State var newQuoteSheet: Bool = false
    @State var showQuoteSheet: Bool = false
    @State var showSettingsView: Bool = false
    @State var currentQuote: Quote?
    
    @ObservedObject var db = DatabaseService()
    
    
    init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
        self.updateDataList()
        
    }
    var body: some View {
        
        
        
        /*let quotes = [getQuote(), getQuote(), getQuote(), getQuote(), getQuote(), getQuote(), getQuote()]*/
        let backgroundColor = Color("backgroundColor").ignoresSafeArea()
        NavigationView() {
            
            ScrollView(.vertical, showsIndicators: false, content:  {
                
                LazyVStack {
                    
                    Section {
                        ForEach(db.list) { quote in
                            NavigationLink(destination: ShowQuoteView(quote: quote, databaseReferance: db)) {
                                
                                QuoteBoxView(quote: quote)
                                
                            }.foregroundColor(Color("fontPriColor"))
                        }
                    } header: {
                        
                        HStack {
                            Text("Quotes")
                                .foregroundColor(Color("logoColor"))
                                .font(Font.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                                newQuoteSheet.toggle()
                                
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("logoColor"))
                                    .font(.system(size: 25))
                                
                                
                                
                            }.sheet(isPresented: $newQuoteSheet) {
                                AddQuoteView(db: db, newQuoteSheet: $newQuoteSheet)
                                    .presentationDetents([.medium, .large])
                                    .presentationDragIndicator(.hidden)
                            }.padding(.horizontal, 15)
                            
                            NavigationLink(destination: SettingsView(showSignInView: $showSignInView)) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(Color("logoColor"))
                                    .font(.system(size: 25))
                            }
                        }.padding(.horizontal, 20)
                    }
                }
            }).background(backgroundColor)
        }
        .refreshable {
            self.updateDataList()
        }
        .accentColor(Color("logoColor"))
    }
    func updateDataList() {
        db.readDatabase()

    }
}

struct QuoteViewModel_Previews: PreviewProvider {
    static var previews: some View {
        QuoteViewModel(showSignInView: .constant(false))
    }
}


