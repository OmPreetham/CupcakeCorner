//
//  ValidationView.swift
//  CupcakeCorner
//
//  Created by Om Preetham Bandi on 5/30/24.
//

import SwiftUI

struct ValidationView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.isEmpty || email.isEmpty
    }
    
    var body: some View {
        List {
            Section {
                Group {
                    TextField("Enter Username", text: $username)
                    TextField("Enter Email", text: $email)
                }
            }
            Section {
                Group {
                    Button("Create Account") {
                        print("Creating account..")
                    }
                    .disabled(disableForm)
                }
            }
        }
    }
}

#Preview {
    ValidationView()
}
