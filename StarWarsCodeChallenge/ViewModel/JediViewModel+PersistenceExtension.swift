//
//  JediViewModel+PersistenceExtension.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import Foundation

extension JediViewModel {
    
    // URL to the bank
       var savedResultsURL : URL?{
           guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
           let fileName = "Results(Persistence).plist"
           return documentsDirectory.appendingPathComponent(fileName)
       }
    
     func saveToPersistence(){
          let plistEncoder = PropertyListEncoder()
          do {
            guard let savedResultsURL = savedResultsURL else { return }
            let resultsData = try plistEncoder.encode(savedResults)
              try resultsData.write(to: savedResultsURL)
              
          } catch let error {
              print("Error trying to save data! \(error.localizedDescription)")
          }
      }
    
    func loadFromPersistence(){
        do {
            guard let savedResultsURL = savedResultsURL else { return
            }
            let resultsData = try Data(contentsOf: savedResultsURL)
            let plistDecoder = PropertyListDecoder()
            let decodedResults = try plistDecoder.decode( Dictionary<String, Result>.self, from: resultsData)
            savedResults = decodedResults
        } catch let error {
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
    
}
