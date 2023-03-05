//
//  HomeView.swift
//  Crypto
//
//  Created by Sebastian Cioată on 05.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortofolio: Bool = false
    
    var body: some View {
        ZStack{
            
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                homeHeader
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
}
