//
//  QuoteBoxView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 06/04/2023.
//

import SwiftUI

let testQuote = Quote(id: "10000", quote: "Dette er en test", author: "Test", date: "28.04.2023", writer: "Test1")

struct QuoteBoxView: View {
    
    let quote: Quote
    //@State var isWriter = false
    
    init(quote: Quote) {
        self.quote = quote
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(quote.quote)
            
            Spacer()
            
            HStack {
                
                Spacer()
                Text("-" + quote.author)
                
            }
            
        }
        .padding()
        .background(Color("boxColor"))
        .cornerRadius(20)
        .padding(.horizontal, 15).padding(.vertical, 10)
        .shadow(radius: 10)
    }
}

struct QuoteBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteBoxView(quote: testQuote)
    }
}
