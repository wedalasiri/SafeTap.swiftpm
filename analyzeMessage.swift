////
////  analyzeMessage.swift
////  SafeTap
////
////  Created by Wed Ahmed Alasiri on 04/08/1447 AH.
////
//
//import Foundation
//import CoreML
//
//
//
//struct AnalysisResult {
//    let type: ResultType
//    let reasons: [String]
//}
//
////struct MessageAnalyzer {
////
////    static func analyze(text: String) -> AnalysisResult {
////
////        do {
////
////            // تحميل الموديل
////            let url = Bundle.main.url(
////                forResource: "ScamMessageClassifier",
////                withExtension: "mlmodelc"
////            )
////
////            let model = try MLModel(contentsOf: url)
////
////            // input
////            let input = try MLDictionaryFeatureProvider(dictionary: [
////                "text": MLFeatureValue(string: text)
////            ])
////
////            // prediction
////            let prediction = try model.prediction(from: input)
////
////            let label = prediction.featureValue(for: "label")?.stringValue ?? "safe"
////
////            // تحويل النتيجة
////            let type: ResultType
////
////            switch label.lowercased() {
////
////            case "scam":
////                type = .scam
////
////            case "suspicious":
////                type = .suspicious
////
////            default:
////                type = .safe
////            }
////
////            // أسباب بسيطة بناء على النتيجة
////            let reasons = generateReasons(text: text, type: type)
////
////            return AnalysisResult(type: type, reasons: reasons)
////
////        } catch {
////
////            print("ML Error:", error)
////
////            return AnalysisResult(
////                type: .safe,
////                reasons: ["Analysis failed — treated as safe"]
////            )
////        }
////    }
////
////    // أسباب مفهومة لليوزر
////    static func generateReasons(text: String, type: ResultType) -> [String] {
////
////        let lower = text.lowercased()
////        var reasons: [String] = []
////
////        if lower.contains("otp") || lower.contains("code") {
////            reasons.append("Requests verification code")
////        }
////
////        if lower.contains("http") || lower.contains("link") {
////            reasons.append("Contains suspicious link")
////        }
////
////        if lower.contains("urgent") || lower.contains("now") {
////            reasons.append("Creates pressure")
////        }
////
////        if lower.contains("bank") || lower.contains("account") {
////            reasons.append("Mentions sensitive info")
////        }
////
////        if reasons.isEmpty && type != .safe {
////            reasons.append("Pattern matches known scam behavior")
////        }
////
////        return reasons
////    }
////}
//
//
//
//struct MessageAnalyzer {
//
//    // ✅ load once
//    nonisolated(unsafe) private static let model: MLModel = {
//        guard let url = Bundle.main.url(
//            forResource: "ScamMessageClassifierScamMessageClassifier",
//            withExtension: "mlmodelc"
//        ) else {
//            fatalError("❌ Model not found")
//        }
//
//        do {
//            let model = try MLModel(contentsOf: url)
//            print("✅ ML model loaded once")
//            return model
//        } catch {
//            fatalError("❌ Failed to load ML model: \(error)")
//        }
//    }()
//
//    static func analyze(text: String) -> AnalysisResult {
//
//        do {
//            let input = try MLDictionaryFeatureProvider(dictionary: [
//                "text": MLFeatureValue(string: text)
//            ])
//
//            let prediction = try model.prediction(from: input)
//
//            let label = prediction.featureValue(for: "label")?.stringValue ?? "safe"
//
//            let type: ResultType
//            switch label.lowercased() {
//            case "scam": type = .scam
//            case "suspicious": type = .suspicious
//            default: type = .safe
//            }
//
//            let reasons = generateReasons(text: text, type: type)
//            return AnalysisResult(type: type, reasons: reasons)
//
//        } catch {
//            print("ML Error:", error)
//            return AnalysisResult(
//                type: .safe,
//                reasons: ["Analysis failed — treated as safe"]
//            )
//        }
//    }
//
//    static func generateReasons(text: String, type: ResultType) -> [String] {
//        let lower = text.lowercased()
//        var reasons: [String] = []
//
//        if lower.contains("otp") || lower.contains("code") {
//            reasons.append("Requests verification code")
//        }
//
//        if lower.contains("http") || lower.contains("link") {
//            reasons.append("Contains suspicious link")
//        }
//
//        if lower.contains("urgent") || lower.contains("now") {
//            reasons.append("Creates pressure")
//        }
//
//        if lower.contains("bank") || lower.contains("account") {
//            reasons.append("Mentions sensitive info")
//        }
//        if reasons.isEmpty && type != .safe {
//            reasons.append("Pattern matches known scam behavior")
//        }
//
//        return reasons
//    }
//}
//


enum MessageType {
    case safe
    case suspicious
    case scam
}

struct AnalysisResult {
    let type: MessageType
    let reasons: [String]
}

struct MessageAnalyzer {
    
    static func analyze(text: String) -> AnalysisResult {
        
        let text = text.lowercased()
        var reasons: [String] = []
        
        // 🔴 طلب معلومات حساسة (واسع جداً)
        let sensitivePatterns = [
            
            // كلمات تحقق
            "otp", "one time password", "verification code",
            "security code", "confirm code", "sms code",
            
            // كلمات كلمات المرور
            "password", "passcode", "login details",
            
            // بيانات مالية
            "credit card", "card number", "cvv", "expiry date",
            "bank account", "iban", "bank details",
            
            // هوية شخصية
            "national id", "id number", "identity number",
            "passport number", "iqama", "residency number",
            
            
            // عبارات تحقق
            "verify your identity", "confirm your account",
            "update your details", "submit your information"
        ]
        
        if sensitivePatterns.contains(where: { text.contains($0) }) {
            reasons.append("Requests sensitive personal information")
            return AnalysisResult(type: .scam, reasons: reasons)
        }
        
        // 🟡 كلمات إغراء (أوسع)
        let baitPatterns = [
            "free", "won", "winner", "prize",
            "reward", "bonus", "cashback",
            "lottery", "jackpot", "giveaway",
            "claim your reward", "exclusive offer",
            "special deal", "promotion"
        ]
        
        // 🟡 كلمات ضغط واستعجال (أوسع)
        let urgencyPatterns = [
            "urgent", "immediately", "right now",
            "act now", "hurry", "final notice",
            "last chance", "limited time",
            "expires today", "within 24 hours",
            "account suspended", "action required",
            "failure to respond", "legal action"
        ]
        
        if baitPatterns.contains(where: { text.contains($0) }) {
            reasons.append("Contains reward or bait language")
        }
        
        if urgencyPatterns.contains(where: { text.contains($0) }) {
            reasons.append("Creates urgency or pressure")
        }
        
        if !reasons.isEmpty {
            return AnalysisResult(type: .suspicious, reasons: reasons)
        }
        
        return AnalysisResult(type: .safe, reasons: [])
    }
}
