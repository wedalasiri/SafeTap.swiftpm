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


//func analyzeMessage(_ text: String) -> ResultType {
//    let lower = text.lowercased()
//    var score = 0
//
//    // 🚩 High‑risk scam indicators
//    let highRiskKeywords = [
//        "otp", "one time password", "verification code",
//        "account suspended", "account locked",
//        "verify your account", "confirm your identity",
//        "urgent", "immediately", "within 24 hours",
//        "click the link", "tap the link",
//        "update your details",
//        "bank account", "credit card",
//        "iban", "transfer money",
//        "gift card", "voucher",
//        "wire transfer"
//    ]
//
//    // 🌐 Links (very strong signal)
//    if lower.contains("http://") || lower.contains("https://") || lower.contains("www.") {
//        score += 3
//    }
//
//    // 🎁 Medium‑risk (suspicious)
//    let mediumRiskKeywords = [
//        "congratulations", "you won", "winner",
//        "prize", "reward", "giveaway",
//        "offer", "limited offer", "discount",
//        "job opportunity", "work from home",
//        "selected", "exclusive"
//    ]
//
//    // ⏱ Pressure / fear tactics
//    let pressureKeywords = [
//        "act now", "last chance",
//        "avoid suspension", "avoid blocking",
//        "final notice"
//    ]
//
//    // Count high‑risk
//    for word in highRiskKeywords {
//        if lower.contains(word) {
//            score += 2
//        }
//    }
//
//    // Count medium‑risk
//    for word in mediumRiskKeywords {
//        if lower.contains(word) {
//            score += 1
//        }
//    }
//
//    // Count pressure
//    for word in pressureKeywords {
//        if lower.contains(word) {
//            score += 1
//        }
//    }
//
//    // ✅ Final decision
//    if score >= 5 {
//        return .scam
//    } else if score >= 2 {
//        return .suspicious
//    } else {
//        return .safe
//    }
//}

struct AnalysisResult {
    let type: ResultType
    let reasons: [String]
}



func analyzeMessage(_ text: String) -> AnalysisResult {
    let lower = text.lowercased()
    var score = 0
    var reasons: [String] = []

    // 🔗 Links
    if lower.contains("http://") || lower.contains("https://") || lower.contains("www.") {
        score += 3
        reasons.append("Contains a suspicious link")
    }

    // 🚩 High‑risk indicators
    let highRisk: [(String, String)] = [
        ("otp", "Requests a one‑time password (OTP)"),
        ("verification code", "Asks for a verification code"),
        ("account suspended", "Claims your account is suspended"),
        ("account locked", "Claims your account is locked"),
        ("verify your account", "Asks you to verify your account"),
        ("iban", "Requests bank or payment details"),
        ("gift card", "Asks for gift cards"),
        ("urgent", "Uses urgency or pressure"),
        ("immediately", "Pushes immediate action"),
        ("within 24 hours", "Uses time pressure")
    ]

    for (keyword, reason) in highRisk {
        if lower.contains(keyword) {
            score += 2
            reasons.append(reason)
        }
    }

    // ⚠️ Medium‑risk
    let mediumRisk: [(String, String)] = [
        ("congratulations", "Unexpected prize message"),
        ("you won", "Claims you won something"),
        ("job opportunity", "Suspicious job offer"),
        ("work from home", "Too‑good‑to‑be‑true job offer"),
        ("discount", "Unrealistic discount")
    ]

    for (keyword, reason) in mediumRisk {
        if lower.contains(keyword) {
            score += 1
            reasons.append(reason)
        }
    }

    // 🧠 Final decision
    let type: ResultType
    if score >= 5 {
        type = .scam
    } else if score >= 2 {
        type = .suspicious
    } else {
        type = .safe
    }

    return AnalysisResult(type: type, reasons: reasons)
}
