//
//  File.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/2.
//

import Foundation

//let kLoginURL: URL = URL(from: "http://localhost:9090/User/login")
let kIP = "http://192.168.31.9:9090"

//用户相关
let kUrlGetAllUser = "\(kIP)/User/getAllUser"

let kUrlLogin = "\(kIP)/User/login"

let kUrlGetCurrentUser = "\(kIP)/User/getCurrentUser"

//笔记相关

let kUrlSaveNote = "\(kIP)/Note/saveNote"

let kUrlSaveNoteResult = "\(kIP)/Note/saveNoteResult"

let kUrlUploadCoverPhoto = "\(kIP)/Note/uploadCoverPhoto"

let kUrlUploadCoverPhoto2 = "\(kIP)/Note/uploadCoverPhoto2"

let kUrlGetAllNotes = "\(kIP)/Note/getAllNotes"

let kUrlNotePages = "\(kIP)/Note/page"



