//
//  SafeResultView.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI

struct SafeResultView: View {
    @State private var goToHome = false
    var body: some View {
        NavigationStack{
            ZStack {
                
                // Background
                Color(red: 14/255, green: 30/255, blue: 38/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    
                    Spacer()
                    
                    // Icon
                    Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(Color(red: 72/255, green: 170/255, blue: 155/255))
                        .offset(x : 13)
                    
                    // Title
                    Text("safe")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    
                    // WHY
                    GlassInfoCard(
                        title: "Why",
                        points: [
                            "Caller didn’t ask for OTP or passwords",
                            "No attempts to scare or rush you",
                            "No sensitive information requested"
                        ]
                    )
                    
                    // WHAT SHOULD I DO
                    GlassInfoCard(
                        title: "What should i do",
                        points: [
                            "You’re safe — no action needed",
                            "Just continue as usual"
                        ]
                    )
                    
                    Spacer()
                    
                    NavigationLink {
                        HomeView()
                         .navigationBarBackButtonHidden(true)
                    } label: {
                        LiquidGlassButton(
                            title: "Got it",
                            systemIcon: nil,
                            tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                            height: 65,
                            cornerRadius: 28
                            
                        ) {
                            goToHome = true
                        }
                        
                    }
                    
                    .frame(height: 10)
                    .frame(maxWidth: 280)
                    
                    Spacer(minLength: 10)
                }
            }
            .navigationDestination(isPresented: $goToHome) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
     
        

    }
}

#Preview {
    SafeResultView()
}
