//
//  MessageClassifier.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 19/08/1447 AH.
//

import Foundation
import CoreML

class ScamMessageClassifierManual {

    let model: MLModel

    init() throws {
        guard let url = Bundle.main.url(
            forResource: "ScamMessageClassifier",
            withExtension: "mlmodelc"
        ) else {
            fatalError("❌ Model not found")
        }

        model = try MLModel(contentsOf: url)
    }

    func predict(text: String) throws -> MLFeatureProvider {

        let input = try MLDictionaryFeatureProvider(dictionary: [
            "text": MLFeatureValue(string: text)
        ])

        return try model.prediction(from: input)
    }
}
