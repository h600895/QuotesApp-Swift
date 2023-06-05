//
//  Database.swift
//  Quotes
//
//  Created by Siri Kaarvik Slyk on 06/04/2023.
//

import Foundation
import Firebase

class DatabaseServiceOld {
    
    var list = [Quote]()
    let db = Firestore.firestore()
    
    /*func writeQuote(quote: Quote) {
     db.collection("quotes").addDocument(data: quote.getMap());
     }*/
    
    
    
    
    
    func writeToDatabase(quote: Quote) {
        db.collection("quotes").document(quote.id).setData(quote.getMap(), merge: true)
        
    }
    
    func readFromDatabase() {
        db.collection("quotes").getDocuments { snapshot, error in
            
            //Check for error
            if error == nil {
                // No Errors
                
                if let snapshot = snapshot {
                    
                    // Update the list proterty in the main thread
                    DispatchQueue.main.async {
                        //Get all the documents and reate Todos
                        self.list = snapshot.documents.map { entry in
                            
                            //Create a todo item from each entry in the document
                            return Quote(id: entry.documentID,
                                         quote: entry["quote"] as? String ?? "",
                                         author: entry["author"] as? String ?? "",
                                         date: entry["date"] as? String ?? "",
                                         writer: entry["writer"] as? String ?? "")
                        }
                    }
                }
                
                
            }
            else {
                //Handle the error
            }
        }
    }
    
    
    //db.collection("quotes").addDocument(data: []);
    
    /*db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
     //Check for error
     if error == nil {
     // No error
     
     // Call get data from the database
     self.getData()
     }
     else {
     // Handle the error
     }
     }*/
}
