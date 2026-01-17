//
//  splash.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct SafeTapSplashView: View {
    @State private var animate = false
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            // Background color
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo Image
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .resizable()
                    .frame(width: 233, height: 245)
                    .foregroundColor(Color(red: 33/255, green: 190/255, blue: 225/255))
                    .offset(x: 28, y: animate ? 0 : 20)
                    .opacity(animate ? 1 : 0)
                  




                // App Name
                Text("SafeTap")
                    .font(.system(size: 58, weight: .bold))
                    .foregroundColor(Color(red: 33/255, green: 190/255, blue: 225/255))
                    .offset(y: animate ? -26 : -10)
                    .opacity(animate ? 1 : 0)
                  



            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                animate = true
            }
            // Optional: navigate to Home after splash delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navigateToHome = true
            }
        }
        .fullScreenCover(isPresented: $navigateToHome) {
            HomeView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

