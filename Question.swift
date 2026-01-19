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
        }
    }
    func nextQuestion() {
          if currentIndex < questions.count - 1 {
              currentIndex += 1
          } else {
              print("Finished questions")
              // هنا لاحقًا تنتقل لصفحة النتيجة
          }
      }
    
}
#Preview {
    QuickCheckView()
}
