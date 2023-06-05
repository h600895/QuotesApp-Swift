//
//  QuotesView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 07/04/2023.
//

import SwiftUI

struct QuotesView: View {
    init() {
        self.updateDataList()
        
        
    }
    
    @State var newQuoteSheet: Bool = false
    @State var showQuoteSheet: Bool = false
    
    let db = DatabaseService()
    
    @ObservedObject var data = DatabaseService()
    
    
    
    var body: some View {
        
        
        
        /*let quotes = [getQuote(), getQuote(), getQuote(), getQuote(), getQuote(), getQuote(), getQuote()]*/
        let backgroundColor = Color("backgroundColor").ignoresSafeArea()
        
        NavigationView {
            ZStack {
                backgroundColor
                
                
                List(content: {
                    //ScrollView(.vertical, showsIndicators: false, content:  {
                    
                    //LazyVStack {
                    
                    ForEach(data.list) { quote in
                        
                        
                        Section {
                            VStack {
                                
                                Text(quote.quote).multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Text("-" + quote.author)
                                    
                                }
                            }.padding(.vertical, 10)
                            .cornerRadius(10)
                        }
                        /*Button {
                         
                         showQuoteSheet.toggle()
                         
                         } label: {
                         QuoteBoxView(quote: quote)
                         }
                         .sheet(isPresented: $showQuoteSheet) {
                         ShowQuoteSheetView(quote: quote)
                         }
                         .foregroundColor(Color("fontPriColor"))*/
                    }.onDelete(perform: self.deleteQuote(at:))
                    //}
                    
                }).scrollContentBackground(.hidden)
                
                
                //.background(backgroundColor)
                
                    .refreshable {
                        
                        //self.updateDataList()
                    }
            }.listStyle(InsetGroupedListStyle())
        }
    }
    func updateDataList() {
        print("getting data")
        data.readDatabase()
    }
    func test() {
        print("test")
    }
    func deleteQuote(at delete: IndexSet) {
        print(delete.first!)
    }
}

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
