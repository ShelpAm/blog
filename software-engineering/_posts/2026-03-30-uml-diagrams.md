---
title: Software Engineering - UML diagrams
mermaid: true
---

UML (Universe Modelling Language) is a language used to model software systems.
It is a graphical language that allows developers to visualize the structure and
behavior of a software system.

In this article, we will discuss the different types of UML diagrams and their
uses.

## Types of UML diagrams

UML diagrams are used to represent different aspects of a software system, such
as its structure, behavior, and interactions.

UML diagrams can be categorized into four main types based on their use phase:
- 需求分析阶段
    - 用例图 (Use Case Diagram)
    - 数据流图 (Data Flow Diagram)
    - 活动图 (Activity Diagram)
- 系统设计阶段
    - 类图 (Class Diagram)
    - 序列图 (Sequence Diagram)
    - 状态图 (State Diagram)
    - 组件图 (Component Diagram)
    - 包图 (Package Diagram)
    - 时序图 (Sequence Diagram)
    - 实体-关系图 (Entity-Relationship Diagram)
- 实现与测试阶段
    - 流程图 (Flowchart)
- 部署阶段
    - 部署图 (Deployment Diagram)

## 需求分析阶段

### Activity Diagram

Currently (2026-03-30), activity diagram hasn't been supported by Mermaid. So
just use flowchart to replace it.

```mermaid
flowchart TD

    %% ===== 用户泳道 =====
    subgraph 用户
        U_start((开始))
        U_select[选择航班]
        U_decision{是否继续}
        U_pay[支付]
        U_end((结束))
    end

    %% ===== 系统泳道 =====
    subgraph 系统
        S_check{有无票}
        S_no[提示航班无余票]
        S_confirm[确认机票信息]

        %% 并行开始
        S_parallel_start[[ ]]
        S_update[修改机票状态]
        S_record[生成订票记录]
        S_parallel_end[[ ]]

        S_end((结束))
    end

    %% ===== 流程连接 =====
    U_start --> U_select
    U_select --> S_check

    S_check -->|无余票| S_no
    S_no --> U_select

    S_check -->|有余票| S_confirm
    S_confirm --> U_decision

    U_decision -->|否| U_end
    U_decision -->|是| U_pay

    U_pay --> S_parallel_start

    %% 并行
    S_parallel_start --> S_update
    S_parallel_start --> S_record

    S_update --> S_parallel_end
    S_record --> S_parallel_end

    S_parallel_end --> S_end
```

## 系统设计阶段

### State Diagram

Mermaid:
```mermaid
stateDiagram
    [*] --> 未开始售票
    未开始售票 --> 已开始售票 : when(飞行时间-当前时间<br><2个月)

    已开始售票 --> 已停止售票 : when(飞行时间-当前时间<br><1天)
    state 已停止售票 {
        [*] --> 等待起飞
        等待起飞 --> notified : 系统通知
        state notified <<choice>>

        notified --> 推迟起飞 : [航班推迟]
        notified --> 已取消 : [航班取消]
        notified --> 已起飞 : [else]

        state 推迟起飞 {
            A : do / 通知乘客
        }
        推迟起飞 --> 等待起飞
        已取消 --> [*]
        已起飞 --> [*]
    }

    已停止售票 --> [*]
```

### Component Diagram

Not officially supported by Mermaid:
```mermaid
```

## 部署阶段

### Deployment Diagram

Not officially supported by Mermaid:
```mermaid
```
