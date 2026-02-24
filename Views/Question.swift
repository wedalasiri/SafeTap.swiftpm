//
//  Question.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI


struct QuickCheckView: View {
    
    
//all Question
    let questions: [String] = [
        """
Did the caller ask for
a one-time password (OTP)
or verification code?
""",
        """
Did the caller pretend to be from a trusted organization?
""",
        """
Did the caller rush or scare you
into acting immediately?
""",
        """
Did the caller ask you not to
tell anyone about the call?
"""
    ]
    
    
    //hint if the user doesn't undrstsnd
    let hints: [String] = [
        "",
        "Official organizations may call, but they never ask for OTPs or passwords",
        "",
        ""
    ]

//reasons for Question
    let reasonsForYes: [String] = [
        "Requested verification code (OTP)",
        "Requested sensitive info and claimed to be from trusted organization",
        "They try to scare or rush you so you act before checking if it’s real.",
        "They ask you not to tell anyone so no one discovers the scam"
    ]
    
    
    @State private var isAnalyzing = false
    @State private var showResult = false
    @State private var riskScore = 0
    @State private var analyzingProgress: Double = 0


    @State private var navigate = false
    @State private var currentIndex = 0
    
    @State private var reasons: [String] = []

    
    var resultType: ResultType {
        if riskScore == 0 {
            return .safe
        } else if riskScore <= 2 {
            return .suspicious
        } else if riskScore <= 4{
            return .scam
        } else {
            return .scam
        }
    }
    var body: some View {
        ZStack {
            // Background
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
   
                ProgressView(
                    value: Double(currentIndex + 1),
                    total: Double(questions.count)
                )
                .progressViewStyle(LinearProgressViewStyle())
                .tint(Color(red: 60/255, green: 190/255, blue: 170/255))
                .frame(width: 300)
                .padding(.top, 20)
                .animation(.easeInOut, value: currentIndex)

                
                // Title
                Text("Quick Check")
                    .font(.system(size: 46, weight: .bold))
                    .foregroundColor(Color.cyan)
                
                Spacer()
                
                // Question
                Text(questions[currentIndex])
                    .font(.system(size: 38, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                if currentIndex > 0 && !hints[currentIndex].isEmpty {
                    Text(hints[currentIndex])
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(Color.white.opacity(0.4), lineWidth: 2.5)
                                )
                        )
                        .padding(.horizontal, 24)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: currentIndex)
                }
                
                Spacer()
                
                // Buttons
                HStack(spacing: 24) {
                    LiquidGlassButton(
                        title: "Yes",
                        systemIcon: nil,
                        tintColor: Color(red: 60/255, green: 190/255, blue: 170/255).opacity(53),
                        height: 101,
                           cornerRadius: 53

                    ) {
                        riskScore += 1
                        reasons.append(reasonsForYes[currentIndex])

                        nextQuestion()
                        print("YES tapped")
                    }
                    
                    LiquidGlassButton(
                        title: "No",
                        systemIcon: nil,
                        tintColor: Color(red: 235/255, green: 84/255, blue: 54/255).opacity(53),
                        height: 101,
                           cornerRadius: 53


                    ) {
                        nextQuestion()
                        print("NO tapped")
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            
            if isAnalyzing {
                ZStack {
                  //backgournd
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
        
        .fullScreenCover(isPresented: $navigate) {
            switch resultType {
            case .safe:
                SafeResultView()
            case .suspicious:
                SuspiciousView(reasons: reasons)
            case .scam:
                ScamView(reasons: reasons)
            }
        }


        
        

        
    }
    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            withAnimation(.easeInOut) {
                currentIndex += 1
            }
        } else {
            withAnimation {
                isAnalyzing = true
                analyzingProgress = 0
            }
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                analyzingProgress = min(analyzingProgress + 0.02, 1)
                if analyzingProgress >= 1 {
                    timer.invalidate()
                    withAnimation(.easeOut) {
                        isAnalyzing = false
                        navigate = true
                    }
                }
            }

        }
    }
}




#Preview {
    QuickCheckView()
}
