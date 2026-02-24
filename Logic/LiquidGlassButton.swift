//
//  LiquidGlassButton.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//



import SwiftUI

struct LiquidGlassButton: View {
    let title: String
    let systemIcon: String?
    let tintColor: Color
    let height: CGFloat
    let cornerRadius: CGFloat  
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
//                Image(systemName: systemIcon)
//                    .font(.system(size: 28, weight: .medium))
                if let systemIcon {
                    Image(systemName: systemIcon)
                        .font(.system(size: 24, weight: .medium))
                    .foregroundColor(Color(.white))                }
                
                Text(title)
                    .font(.system(size: 26, weight: .medium))
            }
            .foregroundColor(Color(.white))
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: height)
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

                                    tintColor.opacity(0.70)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Glass Highlight
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
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
                        lineWidth: 0
                        
                    )
                
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 28)
                                                    .stroke(Color.white.opacity(0.4), lineWidth: 2.5)
                                            )
            }
        )
    }
}

struct GlassInfoCard: View {
    let title: String
    let points: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y : -15)
            
            
            ForEach(points, id: \.self) { point in
                HStack(alignment: .top, spacing: 5) {
                    Text("•")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 17))
                    

                    Text(point)
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 17))
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
            }

        }
        .padding(20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.4), lineWidth: 2.5)
                    )
                
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white.opacity(0.12))
                
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
            }
        )
        .padding(.horizontal, 24)
    }
}
