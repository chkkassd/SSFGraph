# SSFGraph
|version|platform|license|
|---|---|---|
|1.0.2|iOS|MIT|
---
这是一个用函数式思想开发的图表库，参考了`《Functional Swift》`这本书，主要是思想上的改变，以前我们着重于如何画图，而现在我们先思考如何来描述一个图表，然后再去绘制它。默认提供了柱状图，折线图，散点图，并且提供了一系列组合算子给用户，可以让用户自己设计组装自己的图表。另外一个重要的思想是在描述图表的时候，使用函数来描述简单的图形，然后再使用一些拼接函数将简单图形拼装，最终组成想要的图表。

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
> 所有使用`SSFGraph`拼装而成的图表均是相对尺寸，会随着绘制这些图表的view的大小而等比例缩放
### 柱状图
```swift
        //数据源
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFBarGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
        //设置柱状条颜色
        graphView.barColor = UIColor.green
        //设置柱状条的边界颜色
        graphView.strokeColor = UIColor.black
        //设置字体颜色
        graphView.textColor = UIColor.darkGray
        //设置字体样式和大小
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(graphView)
```
### 折线图
```swift
        //数据源
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFLineGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
        //设置字体颜色
        graphView.textColor = UIColor.darkGray
        //设置字体样式和大小
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        //设置折线宽度
        graphView.lineWidth = 4.0
        //这只折线颜色
        graphView.lineColor = UIColor.red
        //在数据点是否突出显示
        graphView.isOutstanding = true
        self.view.addSubview(graphView)
```
### 散点图
```swift
        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        var graphView = SSFScatterGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
//        graphView.barColor = UIColor.green   //折线图和散点图默认无法改这个属性
//        graphView.strokeColor = UIColor.black //折线图和散点图默认无法改这个属性
        //设置字体颜色
        graphView.textColor = UIColor.darkGray
        //设置字体样式和大小
        graphView.textFont = UIFont.systemFont(ofSize: 16)
        //设置散点颜色
        graphView.scatterColor = UIColor.orange
        //设置散点样式
        graphView.scatterType = .circle//.circle表示圆形，.square表示正方形
        self.view.addSubview(graphView)
```
### 自定义绘图
在任意UIView内，使用下述api便可以绘制所能组合的图表。
#### 描述矩形
```swift
let blueRect = Diagram.rect(width: 30.0, height: 15.0)
```
#### 描述正方形
```swift
let redSquare = Diagram.square(side: 50.0)
```
#### 描述圆形
```swift
let greenCircle = Diagram.circle(diameter: 80.0)
```
#### 描述文字
```swift
let orangeText = Diagram.text(theText: "James Harden", width: 50.0, height: 10.0, textAttribute: [TextAttribute.font: UIFont.systemFont(ofSize: 20.0), TextAttribute.textColor: UIColor.orange])
```
> TextAttribute是enum用以描述文字属性
 ```swift
        public enum TextAttribute {
        case font
        case textColor
         }
```
#### 图表的填充色
```swift
blueRect.filled(UIColor.blue)
```
#### 图表的描边色
```swift
blueRect.stroked(UIColor.black)
```
#### 图表的对齐方式
```swift
blueRect.aligned(to: CGPoint.top)
```
#### 图表的组合拼装
```swift
let combinedDiagram = blueRect|||redSquare|||greenCircle---orangeText
```
> 拼接操作符
>> `|||`:水平方向拼接2个图表
>>> `---`:垂直方向拼接2个图表

#### 一个自定义拼装图表的例子
```swift
override func draw(_ rect: CGRect) {
//rect
let blueRect = Diagram.rect(width: 30.0, height: 15.0).filled(UIColor.blue).stroked(UIColor.black).aligned(to: CGPoint.top)
//square
let redSquare = Diagram.square(side: 50.0).filled(UIColor.red).stroked(UIColor.black).aligned(to: CGPoint.top)
//circle
let greenCircle = Diagram.circle(diameter: 80.0).filled(UIColor.green).stroked(UIColor.black).aligned(to: CGPoint.top)
//text
let orangeText = Diagram.text(theText: "James Harden", width: 50.0, height: 10.0, textAttribute: [TextAttribute.font: UIFont.systemFont(ofSize: 20.0), TextAttribute.textColor: UIColor.orange]).aligned(to: CGPoint.top)
let combinedDiagram = blueRect|||redSquare|||greenCircle---orangeText

let context = UIGraphicsGetCurrentContext()
context?.draw(combinedDiagram, in: rect)
}
```
## 联系方式
* [微博](https://weibo.com/u/2138535555 "PETER的微博")
* 邮箱:peter1990lynn@gmail.com

## 版权
SSFGraph is released under the MIT license.[See LICENSE](https://github.com/chkkassd/SSFGraph/blob/master/LICENSE)for details.
