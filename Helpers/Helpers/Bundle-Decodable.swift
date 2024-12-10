//
//  Bundle-Decodable.swift
//  Helpers
//
//  Created by Pallab Maiti on 18/11/24.
//

import Foundation

extension Bundle {
    public func decode<T: Decodable>(from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find file \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read file \(file) from bundle.")
        }
        
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Key \(key) not found in \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Value of type \(type) not found in \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            fatalError("Type mismatch for \(type) in \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Data corrupted in \(context.debugDescription)")
        } catch {
            fatalError("Unknown error: \(error)")
        }
    }
}

extension Data {
    public func decode<T: Decodable>() -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: self)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Key \(key) not found in \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Value of type \(type) not found in \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            fatalError("Type mismatch for \(type) in \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("Data corrupted in \(context.debugDescription)")
        } catch {
            fatalError("Unknown error: \(error)")
        }
    }
}
