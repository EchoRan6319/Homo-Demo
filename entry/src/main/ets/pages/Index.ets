import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State topSafeInset: number = 0;

  aboutToAppear(): void {
    this.updateTopSafeInset();
  }
  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('鸿蒙 ArkTS 学习 Demo')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A2333')
          .width('100%')
          .textAlign(TextAlign.Start)

        Text('通过可视化交互演示：运算符、流程控制、数组与枚举、函数。')
          .fontSize(15)
          .fontColor('#4A5568')
          .width('100%')
          .lineHeight(24)

        this.studyGuideCard()

        this.featureCard(
          '运算符演示',
          '算数、字符串、赋值、比较、逻辑、三元、类型检测和优先级。',
          'pages/OperatorsDemo'
        )
        this.featureCard(
          '流程控制演示',
          '选择结构、循环结构和跳转语句（break / continue）。',
          'pages/FlowControlDemo'
        )
        this.featureCard(
          '数组与枚举演示',
          '数组的增删查改和枚举状态切换。',
          'pages/ArrayEnumDemo'
        )
        this.featureCard(
          '函数演示',
          '认识函数、自定义函数、函数作为值、箭头函数与常用内置函数。',
          'pages/FunctionsDemo'
        )
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16 + this.topSafeInset, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F6FB')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }

  @Builder
  private featureCard(title: string, desc: string, pageUrl: string) {
    Column({ space: 12 }) {
      Text(title)
        .fontSize(21)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A2333')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text(desc)
        .fontSize(14)
        .fontColor('#52607A')
        .lineHeight(22)
        .width('100%')

      Button('进入演示')
        .type(ButtonType.Capsule)
        .fontSize(15)
        .onClick(() => {
          this.getUIContext().getRouter().pushUrl({ url: pageUrl });
        })
    }
    .padding(16)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  @Builder
  private studyGuideCard() {
    Column({ space: 8 }) {
      Text('学习说明')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A2333')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('1. 先看“原理说明”，理解该语法解决什么问题。')
        .fontSize(13)
        .fontColor('#52607A')
        .width('100%')
        .lineHeight(20)
      Text('2. 修改输入并点击按钮，观察结果如何变化。')
        .fontSize(13)
        .fontColor('#52607A')
        .width('100%')
        .lineHeight(20)
      Text('3. 用“运行全部演示”快速串联知识点。')
        .fontSize(13)
        .fontColor('#52607A')
        .width('100%')
        .lineHeight(20)
    }
    .padding(14)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  private updateTopSafeInset(): void {
    const hostContext = this.getUIContext().getHostContext();
    if (hostContext === undefined) {
      this.topSafeInset = 0;
      return;
    }
    window.getLastWindow(hostContext).then((lastWindow: window.Window) => {
      const avoidArea = lastWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.topSafeInset = this.getUIContext().px2vp(avoidArea.topRect.height);
    }).catch(() => {
      this.topSafeInset = 0;
    });
  }
}






