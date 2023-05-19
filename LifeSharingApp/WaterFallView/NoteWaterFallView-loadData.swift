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

    func getNotes(_ pageNum: Int = 1, _ pageSize: Int = 4, _ getLargeData: Bool = false) -> [Note]{
        var group = DispatchGroup()
        tabBarViewController.showLoadingAni()
        group.enter()
        var notes: [Note] = []
        
        AF.request(kUrlNotePages+"?pageNum=\(pageNum)&pageSize=\(pageSize)",
                   method: .get,
                   headers: headers).responseDecodable(of: [Note].self) { response in

            print(response.data)
            if let data = response.data {
                
//                let decoder = JSONDecoder()
//                let dataArr = try? decoder.decode([Note].self, from: data)
//                for note in dataArr! {
//                    self.notes.append(note)
//                    print(note)
//                }
//                self.notes = data
//                print(data)
                let result = try? JSON(data: data )
                for noteRecord in result!["records"].arrayValue {
//                    print("noteRecord",noteRecord)
                    let note = Note()
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

//                    print(noteRecord["noteCoverPhoto"].stringValue)
//                    let data = noteRecord["noteCoverPhoto"].stringValue.data(using: .utf8, allowLossyConversion: false)
//                    print("data",data)
//                    let coverPhotoStr = try? JSONDecoder().decode(String.self, from: noteRecord["noteCoverPhoto"].rawData())
                    note.noteCoverPhoto = Base64Util.convertStrToImage(noteRecord["noteCoverPhoto"].stringValue)?.JPEGDataWithQuality(.medium)

                    if getLargeData {
                        note.notePhotos = noteRecord["notePhotos"].stringValue.data(using: .utf8)
                    }

//                    print(note.noteCoverPhoto)
                    self.notes.append(note)
                    notes.append(note)

                }
                print(self.notes)
                self.collectionView.reloadData()
            }
        }
        group.leave()
        group.notify(queue: .main) {
            tabBarViewController.hideLoadingAni()
            self.collectionView.reloadData()
            tabBarViewController.hideLoadingAni()
        }
        DispatchQueue.main.async {
//            let imageV = UIImageView(image: UIImage(systemName: "bolt.horizontal.icloud.fill"))
//            self.addSubview(imageV)
//            imageV.tintColor = .green
//            imageV.horizontalAnchors == self.horizontalAnchors - 100
//            imageV.verticalAnchors == self.verticalAnchors - 100
            self.collectionView.reloadData()
            tabBarViewController.hideLoadingAni()
        }

        return notes
    }
}
