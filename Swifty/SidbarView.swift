//
//  SidbarView.swift
//  Swifty
//
//  Created by Kylie Benfield on 12/16/21.
//

import SwiftUI


struct SidebarView: View {
    var body: some View {
        NavigationView {
            List {
//                NavigationLink(destination: ContentView()) {
//                    Label("Welcome", systemImage: "star")
//                }
//
//                Spacer()
                
//                Text("Examples")
//                    .font(.system(size: 14))
//                    .fontWeight(.bold)
                Group{
                    NavigationLink(destination: EmojiArtDocumentView(document: EmojiArtDocument())) {
                        Label("Emoji Art", systemImage: "house")
                    }
                    NavigationLink(destination: MatchGameView(gameView: EmojiMemoryGame())) {
                        Label("Match Game", systemImage: "rectangle.stack")
                    }
//                    NavigationLink(destination: ContentView()) {
//                        Label("Domains", systemImage: "link")
//                    }
//                    NavigationLink(destination: ContentView()) {
//                        Label("Templates", systemImage: "rectangle.stack")
//                    }
                }
                
//                Spacer()
                
//                Text("PROFILE")
//                    .font(.system(size: 10))
//                    .fontWeight(.bold)
//                Group {
//                    NavigationLink(destination: ContentView()) {
//                        Label("My Account", systemImage: "person")
//                    }
//                    NavigationLink(destination: ContentView()) {
//                        Label("Notifications", systemImage: "bell")
//                    }
//                    NavigationLink(destination: ContentView()) {
//                        Label("Settings", systemImage: "gear")
//                    }
//                }
//
//                Spacer()
//
//                Divider()
//                NavigationLink(destination: ContentView()) {
//                    Label("Sign Out", systemImage: "arrow.backward")
//                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Swifty")
            .frame(minWidth: 150, idealWidth: 350, maxWidth: 400)
//            .toolbar {
//                ToolbarItem(placement: .navigation) {
//                    Button(action: toggleSidebar, label: {
//                        Image(systemName: "sidebar.left")
//                    })
//                }
//            }
            
            ContentView()
        }
    }
}

// Toggle Sidebar Function
func toggleSidebar() {
//    SwiftyApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
