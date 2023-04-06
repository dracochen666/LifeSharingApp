//
//  Note.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

enum NoteType {
    case photoNote
    case videoNote
}
class Note {
    var noteTitle: String = ""
    var noteContent: String = ""
    var noteType: NoteType = .photoNote
    var notePhotoURL: [String] = []
    var noteVideoURL: String = ""
}
