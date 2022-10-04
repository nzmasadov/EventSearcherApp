//
//  LoginViewModel.swift
//  presentation
//
//  Created by Nazim Asadov on 18.09.22.
//

import Foundation
import Firebase

public class LoginViewModel {
    
    func signIn(email: String, password: String, succesfulHandler: @escaping ((Bool) -> Void)) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                succesfulHandler(false)
                return
            }
            succesfulHandler(true)
        }
    }
}
