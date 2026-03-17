# Homo-Demo

![HarmonyOS](https://img.shields.io/badge/HarmonyOS-NEXT-0A59F7)
![ArkTS](https://img.shields.io/badge/Language-ArkTS-2563EB)
![ArkUI](https://img.shields.io/badge/UI-ArkUI-1D4ED8)
![API](https://img.shields.io/badge/API-6.0.2(22)-16A34A)
![License](https://img.shields.io/badge/License-GPLv3-F59E0B)

鸿蒙 Next（HarmonyOS NEXT）ArkTS 入门教学 Demo。

项目通过可视化交互页面，演示 ArkTS 常见语法与编程基础，适合新手边看边改边运行。

## 目录

- [项目亮点](#项目亮点)
- [功能概览](#功能概览)
- [页面路由](#页面路由)
- [技术栈](#技术栈)
- [运行环境](#运行环境)
- [快速开始](#快速开始)
- [项目结构](#项目结构)
- [界面预览](#界面预览)
- [UI 与安全区说明](#ui-与安全区说明)
- [学习路径建议](#学习路径建议)
- [常见问题](#常见问题)
- [后续扩展建议](#后续扩展建议)
- [License](#license)

## 项目亮点

- 四大主题模块，覆盖 ArkTS 入门高频语法
- 每个主题页都支持交互输入与实时结果反馈
- 每页提供“原理说明 + 运行全部演示”
- 示例尽量接近真实开发中的判断、计算与状态管理场景
- 包含沉浸式窗口与安全区处理思路，便于适配全面屏设备

## 功能概览

| 模块 | 主题 | 覆盖知识点 |
| --- | --- | --- |
| 运算符演示 (`OperatorsDemo`) | 运算表达式 | `+ - * / %`、字符串拼接、`= += -= *= /=`、`== === > < >= <=`、`&& || !`、三元运算符、`typeof`、`instanceof`、优先级 |
| 流程控制演示 (`FlowControlDemo`) | 分支与循环 | `if / else`、`switch`、`for`、`while`、`do...while`、`break`、`continue` |
| 数组与枚举演示 (`ArrayEnumDemo`) | 集合与状态 | `push`、`shift`、`sort`、`find`、`map`、枚举状态切换与文案映射 |
| 函数演示 (`FunctionsDemo`) | 函数编程基础 | 认识函数、自定义函数、函数作为值（回调）、箭头函数、内置函数（`parseInt`/`parseFloat`/`Math`/`Date.now`） |

## 页面路由

路由配置位于 `entry/src/main/resources/base/profile/main_pages.json`：

- `pages/Index`
- `pages/OperatorsDemo`
- `pages/FlowControlDemo`
- `pages/ArrayEnumDemo`
- `pages/FunctionsDemo`

## 技术栈

- HarmonyOS NEXT
- ArkTS
- ArkUI（声明式 UI）
- Stage 模型（`UIAbility`）

## 运行环境

- DevEco Studio（建议使用支持 API 22 的版本）
- SDK：`6.0.2(22)`（见 `build-profile.json5`）
- 设备类型：`phone`

## 快速开始

1. 使用 DevEco Studio 打开项目目录：`Homo-Demo`
2. 等待依赖与索引完成
3. 连接模拟器或真机
4. 点击运行（Run）

命令行构建（可选）：

```bash
hvigorw --mode module -p module=entry@default -p product=default -p requiredDeviceType=phone assembleHap
```

## 项目结构

```text
Homo-Demo
├─ AppScope/
├─ entry/
│  └─ src/main/
│     ├─ ets/
│     │  ├─ entryability/EntryAbility.ets
│     │  ├─ entrybackupability/EntryBackupAbility.ets
│     │  └─ pages/
│     │     ├─ Index.ets
│     │     ├─ OperatorsDemo.ets
│     │     ├─ FlowControlDemo.ets
│     │     ├─ ArrayEnumDemo.ets
│     │     └─ FunctionsDemo.ets
│     ├─ module.json5
│     └─ resources/base/profile/main_pages.json
├─ build-profile.json5
└─ oh-package.json5
```

## 界面预览

建议在仓库新增截图目录：`docs/images/`，并放入以下文件：

- `docs/images/home.png`
- `docs/images/operators.png`
- `docs/images/flow-control.png`
- `docs/images/array-enum.png`
- `docs/images/functions.png`

然后在 README 中启用：

```markdown
![首页](docs/images/home.png)
![运算符页](docs/images/operators.png)
![流程控制页](docs/images/flow-control.png)
![数组与枚举页](docs/images/array-enum.png)
![函数页](docs/images/functions.png)
```

## UI 与安全区说明

项目已包含沉浸式相关处理：

- 在 `EntryAbility.ets` 中设置窗口全屏与系统栏属性
- 各页面通过 `window.getWindowAvoidArea(...)` 计算顶部避让高度
- 页面统一使用 `expandSafeArea` 处理底部沉浸

如果在某些设备出现状态栏/导航条遮挡，优先检查：

- `EntryAbility.configureImmersiveMode()` 是否执行成功
- 页面顶部 `padding` 是否叠加了动态 `topSafeInset`
- 页面布局是否用了不合理固定高度

## 学习路径建议

1. 从首页进入任意模块，先读“原理说明”
2. 修改输入并观察结果变化
3. 点击“运行全部演示”做整体验证
4. 尝试新增一个卡片（如位运算、闭包、异常处理）

## 常见问题

### 1. 编译提示 `pushUrl` / `back` 已弃用

请改用 `this.getUIContext().getRouter()` 的新接口方式，避免旧 API 警告。

### 2. 提示 `@Entry` 数量不正确

检查 `main_pages.json` 配置的每个页面文件，确保仅有一个 `@Entry` 组件。

### 3. 顶部或底部被系统栏遮挡

确认沉浸式配置与页面安全区计算同时生效（见上文“UI 与安全区说明”）。

## 后续扩展建议

- 新增“异常处理与错误边界”页面
- 增加“对象与类（class/interface）”页面
- 加入简单单元测试（Hypium）
- 增加中英双语文案切换

## License

本项目采用 GNU General Public License v3.0（GPL-3.0），详见 [LICENSE](LICENSE)。

