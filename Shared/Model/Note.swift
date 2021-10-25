//
//  Notes.swift
//  NotesMac (iOS)
//
//  Created by Mac on 25/10/2021.
//

import SwiftUI

 //note model  and simple notes
struct  Note : Identifiable{
    var id = UUID().uuidString
    var note :String
    var date:Date
    var cardcolor :Color
     
}

func getSampleData(offset : Int)->Date{
    let clender = Calendar.current
    let date = clender.date(byAdding: .day, value: offset, to: Date())
        return date  ?? Date()
}

var notes :[Note] = [
    
             Note(note: "the old is always gold lets see whats hepend in future", date: getSampleData(offset: 1), cardcolor: Color("Orange")),
             
             Note(note: "the old is always gold lets see whats hepend in future", date: getSampleData(offset: -10), cardcolor: Color("Purple")),
             
             Note(note: "the old is always gold lets see whats hepend in future", date: getSampleData(offset: -15), cardcolor: Color("Blue")),
             
             Note(note: "the old is always gold lets see whats hepend in future", date: getSampleData(offset: 10), cardcolor: Color("Green")),
             
             Note(note: "the old is always gold lets see whats hepend in future", date: getSampleData(offset: 3), cardcolor: Color("Skin"))
]
