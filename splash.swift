//
//  splash.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct SafeTapSplashView: View {
    var body: some View {
        ZStack {
            
            // Background color
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // Logo Image
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .resizable()
                    .frame(width: 213, height: 245)
                    .foregroundColor(Color(red: 33/255, green: 190/255, blue: 225/255))
                    .offset(x: 25)
                
                // App Name
                Text("SafeTap")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(Color(red: 33/255, green: 190/255, blue: 225/255))
                    .offset(y: -26)
            }
        }
    }
}


