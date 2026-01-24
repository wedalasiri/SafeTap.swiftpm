//
//  analyzeMessage.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 04/08/1447 AH.
//

//func analyzeMessage(_ text: String) -> ResultType {
//    let lowercased = text.lowercased()
//    var score = 0
//
//    let scamKeywords = [
//        "http", "www",
//        "verify", "otp", "password",
//        "update", "confirm",
//        "urgent", "immediately", "within",
//        "won", "prize", "congratulations",
//        "bank", "account",
//        "أبشر", "stc", "حسابك", "سدد", "إيقاف"
//    ]
//
//    for keyword in scamKeywords {
//        if lowercased.contains(keyword) {
//            score += 1
//        }
//    }
//
//    if score == 0 {
//        return .safe
//    } else if score <= 2 {
//        return .suspicious
//    } else {
//        return .scam
//    }
//}




func analyzeMessage(_ text: String) -> ResultType {
    let lower = text.lowercased()
    var score = 0

    // 🚩 High‑risk scam indicators
    let highRiskKeywords = [
        "otp", "one time password", "verification code",
        "account suspended", "account locked",
        "verify your account", "confirm your identity",
        "urgent", "immediately", "within 24 hours",
        "click the link", "tap the link",
        "update your details",
        "bank account", "credit card",
        "iban", "transfer money",
        "gift card", "voucher",
        "wire transfer"
    ]

    // 🌐 Links (very strong signal)
    if lower.contains("http://") || lower.contains("https://") || lower.contains("www.") {
        score += 3
    }

    // 🎁 Medium‑risk (suspicious)
    let mediumRiskKeywords = [
        "congratulations", "you won", "winner",
        "prize", "reward", "giveaway",
        "offer", "limited offer", "discount",
        "job opportunity", "work from home",
        "selected", "exclusive"
    ]

    // ⏱ Pressure / fear tactics
    let pressureKeywords = [
        "act now", "last chance",
        "avoid suspension", "avoid blocking",
        "final notice"
    ]

    // Count high‑risk
    for word in highRiskKeywords {
        if lower.contains(word) {
            score += 2
        }
    }

    // Count medium‑risk
    for word in mediumRiskKeywords {
        if lower.contains(word) {
            score += 1
        }
    }

    // Count pressure
    for word in pressureKeywords {
        if lower.contains(word) {
            score += 1
        }
    }

    // ✅ Final decision
    if score >= 5 {
        return .scam
    } else if score >= 2 {
        return .suspicious
    } else {
        return .safe
    }
}
