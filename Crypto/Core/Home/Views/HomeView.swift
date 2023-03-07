//
//  HomeView.swift
//  Crypto
//
//  Created by Sebastian Cioată on 05.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortofolio: Bool = false
    
    var body: some View {
        ZStack{
            
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                homeHeader
                
                columnTitles
                
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .padding(.horizontal)
                
                if !showPortofolio{
                    allCoinsList
                    .transition(.move(edge: .leading))
                    
                }
                if showPortofolio{
                    portofolioCoinsList
                        .transition(.move(edge:.trailing))
                }
               
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView{
    
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortofolio ? "plus" : "info")
                .animation(nil, value: showPortofolio)
                .background(
                CircleButtonAnimationView(animate: $showPortofolio)
                )
            Spacer()
            Text(showPortofolio ? "Portofolio" : "Live Prices")
                .animation(nil, value: showPortofolio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortofolio ? 180 : 0))
                .onTapGesture{
                    withAnimation(.spring()){
                        showPortofolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portofolioCoinsList: some View{
        List{
            ForEach(vm.portofolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortofolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
        }
    }
}
