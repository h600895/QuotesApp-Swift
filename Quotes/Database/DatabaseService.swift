//
//  DatabaseService.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 07/04/2023.
//

import Foundation
import Firebase

class DatabaseService: ObservableObject {
    
    @Published var list = [Quote]()
    let adresse:String = "/quotes"
    static let shared = DatabaseService() //Singleton
    
    func readDatabase() {
        
        // Get a referance to the database
        let db = Firestore.firestore()
        
        db.collection(self.adresse).getDocuments { snapshot, error in
            
            //Checking for error
            if error == nil {
                //No error occured
                if let snapshot = snapshot {
                    
                    // Updating the list property in the main thread
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { entry in
                            // Create a Quote item from each entry in the document
                            return Quote(
                                id: entry.documentID,
                                quote: entry["quote"] as? String ?? "",
                                author: entry["author"] as? String ?? "",
                                date: entry["date"] as? String ?? "",
                                writer: entry["writer"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                print("An error occured: \(error!)")
            }
        }
        
    }
    
    func writeDatabase(data: Dictionary<String, String>) {
        
        // Get a referance to the database
        let db = Firestore.firestore()
        
        // Trying th write to firebase and catching the error message if aparing
        db.collection(self.adresse).addDocument(data: data) { error in
            //Check for error
            if error == nil {
                // No error
                
                // Call get data from the database
                self.readDatabase()
            }
            else {
                // Handle the error
                print("An error occured: \(error!)")
            }
        }
    }
    
    func editDatabase(id: String, data: Dictionary<String, String>) {
        let db = Firestore.firestore()
        
        db.collection(self.adresse).document(id).setData(data) { error in
            // Checking for error
            if error == nil {
                // No error
                
                // Calling get data from the database
                self.readDatabase()
            } else {
                //Handle the error
                print("An error occured: \(error!)")
            }
            
        }
        
        /*db.collection(self.adress).document(id).setData(data.getMap()) { error in
         //Check for error
         if error == nil {
         // No error
         
         // Call get data from the database
         self.readDatabase()
         }
         else {
         // Handle the error
         print("An error occured: \(error!)")
         }
         }*/
        
        
        print("Editing in the datbase \(quote.quote)")
        
        
    }
    
    
    
    func deleteDatabase(id: String) {
        
        let db = Firestore.firestore()
        
        print("Delting from the datbase")
        db.collection(self.adresse).document(id).delete() { error in
            // Checking for error
            if error == nil {
                // No error
                
                // Calling get data from the database
                self.readDatabase()
                print("Success delete from database")
            } else {
                //Handle the error
                print("An error occured: \(error!)")
            }
        }
        
        
    }
    
    
    func localData() -> [Quote] {
        
        var quotes = [Quote]()
        
        for i in 1...10 {
            
            quotes.append(Quote(id: "\(i)", quote: "Dette er en setning med quote nr \(i)", author: "Authro \(i)", date: "10.04.2023", writer: "Writer \(i)"))
            
            
        }
        return quotes
        
    }
    
    
}
