//
//  Quote.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 04/04/2023.
//

import Foundation

struct Quote: Identifiable {
    
    var id:String//:UUID = UUID()
    
    var quote:String    // The quote itself
    var author:String   // How said this quote
    var date:String     // Date this quote was said
    var writer:String   // How wrote this quote to the database
    
    func getMap() -> Dictionary<String, String> {
        return ["quote": self.quote,
                "author": self.author,
                "date": self.date,
                "write": self.writer]
    }
    
}
