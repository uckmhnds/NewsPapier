//
//  HomeTabHeaderNews.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 2.10.2022.
//

import SwiftUI

struct HomeTabHeaderNews: View {
    
    private let colors: [Color] = [.red, .blue, .green, .orange, .black]
    
    @State private var topNews: [News] = [News]()
    
    var body: some View {
        HStack {
            TabView {
//                ForEach(colors, id: \.self) { color in
//                    ZStack {
//                        color
//                        Text("\(color.description)")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }
//                }
                Text("h")
                
                ForEach(topNews, id: \.self) { New in
                    ZStack {
                        Color(.systemCyan)
                        Text(New.title ?? "")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
            }
            .onAppear(){
                APICaller().getFewNews { result in
                    switch result {
                    case .success(let news):
                        self.topNews = news
                    case .failure(let error):
                        print(error.self)
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .cornerRadius(15)
            .padding(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeTabHeaderNews()
    }
    
}
