//
//  SuspiciousView.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

//
//  SafeResultView.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 28/07/1447 AH.
//

import SwiftUI

struct SuspiciousView: View {
    @State private var goToHome = false
    let reasons: [String]
    var body: some View {
        NavigationStack{
            
            ZStack {
                
                // Background
                Color(red: 14/255, green: 30/255, blue: 38/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    
                    Spacer()
                    
                    // Icon
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .foregroundColor(Color(red: 229/255, green: 187/255, blue: 67/255))
                    
                    // Title
                    Text("Suspicious")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    
                    // WHY
                    GlassInfoCard(
                        title: "Why",
                        points: reasons.isEmpty
                            ? [
                                "The caller claimed to be from a trusted entity",
                                "Created urgency",
                                "Asked for unusual information"
                              ]
                            : reasons
                    )
                    
                    // WHAT SHOULD I DO
                    GlassInfoCard(
                        title: "What should i do",
                        points: [
                            "Do not share any personal information",
                            "Do not click links or follow instructions",
                            "Contact the organization using its official number"
                            
                        ]
                    )
                    
                    Spacer()
                    
                    // DONE BUTTON (your existing glass button)
                    LiquidGlassButton(
                        title: "Got it ",
                        systemIcon: nil,
                        tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                        height: 65,
                        cornerRadius: 28
                    ) {
                        goToHome = true
                        print("Done tapped")
                    }
                    .frame(height: 10)
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
}

#Preview {
    SuspiciousView(reasons: [
        "Contains a suspicious link",
        "Uses urgency or pressure",
        "Asks for a verification code"
    ])
}
