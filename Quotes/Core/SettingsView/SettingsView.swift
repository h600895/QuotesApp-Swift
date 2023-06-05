//
//  SettingsView.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 04/06/2023.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        List{
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
