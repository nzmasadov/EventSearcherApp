//
//  SignUpViewModel.swift
//  presentation
//
//  Created by Nazim Asadov on 18.09.22.
//

import Foundation
import Firebase


public class SignUpViewModel {
    
    func createAccount(email: String, password: String, successfulHandler: @escaping ((Bool) -> Void)) {
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let _ = self else {return}
            guard error == nil else {
                print("Account creation failed")
                return
            }
            
            print("nzm create account success")
        }
    }
}
