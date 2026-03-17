import { window } from '@kit.ArkUI';

enum LearnStage {
  START = 0,
  BASIC = 1,
  ADVANCED = 2,
  MASTER = 3
}

@Entry
@Component
struct ArrayEnumDemo {
  @State topSafeInset: number = 0;
  @State listText: string = '18,23,5,12';
  @State newNumberText: string = '30';
  @State arrayData: number[] = [18, 23, 5, 12];
  @State arrayResult: string = '点击按钮查看数组演示结果';

  @State selectedStage: LearnStage = LearnStage.START;
  @State enumResult: string = '点击下方按钮查看枚举演示结果';

  aboutToAppear(): void {
    this.updateTopSafeInset();
  }

  build() {
    Scroll() {
      Column({ space: 14 }) {
        this.pageHeader()
        this.arrayCard()
        this.enumCard()
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16 + this.topSafeInset, bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F6FB')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }

  @Builder
  private pageHeader() {
    Column({ space: 10 }) {
      Text('数组和枚举可视化演示')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1A2333')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('数组用于有序数据处理，枚举用于表达有限状态。')
        .fontSize(13)
        .fontColor('#52607A')
        .lineHeight(20)
        .width('100%')

      Row({ space: 8 }) {
        Button('运行全部演示')
          .type(ButtonType.Capsule)
          .backgroundColor('#0B6BEE')
          .fontColor('#FFFFFF')
          .onClick(() => {
            this.resetArrayByText();
            this.runArrayDemo();
            this.updateEnumResult();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  @Builder
  private arrayCard() {
    Column({ space: 10 }) {
      Text('数组演示')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('通过增删改查操作，观察数组长度、元素顺序与映射结果变化。')

      TextInput({ placeholder: '数组初始化（逗号分隔）', text: this.listText })
        .onChange((value: string) => {
          this.listText = value;
        })

      TextInput({ placeholder: '新增数字', text: this.newNumberText })
        .onChange((value: string) => {
          this.newNumberText = value;
        })

      Row({ space: 8 }) {
        Button('按输入重置')
          .onClick(() => {
            this.resetArrayByText();
          })
          .layoutWeight(1)
        Button('push 新元素')
          .onClick(() => {
            this.appendNewValue();
          })
          .layoutWeight(1)
      }

      Row({ space: 8 }) {
        Button('shift 删除首项')
          .onClick(() => {
            this.removeFirstValue();
          })
          .layoutWeight(1)
        Button('sort 升序')
          .onClick(() => {
            this.sortArray();
          })
          .layoutWeight(1)
      }

      Button('综合演示数组操作')
        .onClick(() => {
          this.runArrayDemo();
        })

      Text(`当前数组：${this.arrayData.join(', ')}`)
        .fontSize(14)
        .fontColor('#1B4A8A')
        .width('100%')
      Text(this.arrayResult)
        .fontSize(14)
        .fontColor('#52607A')
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(14)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  @Builder
  private enumCard() {
    Column({ space: 10 }) {
      Text('枚举演示')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('枚举把“状态值”映射为可读名称，便于状态流转与分支处理。')

      Row({ space: 8 }) {
        Button('入门')
          .onClick(() => {
            this.selectedStage = LearnStage.START;
            this.updateEnumResult();
          })
          .layoutWeight(1)
        Button('基础')
          .onClick(() => {
            this.selectedStage = LearnStage.BASIC;
            this.updateEnumResult();
          })
          .layoutWeight(1)
      }

      Row({ space: 8 }) {
        Button('进阶')
          .onClick(() => {
            this.selectedStage = LearnStage.ADVANCED;
            this.updateEnumResult();
          })
          .layoutWeight(1)
        Button('精通')
          .onClick(() => {
            this.selectedStage = LearnStage.MASTER;
            this.updateEnumResult();
          })
          .layoutWeight(1)
      }

      Text(this.enumResult)
        .fontSize(14)
        .fontColor('#52607A')
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(14)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
  }

  @Builder
  private principleNote(content: string) {
    Text(`原理说明：${content}`)
      .fontSize(12)
      .fontColor('#6A7892')
      .lineHeight(18)
      .width('100%')
  }

  // 将输入文本解析成 number[]，用于重置演示数组。
  private resetArrayByText(): void {
    const values: number[] = this.parseNumberList(this.listText);
    this.arrayData = values.length > 0 ? values : [0];
    this.arrayResult = `已重置数组，当前长度：${this.arrayData.length}`;
  }

  // push 示例：向数组尾部添加一个元素。
  private appendNewValue(): void {
    const value: number = this.toNumber(this.newNumberText, 0);
    this.arrayData = [...this.arrayData, value];
    this.arrayResult = `push(${value}) 后数组：${this.arrayData.join(', ')}`;
  }

  // shift 示例：删除并返回数组首项。
  private removeFirstValue(): void {
    if (this.arrayData.length === 0) {
      this.arrayResult = '数组为空，无法删除首项';
      return;
    }
    const copied: number[] = [...this.arrayData];
    const removed: number | undefined = copied.shift();
    this.arrayData = copied;
    this.arrayResult = `shift 删除首项 ${removed} 后：${this.arrayData.join(', ')}`;
  }

  // sort 示例：按数值升序排序（非字典序）。
  private sortArray(): void {
    const sorted: number[] = [...this.arrayData].sort((a: number, b: number) => a - b);
    this.arrayData = sorted;
    this.arrayResult = `排序后：${this.arrayData.join(', ')}`;
  }

  // 数组综合示例：演示 length、find、map 等常见能力。
  private runArrayDemo(): void {
    const copied: number[] = [...this.arrayData];
    const first: number | undefined = copied[0];
    const last: number | undefined = copied[copied.length - 1];
    const found: number | undefined = copied.find((item: number) => item > 20);
    const mapped: number[] = copied.map((item: number) => item * 2);
    this.arrayResult = [
      `长度 length = ${copied.length}`,
      `首项 first = ${first}, 尾项 last = ${last}`,
      `find(>20) = ${found === undefined ? '未找到' : found}`,
      `map(*2) = ${mapped.join(', ')}`
    ].join('\n');
  }

  // 枚举综合示例：将状态值映射成可读名称与提示文案。
  private updateEnumResult(): void {
    let title: string;
    let tip: string;
    switch (this.selectedStage) {
      case LearnStage.START:
        title = 'START';
        tip = '建议先掌握基础语法和组件结构。';
        break;
      case LearnStage.BASIC:
        title = 'BASIC';
        tip = '可以开始写状态管理和页面跳转。';
        break;
      case LearnStage.ADVANCED:
        title = 'ADVANCED';
        tip = '建议加入网络请求、持久化和模块拆分。';
        break;
      case LearnStage.MASTER:
        title = 'MASTER';
        tip = '继续优化性能、架构和测试覆盖率。';
        break;
      default:
        title = 'UNKNOWN';
        tip = '状态异常';
        break;
    }

    this.enumResult = [
      `当前枚举值：${this.selectedStage}`,
      `枚举名称：${title}`,
      `学习建议：${tip}`
    ].join('\n');
  }

  private parseNumberList(raw: string): number[] {
    const parts: string[] = raw.split(',');
    const result: number[] = [];
    for (let i = 0; i < parts.length; i++) {
      const part: string = parts[i].trim();
      if (part.length === 0) {
        continue;
      }
      const num: number = Number(part);
      if (!Number.isNaN(num)) {
        result.push(num);
      }
    }
    return result;
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






