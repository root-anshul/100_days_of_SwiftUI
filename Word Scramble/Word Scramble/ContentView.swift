//
//  ContentView.swift
//  Word Scramble
//
//  Created by anshul on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWord = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWord,id:\.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                            
                        }
                       
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit {addNewWord()}
            .onAppear(perform: startgame)
//            .onAppear(perform: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
//        .padding()
    }
    
    
    func addNewWord(){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard word.count > 0  else {return}
        
        withAnimation {
            usedWord.insert(word, at: 0)
        }
        
        
        newWord = ""
    }
    
    func startgame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allwords = startWords.components(separatedBy: "\n")
                rootWord = allwords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("start.txt was not found")
    }
    
    func isOriginal(word:String) -> Bool{
        !usedWord.contains(word)
    }
    
    func isPossible(word:String)->Bool{
       var tempword = rootWord
        
        for letter in word{
            if let pos = tempword.firstIndex(of: letter){
                tempword.remove(at: pos)
            }else{
                return false
            }
            
            
        }
        return true
    }
    
    func isReal(word:String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: true, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    //    func checkSpell(){
//        let word = "swift"
//        let checker = UITextChecker()// Creates an instance of UITextChecker
//        let range = NSRange(location:0,length :word.utf16.count)
//        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//        
//        let allgood = misspelled.location == NSNotFound
//        
////  The UITextChecker checks the text “Hello world”.
////  If no spelling errors are found, misspelled.location will be NSNotFound, and allGood will be set to true.
////  If spelling errors are found, misspelled.location will hold the index of the first misspelled word, and allGood will be set to false.
//
//    }
    
    
//    func testBundle(){
//        if let url = Bundle.main.url(forResource: "somefile", withExtension: ".txt"){
//            if let fileContents = try? String(contentsOf: url){
//                //loaded Content of file in fileContents
//            }
//        }
//    }
    
}

#Preview {
    ContentView()
}
