//
//  analyzeMessage.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 04/08/1447 AH.
//


import Foundation
import CoreML



struct AnalysisResult {
    let type: ResultType
    let reasons: [String]
}

struct MessageAnalyzer {

    static func analyze(text: String) -> AnalysisResult {

        do {

            // تحميل الموديل
            let url = Bundle.main.url(
                forResource: "ScamMessageClassifier",
                withExtension: "mlmodelc"
            )!

            let model = try MLModel(contentsOf: url)

            // input
            let input = try MLDictionaryFeatureProvider(dictionary: [
                "text": MLFeatureValue(string: text)
            ])

            // prediction
            let prediction = try model.prediction(from: input)

            let label = prediction.featureValue(for: "label")?.stringValue ?? "safe"

            // تحويل النتيجة
            let type: ResultType

            switch label.lowercased() {

            case "scam":
                type = .scam

            case "suspicious":
                type = .suspicious

            default:
                type = .safe
            }

            // أسباب بسيطة بناء على النتيجة
            let reasons = generateReasons(text: text, type: type)

            return AnalysisResult(type: type, reasons: reasons)

        } catch {

            print("ML Error:", error)

            return AnalysisResult(
                type: .safe,
                reasons: ["Analysis failed — treated as safe"]
            )
        }
    }

    // أسباب مفهومة لليوزر
    static func generateReasons(text: String, type: ResultType) -> [String] {

        let lower = text.lowercased()
        var reasons: [String] = []

        if lower.contains("otp") || lower.contains("code") {
            reasons.append("Requests verification code")
        }

        if lower.contains("http") || lower.contains("link") {
            reasons.append("Contains suspicious link")
        }

        if lower.contains("urgent") || lower.contains("now") {
            reasons.append("Creates pressure")
        }

        if lower.contains("bank") || lower.contains("account") {
            reasons.append("Mentions sensitive info")
        }

        if reasons.isEmpty && type != .safe {
            reasons.append("Pattern matches known scam behavior")
        }

        return reasons
    }
}




