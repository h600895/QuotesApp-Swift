//
//  ShowQuoteSheetView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 07/04/2023.
//

import SwiftUI

let currentWriter = "Me"


struct ShowQuoteSheetView: View {
    
    let quote: Quote
    
    
    init(quote: Quote) {
        self.quote = quote
        
    }
    
    
    
    
    
    var body: some View {
        let isVisible: Bool = quote.writer == currentWriter
        
        VStack {
            QuoteBoxView(quote: quote)
            
            Button(action: {print("\(currentWriter) \(quote.writer) = \(isVisible)")}, label: {Text("Delete")})
                .frame(height: isVisible ? nil : 0)
                .disabled(!isVisible)

            
                Button {
                    print("\(currentWriter) \(quote.writer) = \(isVisible)")
                    print(quote.quote)
                } label: {
                    Text("Show state")
                }
            
        }
    }
    
}

let quote: Quote = Quote(id: "123456789", quote: "Det viktigste er ikke å delta, men å vinne", author: "Siri", date: "07.04.2023", writer: "Me")

struct ShowQuoteSheetView_Previews: PreviewProvider {

    static var previews: some View {
        ShowQuoteSheetView(quote: quote)
    }
}

