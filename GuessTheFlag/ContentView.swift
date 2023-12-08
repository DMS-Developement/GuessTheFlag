//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Shimenko on 12/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var gameCounter = 0
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong: Thats the flag of \(countries[number])"
        }

        showingScore = true
        gameCounter += 1
        isGameOver()
    }
    
    func isGameOver() -> Void {
        switch gameCounter {
        case 8:
            showingGameOver = true
        default:
            showingGameOver = false
        }
    }
    
    func resetGame() -> Void {
        gameCounter = 0
        score = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $showingGameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score was \(score), try again!")
        }
    }
}

#Preview {
    ContentView()
}
