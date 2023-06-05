//
//  QuotesView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 07/04/2023.
//

import SwiftUI

struct QuotesView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        QuoteViewModel(showSignInView: $showSignInView)
        
    }
}

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView(showSignInView: .constant(false))
    }
}
