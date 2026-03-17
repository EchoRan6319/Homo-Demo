import { window } from '@kit.ArkUI';

@Entry
@Component
struct OperatorsDemo {
  @State topSafeInset: number = 0;
  @State numberA: string = '12';
  @State numberB: string = '5';
  @State wordA: string = 'Harmony';
  @State wordB: string = 'Next';
  @State assignSeed: string = '10';
  @State compareStringLeft: string = '08';
  @State compareStringRight: string = '8';
  @State compareNumberLeft: string = '8';
  @State compareNumberRight: string = '12';
  @State logicLeft: boolean = true;
  @State logicRight: boolean = false;
  @State ageText: string = '17';
  @State typeInput: string = '123';

  @State arithmeticResult: string = '点击按钮查看算数运算符结果';
  @State stringResult: string = '点击按钮查看字符串运算符结果';
  @State assignmentResult: string = '点击按钮查看赋值运算符结果';
  @State comparisonResult: string = '点击按钮查看比较运算符结果';
  @State logicResult: string = '点击按钮查看逻辑运算符结果';
  @State ternaryResult: string = '点击按钮查看三元运算符结果';
  @State typeCheckResult: string = '点击按钮查看类型检测运算符结果';
  @State priorityResult: string = '点击按钮查看运算符优先级结果';

  aboutToAppear(): void {
    this.updateTopSafeInset();
  }

  build() {
    Scroll() {
      Column({ space: 14 }) {
        this.pageHeader()
        this.arithmeticCard()
        this.stringCard()
        this.assignmentCard()
        this.comparisonCard()
        this.logicCard()
        this.ternaryCard()
        this.typeCheckCard()
        this.priorityCard()
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
      Text('运算符可视化演示')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1A2333')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('先看每个卡片的“原理说明”，再修改输入并观察结果。')
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
  private arithmeticCard() {
    Column({ space: 10 }) {
      Text('算数运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('算数运算符用于数值计算，重点观察除零与取模的边界行为。')

      Row({ space: 8 }) {
        TextInput({ placeholder: 'A', text: this.numberA })
          .onChange((value: string) => {
            this.numberA = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: 'B', text: this.numberB })
          .onChange((value: string) => {
            this.numberB = value;
          })
          .layoutWeight(1)
      }

      Button('演示 + - * / %')
        .onClick(() => {
          this.runArithmetic();
        })

      Text(this.arithmeticResult)
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
  private stringCard() {
    Column({ space: 10 }) {
      Text('字符串运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('字符串可通过 + 或模板字符串拼接，结果长度会随拼接内容变化。')

      Row({ space: 8 }) {
        TextInput({ placeholder: '字符串1', text: this.wordA })
          .onChange((value: string) => {
            this.wordA = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: '字符串2', text: this.wordB })
          .onChange((value: string) => {
            this.wordB = value;
          })
          .layoutWeight(1)
      }

      Button('演示字符串拼接')
        .onClick(() => {
          this.runString();
        })

      Text(this.stringResult)
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
  private assignmentCard() {
    Column({ space: 10 }) {
      Text('赋值运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('复合赋值会在“读取旧值 -> 计算 -> 写回新值”中一步完成。')

      TextInput({ placeholder: '初始值', text: this.assignSeed })
        .onChange((value: string) => {
          this.assignSeed = value;
        })

      Button('演示 = += -= *= /=')
        .onClick(() => {
          this.runAssignment();
        })

      Text(this.assignmentResult)
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
  private comparisonCard() {
    Column({ space: 10 }) {
      Text('比较运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('同一类型比较更直观：字符串按字典序，数字按数值大小。')

      Text('字符串组（按字符串字典序比较）')
        .fontSize(13)
        .fontColor('#52607A')
        .width('100%')

      Row({ space: 8 }) {
        TextInput({ placeholder: '字符串左值', text: this.compareStringLeft })
          .onChange((value: string) => {
            this.compareStringLeft = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: '字符串右值', text: this.compareStringRight })
          .onChange((value: string) => {
            this.compareStringRight = value;
          })
          .layoutWeight(1)
      }

      Text('数字组（先转 number 再比较）')
        .fontSize(13)
        .fontColor('#52607A')
        .width('100%')

      Row({ space: 8 }) {
        TextInput({ placeholder: '数字左值', text: this.compareNumberLeft })
          .onChange((value: string) => {
            this.compareNumberLeft = value;
          })
          .layoutWeight(1)
        TextInput({ placeholder: '数字右值', text: this.compareNumberRight })
          .onChange((value: string) => {
            this.compareNumberRight = value;
          })
          .layoutWeight(1)
      }

      Button('演示 == === > < >= <=')
        .onClick(() => {
          this.runComparison();
        })

      Text(this.comparisonResult)
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
  private logicCard() {
    Column({ space: 10 }) {
      Text('逻辑运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('&& 和 || 会根据真假值组合结果，! 用于取反。')

      Row({ space: 10 }) {
        Button(`左值: ${this.logicLeft ? 'true' : 'false'}`)
          .onClick(() => {
            this.logicLeft = !this.logicLeft;
          })
          .layoutWeight(1)
        Button(`右值: ${this.logicRight ? 'true' : 'false'}`)
          .onClick(() => {
            this.logicRight = !this.logicRight;
          })
          .layoutWeight(1)
      }

      Button('演示 && || !')
        .onClick(() => {
          this.runLogic();
        })

      Text(this.logicResult)
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
  private ternaryCard() {
    Column({ space: 10 }) {
      Text('三元运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('三元运算符是 if/else 的表达式写法：condition ? A : B。')

      TextInput({ placeholder: '请输入年龄', text: this.ageText })
        .onChange((value: string) => {
          this.ageText = value;
        })

      Button('演示 condition ? A : B')
        .onClick(() => {
          this.runTernary();
        })

      Text(this.ternaryResult)
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
  private typeCheckCard() {
    Column({ space: 10 }) {
      Text('数据类型检测运算符')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('typeof 判断基础类型，instanceof 常用于判断对象是否属于某个构造类型。')

      TextInput({ placeholder: '输入值（如 123 / true / null / hello）', text: this.typeInput })
        .onChange((value: string) => {
          this.typeInput = value;
        })

      Button('演示 typeof / instanceof')
        .onClick(() => {
          this.runTypeCheck();
        })

      Text(this.typeCheckResult)
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
  private priorityCard() {
    Column({ space: 10 }) {
      Text('运算符优先级')
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1D2D44')
        .width('100%')
        .textAlign(TextAlign.Start)

      this.principleNote('先乘除后加减，逻辑与高于逻辑或；括号可以显式改变执行顺序。')

      Button('演示优先级差异')
        .onClick(() => {
          this.runPriority();
        })

      Text(this.priorityResult)
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
    this.runArithmetic();
    this.runString();
    this.runAssignment();
    this.runComparison();
    this.runLogic();
    this.runTernary();
    this.runTypeCheck();
    this.runPriority();
  }

  @Builder
  private principleNote(content: string) {
    Text(`原理说明：${content}`)
      .fontSize(12)
      .fontColor('#6A7892')
      .lineHeight(18)
      .width('100%')
  }

  // 算数运算示例：覆盖 + - * / %，并演示除零保护。
  private runArithmetic(): void {
    const a: number = this.toNumber(this.numberA, 0);
    const b: number = this.toNumber(this.numberB, 1);
    this.arithmeticResult = [
      `输入：a=${a}，b=${b}`,
      `a + b = ${a + b}`,
      `a - b = ${a - b}`,
      `a * b = ${a * b}`,
      `a / b = ${b === 0 ? '除数不能为 0' : (a / b).toFixed(2)}`,
      `a % b = ${b === 0 ? '除数不能为 0' : a % b}`
    ].join('\n');
  }

  // 字符串运算示例：对比 + 拼接与模板字符串。
  private runString(): void {
    const mergeByPlus: string = this.wordA + ' ' + this.wordB;
    const mergeByTemplate: string = `${this.wordA}-${this.wordB}`;
    this.stringResult = [
      `使用 + 拼接：${mergeByPlus}`,
      `模板字符串拼接：${mergeByTemplate}`,
      `拼接后长度：${mergeByPlus.length}`
    ].join('\n');
  }

  // 赋值运算示例：按顺序演示复合赋值的结果变化。
  private runAssignment(): void {
    const startValue: number = this.toNumber(this.assignSeed, 0);
    let value: number = startValue;
    const equalValue: number = value;
    value += 5;
    const plusEqual: number = value;
    value -= 3;
    const minusEqual: number = value;
    value *= 2;
    const multiplyEqual: number = value;
    value /= 4;
    const divideEqual: number = value;

    this.assignmentResult = [
      `初始：value = ${equalValue}`,
      `value += 5 -> ${plusEqual}`,
      `value -= 3 -> ${minusEqual}`,
      `value *= 2 -> ${multiplyEqual}`,
      `value /= 4 -> ${divideEqual.toFixed(2)}`
    ].join('\n');
  }

  // 比较运算示例：分别展示字符串比较与数字比较。
  private runComparison(): void {
    const strLeft: string = this.compareStringLeft.trim();
    const strRight: string = this.compareStringRight.trim();

    const numLeftRaw: string = this.compareNumberLeft.trim();
    const numRightRaw: string = this.compareNumberRight.trim();
    const numLeft: number = Number(numLeftRaw);
    const numRight: number = Number(numRightRaw);
    const numberValid: boolean = !Number.isNaN(numLeft) && !Number.isNaN(numRight);

    const stringLines: string[] = [
      '[字符串组]',
      `"${strLeft}" == "${strRight}" -> ${strLeft == strRight}`,
      `"${strLeft}" === "${strRight}" -> ${strLeft === strRight}`,
      `"${strLeft}" > "${strRight}" -> ${strLeft > strRight}`,
      `"${strLeft}" < "${strRight}" -> ${strLeft < strRight}`,
      `"${strLeft}" >= "${strRight}" -> ${strLeft >= strRight}`,
      `"${strLeft}" <= "${strRight}" -> ${strLeft <= strRight}`
    ];

    const numberLines: string[] = numberValid ? [
      '[数字组]',
      `${numLeft} == ${numRight} -> ${numLeft == numRight}`,
      `${numLeft} === ${numRight} -> ${numLeft === numRight}`,
      `${numLeft} > ${numRight} -> ${numLeft > numRight}`,
      `${numLeft} < ${numRight} -> ${numLeft < numRight}`,
      `${numLeft} >= ${numRight} -> ${numLeft >= numRight}`,
      `${numLeft} <= ${numRight} -> ${numLeft <= numRight}`
    ] : [
      '[数字组]',
      `输入无效：left="${numLeftRaw}", right="${numRightRaw}"`,
      '请填写可转换为 number 的值，例如 8 和 12'
    ];

    this.comparisonResult = [
      ...stringLines,
      '',
      ...numberLines,
      '',
      '说明：当两边本来就是同类型（都为 string 或都为 number）时，== 与 === 往往结果一致。'
    ].join('\n');
  }

  // 逻辑运算示例：观察 &&、||、! 在布尔值上的结果。
  private runLogic(): void {
    this.logicResult = [
      `left && right -> ${this.logicLeft && this.logicRight}`,
      `left || right -> ${this.logicLeft || this.logicRight}`,
      `!left -> ${!this.logicLeft}`,
      `!right -> ${!this.logicRight}`
    ].join('\n');
  }

  // 三元运算示例：输入校验后执行 condition ? A : B。
  private runTernary(): void {
    const rawAge: string = this.ageText.trim();
    if (rawAge.length === 0) {
      this.ternaryResult = '请输入年龄，例如 17 或 18';
      return;
    }

    const age: number = Number(rawAge);
    if (Number.isNaN(age) || !Number.isInteger(age) || age < 0) {
      this.ternaryResult = '年龄必须是非负整数，例如 17 或 18';
      return;
    }

    const level: string = age >= 18 ? '成年人' : '未成年人';
    const ticketType: string = age < 6 ? '免票' : age < 18 ? '学生票' : '全价票';
    this.ternaryResult = [
      `年龄 ${age} -> ${level}（条件：age >= 18）`,
      `嵌套三元示例：票种 = ${ticketType}`
    ].join('\n');
  }

  // 类型检测示例：typeof 与 instanceof 的常见用法。
  private runTypeCheck(): void {
    const parsedValue: string | number | boolean | null = this.parseDynamicValue(this.typeInput);
    const typeName: string = typeof parsedValue;
    const list: number[] = [1, 2, 3];
    const isArray: boolean = list instanceof Array;
    this.typeCheckResult = [
      `输入 "${this.typeInput}" 解析后为：${String(parsedValue)}`,
      `typeof 结果：${typeName}`,
      `list instanceof Array -> ${isArray}`
    ].join('\n');
  }

  // 优先级示例：通过对比表达式验证默认优先级与括号影响。
  private runPriority(): void {
    const expr1: number = 2 + 3 * 4;
    const expr2: number = (2 + 3) * 4;
    const expr3: boolean = true || false && false;
    const expr4: boolean = (true || false) && false;

    this.priorityResult = [
      `2 + 3 * 4 = ${expr1}（先乘后加）`,
      `(2 + 3) * 4 = ${expr2}（括号优先）`,
      `true || false && false = ${expr3}（&& 高于 ||）`,
      `(true || false) && false = ${expr4}（括号改变顺序）`
    ].join('\n');
  }

  private toNumber(value: string, fallback: number): number {
    const parsed: number = Number(value);
    return Number.isNaN(parsed) ? fallback : parsed;
  }

  private parseDynamicValue(raw: string): string | number | boolean | null {
    const value: string = raw.trim();
    if (value === 'true') {
      return true;
    }
    if (value === 'false') {
      return false;
    }
    if (value === 'null') {
      return null;
    }
    const parsedNumber: number = Number(value);
    if (value.length > 0 && !Number.isNaN(parsedNumber)) {
      return parsedNumber;
    }
    return value;
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



