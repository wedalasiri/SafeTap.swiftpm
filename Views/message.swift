
import SwiftUI

struct AnalyzeMessageView: View {
    
    @State private var messageText = ""
    @State private var analysisResult: AnalysisResult?

    @State private var showResult = false
    @State private var isAnalyzing = false
    @State private var analyzingProgress: Double = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 14/255, green: 30/255, blue: 38/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    Text("Analyze message")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.white)
                    
                    GlassTextEditor(
                        text: $messageText,
                        placeholder: "Paste the message here"
                    )
                    .padding(.horizontal, 24)
                    
                    LiquidGlassButton(
                        title: "Analyze",
                        systemIcon: nil,
                        tintColor: Color(red: 7/255, green: 169/255, blue: 204/255),
                        height: 65,
                        cornerRadius: 28
                    ) {
                        startAnalysis()
                    }
                    .frame(width: 320)
                    .frame(height: 64)
                    
                    Spacer()
                }
                
                if isAnalyzing {
                    ZStack {
                        Color(red: 14/255, green: 30/255, blue: 38/255)
                            .ignoresSafeArea()
                        VStack(spacing: 24) {
                            Text("Analyzing your message...")
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
                if let analysisResult = analysisResult {
                    ResultView(result: analysisResult)
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

                 analysisResult = MessageAnalyzer.analyze(text: messageText)

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
