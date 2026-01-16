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
                                    Color.cyan.opacity(0.70)
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




struct GlassTextEditor: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.top, 16)
                    .padding(.leading, 16)
            }
            
            TextEditor(text: $text)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
        }
        .frame(height: 280)
        .background(
            ZStack {
                
                // Glass Blur
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                
                // Glass Color
                RoundedRectangle(cornerRadius: 28)
                    .fill(
                        Color.white.opacity(0.12)
                    )
                
                // Border
                RoundedRectangle(cornerRadius: 28)
                    .stroke(
                        Color.white.opacity(0.35),
                        lineWidth: 1
                    )
            }
        )
    }
}
