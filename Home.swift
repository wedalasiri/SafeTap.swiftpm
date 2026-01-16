//
//  Home.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            
            // Background
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                Spacer()
                
                // Logo
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(red: 7/255, green: 169/255, blue: 204/255))
                    .frame(width: 140)
                
                Text("SafeTap")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(Color(red: 7/255, green: 169/255, blue: 204/255))
                
                Spacer()
                
                VStack(spacing: 30) {
                    
                    LiquidGlassButton(
                        title: "Analyze message",
                        systemIcon: "message.fill"
                    ) {
                        print("Analyze message")
                    }
                    
                    LiquidGlassButton(
                        title: "What should i do",
                        systemIcon: "questionmark.circle.fill"
                    ) {
                        print("What should i do")
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
