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
                    
                    // Title
                    Text("safe")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    
                    // WHY
                    GlassInfoCard(
                        title: "Why",
                        points: [
                            "No request for OTP or passwords",
                            "No pressure or threats",
                            "No sensitive information requested"
                        ]
                    )
                    
                    // WHAT SHOULD I DO
                    GlassInfoCard(
                        title: "What should i do",
                        points: [
                            "You can safely ignore or continue normally",
                            "Stay aware if the situation changes"
                        ]
                    )
                    
                    Spacer()
                    
                    NavigationLink {
                        HomeView()
                         .navigationBarBackButtonHidden(true)
                    } label: {
                        LiquidGlassButton(
                            title: "Done",
                            systemIcon: nil,
                            tintColor: .cyan
                        ) {
                            goToHome = true
                        }
                        
                    }
                    
//                    LiquidGlassButton(
//                        title: "Done",
//                        systemIcon: nil,
//                        tintColor: .cyan
//                    ) {
//                        print("Done tapped")
//                    }
                    //                .padding(.horizontal, 24)
                    //                .frame(width: 300 ,height: 40)
                    .frame(height: 10)          // ← تحكم بالارتفاع
                    .frame(maxWidth: 280)
                    
                    Spacer(minLength: 10)
                }
            }
        }
        .navigationDestination(isPresented: $goToHome) {
            HomeView()
//                .navigationBarBackButtonHidden(true)
        }

    }
}

#Preview {
    SafeResultView()
}
