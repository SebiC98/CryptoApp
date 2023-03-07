//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Sebastian Cioată on 07.03.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portofolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
    
}
