//
//  JediViewModel.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/3/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import Foundation

class JediViewModel {
    static let shared = JediViewModel()
    private var internalResult: [Result] = []
    
    var result: [Result] {
        return internalResult
    }
    
    // Only for Jedi's that will be saved in dictionary format
    var savedResults : [String : Result] = [:]
    
    func saveResult(result : Result){
        guard let id = result.created else { return }
        savedResults[id] = result
        saveToPersistence()
    }
    
    func deleteResult(result : Result){
        guard let id = result.created else { return }
        savedResults.removeValue(forKey: id)
        saveToPersistence()
    }
    
    func getJedis(with name: String ,completion: @escaping (NetworkManager.Errors?) -> Void) {
        NetworkManager.fetchJedis(name: name) { (data, error) in
            if let error = error {
                completion(.dataTaskError(error: error))
            }
            guard let data = data else {
                completion(.noDataReturned)
                return
            }
            
            do {
                let jedi = try JSONDecoder().decode(Jedi.self, from: data)
                guard let results = jedi.results else {
                    completion(.noDataReturned)
                    return
                }
                self.internalResult = results
                completion(nil)
            } catch {
                completion(.decodingDataFailed)
                return
            }
        }
    }
    
    func getAllJedis(completion: @escaping (NetworkManager.Errors?) -> Void) {
        NetworkManager.fetchAllJedis { (data, error) in
            if let error = error {
                completion(.dataTaskError(error: error))
            }
            guard let data = data else {
                completion(.noDataReturned)
                return
            }
            
            do {
                let jedi = try JSONDecoder().decode(Jedi.self, from: data)
                guard let results = jedi.results else {
                    completion(.noDataReturned)
                    return
                }
                self.internalResult = results
                completion(nil)
            } catch {
                completion(.decodingDataFailed)
                return
            }
        }
    }
    
}
