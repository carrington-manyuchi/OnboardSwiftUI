//
//  ContentView.swift
//  OnboardSwiftUI
//
//  Created by Manyuchi, Carrington C on 2024/09/04.
/// If user is signed in we shoe profile view else onboarding view

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.purple, Color.blue],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
           // .ignoresSafeArea()
            
            
            
            if currentUserSignedIn {
                Profile()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                OnboardingView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            }
        }
    }
}

#Preview {
    IntroView()
}
