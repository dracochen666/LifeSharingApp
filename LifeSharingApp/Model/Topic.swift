//
//  Topic.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/8.
//

import UIKit

class Topic {
    
    init(topics: [String], subTopics: [String:[String]]) {
        self.topics = topics
        self.subTopics = subTopics
    }
    
    var topics: [String] = []
    var subTopics: [String:[String]] = [:]
//    var sub: [[String]]
    
    //添加子话题
    func addSubTopic(topic: String, subTopic: String) {
        //查询topics中是否存在topic，若存在则直接在subTopics对应Key中追加
        //若不存在则先添加新topic至topics，再更新subTopics字典添加新键值对
        if topics.contains(topic) {
            subTopics[topic]?.append(subTopic)
        }else {
            topics.append(topic)
            subTopics.updateValue([subTopic], forKey: topic)
        }
    }
    //删除子话题
    func removeSubTopic(topic: String, subTopic: String) {
        if topics.contains(topic) {
            if let sub = subTopics[topic], sub.contains(subTopic) {
                let index = findSubTopicIndex(topic: topic, subTopic: subTopic)
                subTopics[topic]?.remove(at: index)
                if let sub = subTopics[topic], sub.count == 0 {
                    self.topics.remove(at: findTopicIndex(topic: topic))
                    subTopics.removeValue(forKey: topic)
                }
            }else {
                print("删除子话题失败！原因：未找到要删除的子话题")
            }
        }else {
            print("删除子话题失败！原因：未找到要删除的分类话题")
        }
    }
    //删除分类话题
    func removeTopic(topic: String) {
        if topics.contains(topic){
            topics.remove(at: findTopicIndex(topic: topic))
            subTopics.removeValue(forKey: topic)
        }else {
            print("删除话题失败，原因：未找到要删除的话题")
        }
    }
    
    //获取分类话题数
    func getCountOfTopics() -> Int{
        return topics.count
    }
    //获取子话题数
    func getCountOfSubtopics() -> Int{
        var count = 0
        for topic in topics {
            if let sub = subTopics[topic] {
                for _ in sub {
                    count += 1
                }
            }
        }
        return count
    }
    
    //查询分类话题数组中某些值的下标
    func findTopicIndex(topic: String) -> Int{
        if topics.contains(topic) {
            var index = 0
            for item in topics {
                if item == topic {
                    return index
                }
                index += 1
            }
        }
        return -1
    }
    //查询子话题数组中某些值的下标
    func findSubTopicIndex(topic: String, subTopic: String) -> Int{
        if topics.contains(topic) {
            var index = 0
            if let sub = subTopics[topic] {
                for item in sub {
                    if item == subTopic {
                        return index
                    }
                    index += 1
                }
            }
        }
        return -1
    }
    //因为字典中是无序的，所以需要通过Key(参数topic)进行搜索才能得到对应的Value
    func findSubTopicsInSubTopicsByTopic(topic: String) -> [String] {
        return subTopics[topic] ?? []
    }
}
