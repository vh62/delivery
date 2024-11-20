//
//  DeliveryViewModel.swift
//  vikram
//
//  Created by Vikram on 17/11/24.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class DeliveryListViewModel {
    var modelContext: ModelContext
    var deliveries = [Delivery]()
    var favorites = [Favorite]()
    var isLoading = false
    var currentPage = 1
    
    
    let itemsPerPage = 10
    
    private let deliveryService: DeliveryService
    
    init( modelContext: ModelContext, deliveryService: DeliveryService = DeliveryAPIService()) {
        self.modelContext = modelContext
        self.deliveryService = deliveryService
    }
    
    func fetchDeliveryData() {
        do {
            let descriptor = FetchDescriptor<Delivery>()
            deliveries = try modelContext.fetch(descriptor)
            
        } catch {
            print("Fetch delivery failed")
        }
    }
    
    func fetchfavoriteData() {
        do {
            let descriptor = FetchDescriptor<Favorite>()
            favorites = try modelContext.fetch(descriptor)
            print(favorites)
        } catch {
            print("Fetch favorite failed")
        }
    }
    
    func loadMoreContentIfNeeded(currentItem: Delivery?) {
        guard let currentItem = currentItem,
              !isLoading,
              let index = deliveries.firstIndex(where: { $0.id == currentItem.id }),
              index == deliveries.count - 3 else { return }
        
        Task {
            await fetchDeliveries()
        }
    }
    
    func fetchDeliveries() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let newDeliveries = try await deliveryService.getDeliveries(page: currentPage, limit: itemsPerPage)
            newDeliveries.forEach { delivery in
                modelContext.insert(delivery)
            }
            fetchDeliveryData()
            print(deliveries)
            currentPage += 1
        } catch {
            print("Error fetching deliveries: \(error)")
        }
        
        isLoading = false
    }
    
    func toggleFavorite(_ delivery: Delivery) {
        if let favourite = favorites.first(where: { $0.deliveryId == delivery.id }) {
            modelContext.delete(favourite)
        } else {
            print("inserting favorite")
            modelContext.insert(Favorite(deliveryId: delivery.id))
        }
        fetchfavoriteData()
    }
    
    func isFavorite(_ delivery: Delivery) -> Bool {
        return favorites.contains(where: { $0.deliveryId == delivery.id })
    }
    
    func clearDataInLocalStorage() {
        do {
            print("deleting favorites")
            try modelContext.delete(model: Favorite.self)
        } catch {
            print("Unable to clear local storage: \(error)")
        }
    }
}



