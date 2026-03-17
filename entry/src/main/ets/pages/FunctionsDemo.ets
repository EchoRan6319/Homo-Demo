import { window } from '@kit.ArkUI';

@Entry
@Component
struct FunctionsDemo {
  @State topSafeInset: number = 0;
  @State functionNameText: string = 'ArkTS';
  @State customLengthText: string = '6';
  @State customWidthText: string = '4';
  @State valueInputText: string = '8';
  @State arrowListText: string = '3,5,8,12';
  @State builtInInputText: string = '42.75';

  @State knowFunctionResult: string = '点击按钮，认识函数是什么';
  @State customFunctionResult: string = '点击按钮，查看自定义函数执行结果';
  @State functionAsValueResult: string = '点击按钮，查看“函数作为值”';
  @State arrowFunctionResult: string = '点击按钮，查看箭头函数结果';
  @State builtInFunctionResult: string = '点击按钮，查看常用内置函数结果';

  aboutToAppear(): void {
    this.updateTopSafeInset();
  }

  build() {
    Scroll() {
      Column({ space: 14 }) {
        this.pageHeader()
        this.knowFunctionCard()
        this.customFunctionCard()
        this.functionAsValueCard()
        this.arrowFunctionCard()
        this.builtInFunctionCard()
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
      Text('函数可视化演示')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1A2333')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('函数用于封装可复用逻辑，重点理解“输入参数 -> 处理 -> 输出结果”。')
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
            this.runAll();
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
  private knowFunctionCard() {
    Column({ space: 10 }) {
      Text('认识函数')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('函数是带名字的代码块，可重复调用并返回结果。')

      Text('函数是“可复用的代码块”，输入参数后会产出结果。')
        .fontSize(14)
        .fontColor('#52607A')
        .lineHeight(22)
        .width('100%')

      TextInput({ placeholder: '输入名字', text: this.functionNameText })
        .onChange((value: string) => {
          this.functionNameText = value;
        })

      Button('执行示例函数')
        .onClick(() => {
          this.runKnowFunction();
        })

      Text(this.knowFunctionResult)
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
  private customFunctionCard() {
    Column({ space: 10 }) {
      Text('自定义函数')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('把业务计算封装成函数，避免重复写逻辑。')

      Row({ space: 8 }) {
        TextInput({ placeholder: '长', text: this.customLengthText })
          .onChange((value: string) => {
            this.customLengthText = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: '宽', text: this.customWidthText })
          .onChange((value: string) => {
            this.customWidthText = value;
          })
          .layoutWeight(1)
      }

      Button('执行自定义面积函数')
        .onClick(() => {
          this.runCustomFunction();
        })

      Text(this.customFunctionResult)
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
  private functionAsValueCard() {
    Column({ space: 10 }) {
      Text('将函数作为值使用')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('函数可赋值给变量，也可作为参数传入（回调模式）。')

      TextInput({ placeholder: '输入数字', text: this.valueInputText })
        .onChange((value: string) => {
          this.valueInputText = value;
        })

      Button('演示函数变量与回调')
        .onClick(() => {
          this.runFunctionAsValue();
        })

      Text(this.functionAsValueResult)
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
  private arrowFunctionCard() {
    Column({ space: 10 }) {
      Text('箭头函数')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('箭头函数常与 map/filter/reduce 搭配处理集合数据。')

      TextInput({ placeholder: '数字列表（逗号分隔）', text: this.arrowListText })
        .onChange((value: string) => {
          this.arrowListText = value;
        })

      Button('演示 map / filter / reduce')
        .onClick(() => {
          this.runArrowFunction();
        })

      Text(this.arrowFunctionResult)
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
  private builtInFunctionCard() {
    Column({ space: 10 }) {
      Text('常用内置函数')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('内置函数可直接调用，如 parseInt、parseFloat、Math、Date。')

      TextInput({ placeholder: '输入数字文本', text: this.builtInInputText })
        .onChange((value: string) => {
          this.builtInInputText = value;
        })

      Button('演示 parseInt / parseFloat / Math')
        .onClick(() => {
          this.runBuiltInFunctions();
        })

      Text(this.builtInFunctionResult)
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

  private runAll(): void {
    this.runKnowFunction();
    this.runCustomFunction();
    this.runFunctionAsValue();
    this.runArrowFunction();
    this.runBuiltInFunctions();
  }

  @Builder
  private principleNote(content: string) {
    Text(`原理说明：${content}`)
      .fontSize(12)
      .fontColor('#6A7892')
      .lineHeight(18)
      .width('100%')
  }

  // 基础函数示例：演示参数输入与字符串返回。
  private runKnowFunction(): void {
    const message: string = this.greet(this.functionNameText.trim());
    this.knowFunctionResult = [
      '函数签名：greet(name: string): string',
      `执行结果：${message}`
    ].join('\n');
  }

  // 自定义函数示例：计算矩形面积。
  private runCustomFunction(): void {
    const length: number = this.toNumber(this.customLengthText, 0);
    const width: number = this.toNumber(this.customWidthText, 0);
    const area: number = this.calculateRectangleArea(length, width);
    this.customFunctionResult = [
      '自定义函数：calculateRectangleArea(length, width)',
      `输入：length=${length}, width=${width}`,
      `输出：area=${area}`
    ].join('\n');
  }

  // 函数作为值示例：变量函数 + 回调函数。
  private runFunctionAsValue(): void {
    const base: number = this.toNumber(this.valueInputText, 0);
    const tripleFn: (value: number) => number = (value: number): number => value * 3;
    const plusFiveFn: (value: number) => number = (value: number): number => value + 5;

    const byVariable: number = tripleFn(base);
    const byCallback: number = this.applyFunction(base, plusFiveFn);

    this.functionAsValueResult = [
      '函数可赋值给变量，也可作为参数传入其他函数（回调）。',
      `变量函数 tripleFn(${base}) = ${byVariable}`,
      `回调函数 applyFunction(${base}, plusFiveFn) = ${byCallback}`
    ].join('\n');
  }

  // 箭头函数示例：map/filter/reduce 的典型用法。
  private runArrowFunction(): void {
    const values: number[] = this.parseNumberList(this.arrowListText);
    const doubled: number[] = values.map((item: number): number => item * 2);
    const filtered: number[] = values.filter((item: number): boolean => item >= 6);
    const sum: number = values.reduce((total: number, item: number): number => total + item, 0);

    this.arrowFunctionResult = [
      `原数组：${values.join(', ')}`,
      `map(item => item * 2)：${doubled.join(', ')}`,
      `filter(item => item >= 6)：${filtered.join(', ')}`,
      `reduce((t, item) => t + item, 0)：${sum}`
    ].join('\n');
  }

  // 内置函数示例：数字解析、Math 计算与时间戳获取。
  private runBuiltInFunctions(): void {
    const input: string = this.builtInInputText.trim();
    const parsedInt: number = parseInt(input, 10);
    const parsedFloat: number = parseFloat(input);
    const rounded: number = Math.round(parsedFloat);
    const maxValue: number = Math.max(parsedFloat, 50, 18);
    const parsedIntText: string = Number.isNaN(parsedInt) ? 'NaN（不是有效整数前缀）' : `${parsedInt}`;
    const parsedFloatText: string = Number.isNaN(parsedFloat) ? 'NaN（不是有效数字）' : `${parsedFloat}`;
    const roundedText: string = Number.isNaN(rounded) ? 'NaN' : `${rounded}`;
    const maxValueText: string = Number.isNaN(maxValue) ? 'NaN' : `${maxValue}`;

    this.builtInFunctionResult = [
      `parseInt("${input}", 10) = ${parsedIntText}`,
      `parseFloat("${input}") = ${parsedFloatText}`,
      `Math.round(${parsedFloatText}) = ${roundedText}`,
      `Math.max(${parsedFloatText}, 50, 18) = ${maxValueText}`,
      `Date.now() = ${Date.now()}`
    ].join('\n');
  }

  private greet(name: string): string {
    const finalName: string = name.length > 0 ? name : '同学';
    return `你好，${finalName}，欢迎学习函数。`;
  }

  private calculateRectangleArea(length: number, width: number): number {
    return length * width;
  }

  private applyFunction(value: number, fn: (num: number) => number): number {
    return fn(value);
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
    if (result.length === 0) {
      return [0];
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



