//
//  LiquidGlassButton.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct LiquidGlassButton: View {
    let title: String
    let systemIcon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: systemIcon)
                    .font(.system(size: 28, weight: .medium))
                
                
                Text(title)
                    .font(.system(size: 26, weight: .medium))
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .background(
                ZStack {
                    
                    // Glass Blur
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.ultraThinMaterial)
                    
                    // Liquid Gradient
                    RoundedRectangle(cornerRadius: 32)
                        .fill(
                            LinearGradient(
                                colors: [
//                                    Color.white.opacity(0.25),
//                                    Color.white.opacity(0.05),
                                    Color.cyan/*.opacity(0.25)*/
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Glass Highlight
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
        }
        .buttonStyle(.plain)
    }
}
