//
//  message.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct AnalyzeMessageView: View {
    
    @State private var messageText = ""
    
    var body: some View {
        ZStack {
            
            // Background
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                Spacer()
                
                // Title
                Text("Analyze message")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(.white)
                
                // Glass Input
                GlassTextEditor(
                    text: $messageText,
                    placeholder: "Paste the message here"
                )
                .padding(.horizontal, 24)
                
                // Liquid Glass Button (YOUR COMPONENT)
                LiquidGlassButton(
                    title: "Analyze",
                    systemIcon: "shield.checkerboard",
                    tintColor: Color(red: 60/255, green: 190/255, blue: 170/255)
                ) {
                    print(messageText)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    AnalyzeMessageView()
}
