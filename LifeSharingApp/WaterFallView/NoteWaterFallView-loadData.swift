//
//  NoteWaterFall-loadData.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/10.
//

import UIKit
import Anchorage
import CoreData
import Alamofire
import SwiftyJSON

extension NoteWaterFallView {
    
    func getDraftNotes() {
        let fetchRequest = DraftNote.fetchRequest() as! NSFetchRequest<DraftNote>
        //设置分页 每次刷新增加5
        fetchRequest.fetchLimit = 20
        fetchRequest.fetchOffset = 0
        //设置筛选
//        fetchRequest.predicate = NSPredicate(format: "title=%@", "风景")
        let draftNotes = try? context.fetch(fetchRequest)
        self.drafts = draftNotes!
    }
    func JSONStringToData(_ jsonString: String) -> Data? {
            let data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            return data
    }
    
    enum RequestType {
        case getDraft
        case getAll
        case getPublished
        case getLiked
    }
    
    func getNotes(userId: Int,_ getLargeData: Bool = false, requestType: RequestType){
        let pageNum = 1
        let pageSize = 30
//        let group = DispatchGroup()
//        tabBarViewController.showLoadingAni()
//        group.enter()
        print(userId)
        var notes: [Note] = []
        var requestUrl = ""
        switch requestType {
        case .getDraft:
            return
        case .getAll:
//            print("getAll")
            requestUrl = kUrlNotePages+"?pageNum=\(pageNum)&pageSize=\(pageSize)"
        case .getPublished:
            print("getPublished")
            requestUrl = kUrlGetNotePublished+"?userId=\(userId)"
        case .getLiked:
            requestUrl = kUrlNotePages+"?pageNum=\(pageNum)&pageSize=\(pageSize)"
//            print("getLiked")
        }
        print("查询前Url：\(requestUrl)")
        AF.request(requestUrl,
                   method: .get,
                   headers: headers).response { response in
            print("查询时Url：\(requestUrl)")
            print("正在查询..")
            if let data = response.data, let result = try? JSON(data: data ){
                print("noteRecord",result["records"])
                var resultArr = result["records"].arrayValue
                if self.isGetPublished {
                    resultArr = result.arrayValue
                }
//                self.isGetAll ? result["records"].arrayValue : result.arrayValue
                for noteRecord in resultArr {
//                    print("noteRecord",result["records"])
                    let note = Note()
                    note.noteId = noteRecord["noteId"].intValue
                    note.noteTitle = noteRecord["noteTitle"].stringValue
                    note.noteContent = noteRecord["noteContent"].stringValue
                    note.topics = noteRecord["noteTopics"].stringValue
                    note.subtopics = noteRecord["noteSubtopics"].stringValue
                    note.notePositions = noteRecord["notePositions"].stringValue
                    note.createTime = DateFormatter().date(from: noteRecord["create_time"].stringValue)
                    note.noteComments = noteRecord["noteComments"].stringValue
                    note.noteOwner = noteRecord["noteOwner"].intValue
                    note.noteLikedNumber = noteRecord["noteLikedNumber"].intValue
                    note.noteCollectedNumber = noteRecord["noteCollectedNumber"].intValue

                    let decoder = JSONDecoder()
                    if let imageBase64 = noteRecord["noteCoverPhoto"].string {
//                        print("file")
                        let imageNSData = NSData(base64Encoded: imageBase64)
                        let imageData = Data(referencing: imageNSData!)
                        let coverPhotoData = try? decoder.decode(Data.self, from: imageData)
                        note.noteCoverPhoto = coverPhotoData
                    }
                    if getLargeData {
                        if let imageBase64 = noteRecord["notePhotos"].string {
//                            print("file")
                            let imageBase64 = NSData(base64Encoded: imageBase64)
                            let imageData = Data(referencing: imageBase64!)
                            let photosDataArr = try? decoder.decode(Data.self, from: imageData)
                            note.notePhotos = photosDataArr
                        }
                    }

                    self.notes.append(note)
                    notes.append(note)

                }
                
                self.collectionView.reloadData()
//                tabBarViewController.hideLoadingAni()
                
            }
        }
//        group.leave()
//        group.notify(queue: .main) {
//            self.collectionView.reloadData()
//            tabBarViewController.hideLoadingAni()
//
//        }
//        DispatchQueue.main.async {
//
//            self.collectionView.reloadData()
//            tabBarViewController.hideLoadingAni()
//        }

//        return notes
    }
}
