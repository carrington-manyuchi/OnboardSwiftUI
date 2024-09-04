//
//  Profile.swift
//  OnboardSwiftUI
//
//  Created by Manyuchi, Carrington C on 2024/09/04.
//

import SwiftUI

struct Profile: View {
    /*App Storage*/
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text(currentUserName ?? "Name")
                Text("This user is \(currentUserAge ?? 0) years old!")
                Text("Their gender is \(currentUserGender ?? "unknown")")
                Text("Sign out")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        signOut()
                    }
            }
                    .font(.title)
                    .foregroundStyle(.purple)
                    .padding()
                    .padding(.vertical, 40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
        }
    }
    
    
    func signOut() {
        currentUserAge = nil
        currentUserName = nil
        currentUserGender = nil
        withAnimation(.spring) {
            currentUserSignedIn = false
        }
    }
}

#Preview {
    Profile()
}
