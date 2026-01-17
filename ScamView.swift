//
//  ScamView.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI

struct ScamView: View {
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
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor( Color(red: 235/255, green: 84/255, blue: 54/255))
                    
                    // Title
                    Text("Scam")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    
                    // WHY
                    GlassInfoCard(
                        title: "Why",
                        points: [
                            "Requested OTP, passwords, or financial details ",
                            "Used pressure, fear, or urgency",
                            "Asked you to keep the interaction secret"
                        ]
                    )
                    
                    // WHAT SHOULD I DO
                    GlassInfoCard(
                        title: "What should i do",
                        points: [
                            "Hang up or stop responding immediately",
                            "Do not share any information",
                            "Report the incident to the official authority"
                        ]
                    )
                    
                    Spacer()
                    
                    // DONE BUTTON (your existing glass button)
                    LiquidGlassButton(
                        title: "Got it",
                        systemIcon: nil,
                        tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                        height: 65,
                        cornerRadius: 28
                    ) {
                        goToHome = true
                        print("Done tapped")
                    }
                    //                .padding(.horizontal, 24)
                    //                .frame(width: 300 ,height: 40)
                    .frame(height: 10)          // ← تحكم بالارتفاع
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
    ScamView()
}
