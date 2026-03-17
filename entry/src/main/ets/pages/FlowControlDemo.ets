import { window } from '@kit.ArkUI';

@Entry
@Component
struct FlowControlDemo {
  @State topSafeInset: number = 0;
  @State scoreText: string = '76';
  @State dayIndexText: string = '3';
  @State loopLimitText: string = '5';
  @State jumpLimitText: string = '10';

  @State selectionResult: string = '点击按钮查看选择结构结果';
  @State loopResult: string = '点击按钮查看循环结构结果';
  @State jumpResult: string = '点击按钮查看跳转语句结果';

  aboutToAppear(): void {
    this.updateTopSafeInset();
  }

  build() {
    Scroll() {
      Column({ space: 14 }) {
        this.pageHeader()
        this.selectionCard()
        this.loopCard()
        this.jumpCard()
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16 + this.topSafeInset, bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.demo_bg_page'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }

  @Builder
  private pageHeader() {
    Column({ space: 10 }) {
      Text('流程控制可视化演示')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.demo_text_primary'))
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('流程控制决定“代码何时执行、执行几次、在何处退出”。')
        .fontSize(13)
        .fontColor($r('app.color.demo_text_secondary'))
        .lineHeight(20)
        .width('100%')

      Row({ space: 8 }) {
        Button('运行全部演示')
          .type(ButtonType.Capsule)
          .backgroundColor($r('app.color.demo_accent_primary'))
          .fontColor($r('app.color.demo_on_accent'))
          .onClick(() => {
            this.runSelection();
            this.runLoop();
            this.runJump();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor($r('app.color.demo_bg_card'))
    .borderRadius(16)
  }

  @Builder
  private selectionCard() {
    Column({ space: 10 }) {
      Text('选择结构（if / else / switch）')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.demo_text_heading'))
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('if/else 用于区间判断，switch 适合离散分支匹配。')

      Row({ space: 8 }) {
        TextInput({ placeholder: '分数', text: this.scoreText })
          .onChange((value: string) => {
            this.scoreText = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: '星期(1-7)', text: this.dayIndexText })
          .onChange((value: string) => {
            this.dayIndexText = value;
          })
          .layoutWeight(1)
      }

      Button('演示选择结构')
      .alignSelf(ItemAlign.End)
        .onClick(() => {
          this.runSelection();
        })

      Text(this.selectionResult)
        .fontSize(14)
        .fontColor($r('app.color.demo_text_secondary'))
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(14)
    .backgroundColor($r('app.color.demo_bg_card'))
    .borderRadius(16)
  }

  @Builder
  private loopCard() {
    Column({ space: 10 }) {
      Text('循环结构（for / while / do...while）')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.demo_text_heading'))
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('for 常用于已知次数循环；while/do...while 适合条件驱动场景。')

      TextInput({ placeholder: '循环上限', text: this.loopLimitText })
        .onChange((value: string) => {
          this.loopLimitText = value;
        })

      Button('演示循环结构')
      .alignSelf(ItemAlign.End)
        .onClick(() => {
          this.runLoop();
        })

      Text(this.loopResult)
        .fontSize(14)
        .fontColor($r('app.color.demo_text_secondary'))
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(14)
    .backgroundColor($r('app.color.demo_bg_card'))
    .borderRadius(16)
  }

  @Builder
  private jumpCard() {
    Column({ space: 10 }) {
      Text('跳转语句（break / continue）')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.demo_text_heading'))
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('continue 跳过本次循环，break 立即终止整个循环。')

      TextInput({ placeholder: '遍历上限', text: this.jumpLimitText })
        .onChange((value: string) => {
          this.jumpLimitText = value;
        })

      Button('演示跳转语句')
      .alignSelf(ItemAlign.End)
        .onClick(() => {
          this.runJump();
        })

      Text(this.jumpResult)
        .fontSize(14)
        .fontColor($r('app.color.demo_text_secondary'))
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(14)
    .backgroundColor($r('app.color.demo_bg_card'))
    .borderRadius(16)
  }

  @Builder
  private principleNote(content: string) {
    Text(`原理说明：${content}`)
      .fontSize(12)
      .fontColor($r('app.color.demo_text_hint'))
      .lineHeight(18)
      .width('100%')
  }

  // 选择结构示例：同一输入分别走 if/else 和 switch 分支。
  private runSelection(): void {
    const score: number = this.toNumber(this.scoreText, 0);
    const dayIndex: number = this.toNumber(this.dayIndexText, 1);
    let level: string;
    if (score >= 90) {
      level = '优秀';
    } else if (score >= 75) {
      level = '良好';
    } else if (score >= 60) {
      level = '及格';
    } else {
      level = '需要加强';
    }

    let weekdayName: string;
    switch (dayIndex) {
      case 1:
        weekdayName = '星期一';
        break;
      case 2:
        weekdayName = '星期二';
        break;
      case 3:
        weekdayName = '星期三';
        break;
      case 4:
        weekdayName = '星期四';
        break;
      case 5:
        weekdayName = '星期五';
        break;
      case 6:
        weekdayName = '星期六';
        break;
      case 7:
        weekdayName = '星期日';
        break;
      default:
        weekdayName = '非法输入';
        break;
    }

    this.selectionResult = [
      `if / else 判断：分数 ${score} -> ${level}`,
      `switch 判断：${dayIndex} -> ${weekdayName}`
    ].join('\n');
  }

  // 循环结构示例：对比 for、while、do...while 的执行方式。
  private runLoop(): void {
    const limit: number = this.toNumber(this.loopLimitText, 1);
    if (!Number.isInteger(limit) || limit <= 0) {
      this.loopResult = '循环上限需为正整数，例如 5';
      return;
    }

    let forSum: number = 0;
    for (let i = 1; i <= limit; i++) {
      forSum += i;
    }

    let current: number = limit;
    const whileList: number[] = [];
    while (current > 0) {
      whileList.push(current);
      current--;
    }

    let doIndex: number = 1;
    let doTotal: number = 0;
    do {
      doTotal += doIndex;
      doIndex++;
    } while (doIndex <= limit);

    this.loopResult = [
      `for：1 到 ${limit} 的和 = ${forSum}`,
      `while：倒序序列 = ${whileList.join(', ')}`,
      `do...while：累计和 = ${doTotal}`
    ].join('\n');
  }

  // 跳转语句示例：continue 过滤偶数，break 提前退出。
  private runJump(): void {
    const limit: number = this.toNumber(this.jumpLimitText, 1);
    if (!Number.isInteger(limit) || limit <= 0) {
      this.jumpResult = '遍历上限需为正整数，例如 10';
      return;
    }

    const oddBeforeBreak: number[] = [];

    for (let i = 1; i <= limit; i++) {
      if (i % 2 === 0) {
        continue;
      }
      if (i > 7) {
        break;
      }
      oddBeforeBreak.push(i);
    }

    this.jumpResult = [
      'continue：跳过偶数',
      'break：当 i > 7 时退出循环',
      `结果序列：${oddBeforeBreak.join(', ')}`
    ].join('\n');
  }

  private toNumber(value: string, fallback: number): number {
    const parsed: number = Number(value);
    return Number.isNaN(parsed) ? fallback : parsed;
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











