//
//  model.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/31/24.
//
import GoogleGenerativeAI
class model{
    private let generativeModel: GenerativeModel

    init() {
        generativeModel = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: "AIzaSyBcsYnqrPdTvh56x1FJLXFb5YC5RGOaNxw"
        )
    }

    func generateResponse(from json: String) async throws -> String? {
        let prompt = "Based on the following weather data, suggest what to wear:\n\n\(json)"
        let response = try await generativeModel.generateContent(prompt)
        return response.text
    }
}
