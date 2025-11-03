//
//  APIService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation


final class APIService {
    static let shared = APIService()
    let baseURL : String = "http://10.80.57.238:8080"
    
    private init() {}

    //METHODE GET
    func get<T: Decodable>(_ endpoint: String,token: String? = nil) async throws -> T {
        guard let url = URL(string : baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
                    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    //METHODE POST
    func post<T: Codable, U: Decodable>(_ endpoint: String, body: T, token: String? = nil) async throws -> U {
        guard let url = URL(string : baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONDecoder().decode(U.self, from: data)
        case 401 :
            throw URLError(.userAuthenticationRequired)
        default:
            throw URLError(.badServerResponse)
        }
    }
    
    
    //METHODE DELETE
    func delete(_ endpoint: String) async throws {
        guard let url = URL(string : baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    //METHODE PATCH
    func patch<T: Codable, U: Decodable>(_ endpoint: String, body: T, token: String? = nil) async throws -> U {
        guard let url = URL(string : baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(U.self, from: data)
    }
}

