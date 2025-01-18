//
//  SettingsView.swift
//  CryptoAttic
//
//  Created by Tanmay . on 17/01/25.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/tanmayxx12")!
    let linkedInURL = URL(string: "https://www.linkedin.com/in/tanmay-roy-462772245/")!
    let xURL = URL(string: "https://x.com/tanmayxx_")!
    let nicksLinkedInURL = URL(string: "https://www.linkedin.com/in/nicholassarno/")!
    let nicksWebsiteURL = URL(string: "https://www.swiftful-thinking.com/")!
    
    var body: some View {
        NavigationStack {
            List{
                mentionSection
                
                coinGeckoSection
                
                developerSection
                
                personalSection
                
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    private var mentionSection: some View {
        Section("Crypto Attic") {
            VStack {
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .padding(.vertical, 5)
                
                Text("Developed CryptoAttic as part of learning iOS development, inspired by a course taught by Nick Sarno from his youtube channel - Swiftful Thinking.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                
            }
            .padding(.vertical, 5)
            
            Link("SwiftfulThinking", destination: nicksWebsiteURL)
                .tint(.blue)
            Link("Nick's LinkedIn", destination: nicksLinkedInURL)
                .tint(.blue)
        }
    }
    
    private var coinGeckoSection: some View {
        Section("Coin Gecko") {
            VStack(alignment: .leading) {
                
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The app retrieves and displays live cryptocurrency prices, market trends, and other relevant information, leveraging CoinGecko’s comprehensive and well-documented API. The information might be delayed")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical, 5)
            
            Link("Visit CoinGecko", destination: coinGeckoURL)
                .tint(.blue)
            
        }
    }
    
    private var developerSection: some View {
        Section("Developer") {
            VStack {
                Image("technologiesUsedIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Developed CryptoAttic using 100% Swift and SwiftUI, designed with the MVVM architecture for clean and maintainable code. The app leverages Combine for efficient network calls to fetch real-time cryptocurrency data and uses CoreData for seamless offline data persistence. It provides an intuitive, responsive UI, ensuring a smooth user experience while showcasing expertise in modern iOS development practices.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                    
            }
            .padding(.vertical, 5)
        }
    }
    
    private var personalSection: some View {
        Section("Personal Details") {
            VStack {
                Text("""
                     I'm a self-taught iOS developer with a background in business, transitioning into
                     the exciting world of app development. My journey has been fueled by curiosity,
                     persistence, and a passion for creating meaningful digital experiences. 
                     This application is one of my first steps into building projects that bring ideas to
                     life, and I'm thrilled to share it with you.
                     If you'd like to learn more about me or connect, feel free to visit my socials: 
                     """)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(Color.theme.accent)
                
                HStack(spacing: 50){
                    // Github
                    Image("githublogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // LinkedIn
                    Image("linkedinLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // X
                    Image("xLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            Link("Github", destination: githubURL)
                .tint(.blue)
            Link("LinkedIn", destination: linkedInURL)
                .tint(.blue)
            Link("X(formerly Twitter)", destination: xURL)
                .tint(.blue)
        }
    }
}


