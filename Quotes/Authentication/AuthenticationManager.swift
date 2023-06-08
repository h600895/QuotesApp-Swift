//
//  AuthenticationManager.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 04/06/2023.
//

import Foundation
import FirebaseAuth

struct DBUser {
    let uid: String
    let email: String?
    let photoUrl: String?
    let displayName: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.displayName = user.displayName
        
    }
}

final class AuthenticationManager  {
    
    // Signleton - et delt objekt av denne klassen
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> DBUser {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return DBUser(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
 
    
}

// MARK: SIGN IN EMAIL
extension AuthenticationManager {
    
    func createUser(email: String, password: String) async throws -> DBUser {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return DBUser(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> DBUser {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return DBUser(user: authDataResult.user)
    }
}

// MARK: SIGN IN SSO
extension AuthenticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> DBUser {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> DBUser {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return DBUser(user: authDataResult.user)
    }
}
