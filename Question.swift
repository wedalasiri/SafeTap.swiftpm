//
//  Question.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI


struct QuickCheckView: View {
    
    
    // جميع الأسئلة
    let questions: [String] = [
        """
Did the caller ask for
a one-time password (OTP)
or verification code?
""",
        """
Did the caller claim to be from
a trusted organization and ask
for sensitive information?
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
    
    let hints: [String] = [
        "", // السؤال الأول ← فاضي (ما راح يظهر)
        "Banks may call, but they never ask for OTPs or passwords.",
        "Urgency and threats are common scam tactics.",
        "This is often used to prevent you from getting help."
    ]

    
    
    
    @State private var isAnalyzing = false
    @State private var showResult = false
    @State private var riskScore = 0
    @State private var analyzingProgress: Double = 0


    // السؤال الحالي
    @State private var currentIndex = 0
    var body: some View {
        ZStack {
            // Background
            Color(red: 14/255, green: 30/255, blue: 38/255)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                // Progress Bar
//                ProgressView(value: 0.15)
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .tint(Color(red: 60/255, green: 190/255, blue: 170/255).opacity(53))
//                    .frame(width: 300)
//                    .padding(.top, 20)
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
                
                if currentIndex > 0 {
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
                    // هذا السر ✨
                    .offset(y: 40)
                }
                .transition(.opacity)
                .zIndex(999)
            }

        }
        
        
//        if isAnalyzing {
//            ZStack {
//                // تعتيم الخلفية
//                Color.black.opacity(0.45)
//                    .ignoresSafeArea()
//
//                VStack(spacing: 20) {
//                    Text("Analyzing your answers…")
//                        .font(.system(size: 24, weight: .medium))
//                        .foregroundColor(.white)
//
//                    ProgressView(
//                        value: analyzingProgress,
//                        total: 1
//                    )
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .tint(Color(red: 60/255, green: 190/255, blue: 170/255))
//                    .frame(width: 300)
//                }
//                .padding(30)
//                .background(
//                    RoundedRectangle(cornerRadius: 24)
//                        .fill(.ultraThinMaterial)
//                )
//                .transition(.opacity)
//            }
//        }

        
        var resultType: ResultType {
            if riskScore == 0 {
                return .safe
            } else if riskScore <= 2 {
                return .suspicious
            } else {
                return .scam
            }
        }

        
    }
//    func nextQuestion() {
//          if currentIndex < questions.count - 1 {
//              currentIndex += 1
//          } else {
//              print("Finished questions")
//              // هنا لاحقًا تنتقل لصفحة النتيجة
//          }
//      }
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
            
            // تحريك شريط التحميل
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                // Clamp to 0...1 to avoid out-of-bounds values.
                analyzingProgress = min(analyzingProgress + 0.02, 1)
                if analyzingProgress >= 1 {
                    timer.invalidate()
                    
                    withAnimation(.easeOut) {
                        isAnalyzing = false
                        showResult = true
                    }
                }
            }
        }
        
    }
}
enum ResultType {
    case safe
    case suspicious
    case scam
}

#Preview {
    QuickCheckView()
}
