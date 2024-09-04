//
//  OnboardingView.swift
//  OnboardSwiftUI
//
//  Created by Manyuchi, Carrington C on 2024/09/04.
//

import SwiftUI

struct OnboardingView: View {
    // Onboarding state:
    /*
     0 - Welcome Screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingState: Int = 0
    @State var name: String = ""
    @State var age: Double = 50
    @State var gender: String = ""

    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    
    /*App Storage*/
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false

    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            
            //content
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.green)
                }
            }
            
            //buttons
            VStack {
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        .alert(Text(alertTitle), isPresented: $showAlert) {}

    }
}

#Preview {
    OnboardingView()
        .background(Color.purple)
}

//MARK: - Components

extension OnboardingView {
    private var bottomButton: some View {
        Text(
            onboardingState == 0 ? "SIGN UP" :
            onboardingState == 3 ? "FINISH" :
              "NEXT"
        
        )
            .font(.headline)
            .foregroundStyle(.purple)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundStyle(.white)
            
            Text("Find your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay (
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y:5)
                        .foregroundStyle(.white)
                    , alignment: .bottom
                )
            Text("This is the #1 app for finding your match online!In this tutorial we are practising using Appstorage and other SwiftUI techniques.")
                .fontWeight(.medium)
                .foregroundStyle(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
            
            
            Text("Whats your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                
            TextField("Enter your name here...", text: $name)
                .font(.headline)
                .frame(height: 44)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    
    private var addAgeSection: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Whats your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Text("\(String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Slider(value: $age, in: 18...100, step: 1)
                .tint(.white)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    
    private var addGenderSection: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Whats your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Picker(selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Other").tag("Other")
            } label: {
                Text(gender.count > 1 ? gender : "Select a gender")
            }
            .foregroundStyle(.red)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .pickerStyle(.menu)
            
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

//MARK: - FUNCTIONS

extension OnboardingView {
    
   
        
        
    func handleNextButtonPressed() {
        
        
        // CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "Your name must be atleast 3 characters long 🥺")
                return
            }
            
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender before moving forward 🤨")
                return
            }
        default:
            break
        }
        
        //GO TO NEXT SECTION
        if onboardingState == 3 {
            // Sign in    
            signIn()
        } else {
            withAnimation(.spring) {
                onboardingState += 1
            }
        }
        
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring) {
            currentUserSignedIn = true
        }
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}
