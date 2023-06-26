//
//  ValidatingForms.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct ValidatingForms: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("username", text: $username)
                TextField("email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ValidatingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingForms()
    }
}
