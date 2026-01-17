//
//  Question.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI


struct QuickCheckView: View {
    var body: some View {
        ZStack {
            // Background
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                // Progress Bar
                ProgressView(value: 0.15)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(Color(red: 60/255, green: 190/255, blue: 170/255).opacity(53))
                    .frame(width: 300)
                    .padding(.top, 20)
                
                // Title
                Text("Quick Check")
                    .font(.system(size: 46, weight: .bold))
                    .foregroundColor(Color.cyan)
                
                Spacer()
                
                // Question
                Text("""
 Did the caller ask for
 a one-time password (OTP)
 or verification code?
""")
                    .font(.system(size: 38, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Buttons
                HStack(spacing: 24) {
                    LiquidGlassButton(
                        title: "Yes",
                        systemIcon: nil,
                        tintColor: Color(red: 60/255, green: 190/255, blue: 170/255).opacity(53),
                        height: 101,
                           cornerRadius: 53

                    ) {
                        print("YES tapped")
                    }
                    
                    LiquidGlassButton(
                        title: "No",
                        systemIcon: nil,
                        tintColor: Color(red: 235/255, green: 84/255, blue: 54/255).opacity(53),
                        height: 101,
                           cornerRadius: 53


                    ) {
                        print("NO tapped")
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}
#Preview {
    QuickCheckView()
}
