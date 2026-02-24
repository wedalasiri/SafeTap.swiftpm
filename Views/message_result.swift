//
//  message_result.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 19/08/1447 AH.
//



import SwiftUI

struct ResultView: View {
    let result: AnalysisResult
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 14/255, green: 30/255, blue: 38/255)
                    .ignoresSafeArea()

                VStack(spacing: 28) {
                    Spacer()

                    // Icon
                    ZStack {
                        if result.type == .safe {
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                                .foregroundColor(iconColor)
                                .offset(x : 13)
                        } else {
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                                .foregroundColor(iconColor)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    // Title
                    Text(title)
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)

                    // WHY
                    GlassInfoCard(
                        title: "Why",
                        points: result.reasons.isEmpty ? defaultReasons : result.reasons
                    )

                    // WHAT SHOULD I DO
                    GlassInfoCard(
                        title: "What should i do",
                        points: whatToDo
                    )

                    Spacer()

                    LiquidGlassButton(
                        title: "Got it",
                        systemIcon: nil,
                        tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                        height: 65,
                        cornerRadius: 28
                    ) {
                        goToHome = true
                    }
                    .frame(maxWidth: 280)

                    Spacer(minLength: 10)
                }
            }
            .navigationDestination(isPresented: $goToHome) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    // result from message
    var title: String {
        switch result.type {
        case .safe: return "Safe"
        case .suspicious: return "Suspicious"
        case .scam: return "Scam"
        }
    }

    var iconName: String {
        switch result.type {
        case .safe: return "shield.lefthalf.filled.badge.checkmark"
        case .suspicious: return "exclamationmark.triangle.fill"
        case .scam: return "xmark.circle"
        }
    }

    var iconColor: Color {
        switch result.type {
        case .safe: return Color(red: 72/255, green: 170/255, blue: 155/255)
        case .suspicious: return Color(red: 229/255, green: 187/255, blue: 67/255)
        case .scam: return Color(red: 235/255, green: 84/255, blue: 54/255)
        }
    }

    var defaultReasons: [String] {
        switch result.type {
        case .safe: return [
            "didn’t ask for OTP or passwords",
            "No attempts to scare or rush you",
            "No sensitive information requested"
        ]
        case .suspicious: return [
            "The caller claimed to be from a trusted entity",
            "Created urgency",
            "Asked for unusual information"
        ]
        case .scam: return [
            ""
        ]
        }
    }

    var whatToDo: [String] {
        switch result.type {
        case .safe: return [
            "You’re safe — no action needed",
            "Just continue as usual"
        ]
        case .suspicious: return [
            "Do not share any personal information",
            "Do not click links or follow instructions"
        ]
        case .scam: return [
            "Hang up immediately",
            "Do not share any information",
            "Report to authorities"
        ]
        }
    }
}
