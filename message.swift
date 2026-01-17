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
                    systemIcon:  nil,
                    tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                    height: 65,
                    cornerRadius: 28
                ) {
                    print(messageText)
                }
                .frame(width: 320)
                .frame(height: 64)
//                .padding(.horizontal, 24)
                
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
