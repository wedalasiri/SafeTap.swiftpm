//
//  message.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 27/07/1447 AH.
//

import SwiftUI

struct AnalyzeMessageView: View {
    
    @State private var messageText = ""
    @State private var result: ResultType? = nil
    @State private var showResult = false
    @State private var isAnalyzing = false
    @State private var analyzingProgress: Double = 0

    
    var body: some View {
        NavigationStack {
            
       
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
                    startAnalysis()

//                    print(messageText)
                }
                .frame(width: 320)
                .frame(height: 64)
//                .padding(.horizontal, 24)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            
            if isAnalyzing {
                ZStack {
                    // خلفية كاملة
                    Color(red: 14/255, green: 30/255, blue: 38/255)
                        .ignoresSafeArea()

                    VStack(spacing: 24) {
                        Text("Analyzing your answers...")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .offset(y: -80)

                        ProgressView(value: analyzingProgress)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(Color(red: 140/255, green: 215/255, blue: 200/255))
                            .frame(width: 260)
                            .offset(y: -80)
                    }
                    .offset(y: 40)
                }
                .transition(.opacity)
                .zIndex(999)
            }

         


        }
            
        .fullScreenCover(isPresented: $showResult) {
            if let result = result {
                switch result {
                case .safe:
                    SafeResultView()
                case .suspicious:
                    SuspiciousView()
                case .scam:
                    ScamView()
                }
            }
        }
            
            

    }
        
 }
    func startAnalysis() {
        withAnimation {
            isAnalyzing = true
            analyzingProgress = 0
        }

        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            analyzingProgress = min(analyzingProgress + 0.02, 1)

            if analyzingProgress >= 1 {
                timer.invalidate()

                // هنا فقط نحسب النتيجة
                result = analyzeMessage(messageText)

                withAnimation(.easeOut) {
                    isAnalyzing = false
                    showResult = true
                }
            }
        }
    }
}
#Preview {
    AnalyzeMessageView()
}
