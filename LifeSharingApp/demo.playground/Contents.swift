import UIKit

//func developApp(dayLearn: Int, techUse: String, developing: (Int, String) -> String) {
//    print("学习\(techUse)技术用了\(dayLearn)天,\(developing(10, "Weather"))")
//}
//
//developApp(dayLearn: 100, techUse: "Swift") { dayDevelop, appName in
//    "并用\(dayDevelop)天开发了\(appName)App"
//}
var topics: [String:[String]] = ["美食":["意式咖啡","冰美式","卡布奇诺"],
                                 "汽车":["法拉利","兰博基尼","柯尼塞格"],
                                 "音乐":["流行音乐","乡村音乐","华语音乐"]]
var dict1 = [1:"one",2:"two",3:"three"]//第一种
var dict2:[Int:String] = [1:"one",2:"two",3:"three"]//第二种
var dict3:Dictionary<Int,String> = [1:"one",2:"two",3:"three"]//第三种

print(topics.count)
print(topics.isEmpty)

print(topics[1]!)


