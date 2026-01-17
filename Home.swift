//
//  Home.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct HomeView: View {
    
    @State private var goToAnalyze = false
    @State private var goToWhatShouldIdo = false

    var body: some View {
        NavigationStack {
            ZStack {
                
                
                
                
                // Background
                Color(red: 14/255, green: 30/255, blue: 38/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    // Logo
                    Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(red: 7/255, green: 169/255, blue: 204/255))
                        .frame(width: 233, height: 185)
                        .offset(x: 27)

                    Text("SafeTap")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color(red: 7/255, green: 169/255, blue: 204/255))
                        .offset( y: -30)
                    
                    
                    Spacer()
                    
                    VStack(spacing: 30) {
                        
                        //                    LiquidGlassButton(
                        //                        title: "Analyze message",
                        //                        systemIcon: "message.fill"
                        //                    ) {
                        //                        print("Analyze message")
                        //                    }
                        
                        NavigationLink {
                            AnalyzeMessageView()
                             .navigationBarBackButtonHidden(true)
                        } label: {
                            LiquidGlassButton(
                                title: "Analyze message",
                                systemIcon: "message.fill",
                                tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                                height: 90,
                                   cornerRadius: 40,
                                
                            ) {
                                goToAnalyze = true
                            }
                            
                        }
                        
                        NavigationLink {
                            QuickCheckView()
                             .navigationBarBackButtonHidden(true)
                        } label: {
                            LiquidGlassButton(
                                title: "What should i do",
                                systemIcon: "questionmark.circle.fill",
                                tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                                height: 90,
                                cornerRadius: 40
                                
                            ) {
                                goToWhatShouldIdo = true
                                
                                print("What should i do")
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            
            // 🔥 Navigation destination
                        .navigationDestination(isPresented: $goToAnalyze) {
                            AnalyzeMessageView()
//                                .navigationBarBackButtonHidden(true)
                        }
                        .navigationDestination(isPresented: $goToWhatShouldIdo) {
                            QuickCheckView()
//                                .navigationBarBackButtonHidden(true)
                        }
        }
    }
}

#Preview {
    HomeView()
}
