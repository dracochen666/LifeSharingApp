//
//  Constant-Topic.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

//SubTopic例子
let kTopics: [String] = ["美食", "汽车", "音乐"]
//let kTopics: [String] = ["游戏"]

let kSubTopics: [String:[String]] = [
    "美食":["# 意式咖啡","# 冰美式","# 卡布奇诺","# 鸡尾酒", "# 苏格兰威士忌", "# 波本威士忌", " "],
    "汽车":["# 法拉利","# 兰博基尼","# 保时捷"],
    "音乐":["# 流行音乐","# 乡村音乐","# 华语音乐"]]

//正文空间placeholder
let kContentTextViewPlaceholder: String = "输入正文"

//话题选择数量
let kSubTopicLimit = 3
