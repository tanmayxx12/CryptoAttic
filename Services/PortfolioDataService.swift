//
//  PortfolioDataService.swift
//  CryptoAttic
//
//  Created by Tanmay . on 02/12/24.
//

import CoreData
import Foundation


class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CoreData: \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC SECTION
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        // The below code does the following:
        /*
         if let entity = savedEntities.first(where: { (savedEntity) -> Bool in
             return savedEntity.coinID == coin.id
         }) {
 
         }
         */
        // check if coin is already in the portfolio:
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE SECTION
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching PortfolioEntities: \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("There was an error saving to CoreData: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    } 
}
