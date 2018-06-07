# SSFGraph
|version|platform|license|
|---|---|---|
|1.0.1|iOS|MIT|
---
这是一个用函数式思想开发的图表库，参考了`《Functional Swift》`这本书，主要是思想上的改变，以前我们着重于如何画图，而现在我们先思考如何来描述一个图表，然后再去绘制它。默认提供了柱状图，折线图，散点图，并且提供了一个`SSFGraphview`，可以让用户自己设计组装自己的图表。另外一个重要的思想是在描述图表的时候，使用函数来描述简单的图形，然后再使用一些拼接函数将简单图形拼装，最终组成想要的图表。

---
## 效果图
![图表效果图](/SSFGraphShow.gif "图表效果图")

## 环境要求
* iOS9.0+
* swift4.0

## 安装
### Carthage
```
github "chkkassd/SSFGraph"
```

## 使用说明
### 柱状图
```swift
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFBarGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
        graphView.barColor = UIColor.green
        graphView.strokeColor = UIColor.black
        graphView.textColor = UIColor.darkGray
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(graphView)
```
### 折线图
```swift
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFLineGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
        graphView.textColor = UIColor.darkGray
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        graphView.lineWidth = 4.0
        graphView.lineColor = UIColor.red
        graphView.isOutstanding = true
        self.view.addSubview(graphView)
```
### 散点图
```swift
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFScatterGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
//        graphView.barColor = UIColor.green   //折线图和散点图默认无法改这个属性
//        graphView.strokeColor = UIColor.black //折线图和散点图默认无法改这个属性
        graphView.textColor = UIColor.darkGray
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        graphView.scatterColor = UIColor.orange
        graphView.scatterType = .circle
        self.view.addSubview(graphView)
```
### 自定义绘图
> 有待完善

## 联系方式
* [微博](https://weibo.com/u/2138535555 "PETER的微博")
* 邮箱:peter1990lynn@gmail.com

## 版权
SSFGraph is released under the MIT license.[See LICENSE]()for details.
