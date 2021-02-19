//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Egor Chernakov on 17.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "Russia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var score = 0
    
    struct FlagImage: View {
        let countryName: String
        
        var body: some View {
            Image("\(countryName)")
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1.0))
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, Color.green]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer]).foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        FlagImage(countryName: countries[number])
                    }
                }
                
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("OK"), action: {askQuestion()}))
        }
    }
    
    func flagTapped(_ tappedNumber: Int) {
        if tappedNumber == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[tappedNumber])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
