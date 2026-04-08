# Code Smells Catalog

基于 Martin Fowler《*Refactoring*（第 2 版）》整理的 code smells 参考清单。Code smell 是更深层问题的外在症状，它意味着你的代码设计可能存在值得改进的地方。

> "A code smell is a surface indication that usually corresponds to a deeper problem in the system." — Martin Fowler

---

## Bloaters

这类 code smell 表示某些结构已经膨胀得过大，难以有效处理。

### Long Method

**Signs:**
- 方法超过 30-50 行
- 必须滚动很久才能看完整个方法
- 有多层嵌套
- 需要靠注释解释“这一段在做什么”

**Why it's bad:**
- 难理解
- 难以单独测试
- 修改容易带来连带影响
- 重复逻辑更容易藏在里面

**Refactorings:**
- Extract Method
- Replace Temp with Query
- Introduce Parameter Object
- Replace Method with Method Object
- Decompose Conditional

**Example (Before):**
```javascript
function processOrder(order) {
  // Validate order (20 lines)
  if (!order.items) throw new Error('No items');
  if (order.items.length === 0) throw new Error('Empty order');
  // ... more validation

  // Calculate totals (30 lines)
  let subtotal = 0;
  for (const item of order.items) {
    subtotal += item.price * item.quantity;
  }
  // ... tax, shipping, discounts

  // Send notifications (20 lines)
  // ... email logic
}
```

**Example (After):**
```javascript
function processOrder(order) {
  validateOrder(order);
  const totals = calculateOrderTotals(order);
  sendOrderNotifications(order, totals);
  return { order, totals };
}
```

---

### Large Class

**Signs:**
- 类中实例变量过多（>7-10）
- 方法很多（>15-20）
- 类名过于模糊（如 Manager、Handler、Processor）
- 方法并不会用到所有实例变量

**Why it's bad:**
- 违反单一职责原则
- 难测试
- 修改一个功能时会波及无关功能
- 很难复用其中一部分

**Refactorings:**
- Extract Class
- Extract Subclass
- Extract Interface

**Detection:**
```
Lines of code > 300
Number of methods > 15
Number of fields > 10
```

---

### Primitive Obsession

**Signs:**
- 用原始类型表示领域概念（例如 string 表示 email，int 表示金额）
- 用原始类型数组而不是对象
- 用字符串常量表示类型码
- 存在 magic numbers / magic strings

**Why it's bad:**
- 无法在类型层面做校验
- 逻辑散落在整个代码库
- 很容易传错值
- 领域概念没有被正确建模

**Refactorings:**
- Replace Primitive with Object
- Replace Type Code with Class
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**Example (Before):**
```javascript
const user = {
  email: 'john@example.com',     // Just a string
  phone: '1234567890',           // Just a string
  status: 'active',              // Magic string
  balance: 10050                 // Cents as integer
};
```

**Example (After):**
```javascript
const user = {
  email: new Email('john@example.com'),
  phone: new PhoneNumber('1234567890'),
  status: UserStatus.ACTIVE,
  balance: Money.cents(10050)
};
```

---

### Long Parameter List

**Signs:**
- 方法参数达到 4 个以上
- 有些参数总是一起出现
- 用布尔标志来改变方法行为
- 经常传 `null` / `undefined`

**Why it's bad:**
- 调用起来容易出错
- 参数顺序容易混淆
- 暗示方法承担了太多职责
- 后续再加参数会越来越难

**Refactorings:**
- Introduce Parameter Object
- Preserve Whole Object
- Replace Parameter with Method Call
- Remove Flag Argument

**Example (Before):**
```javascript
function createUser(firstName, lastName, email, phone,
                    street, city, state, zip,
                    isAdmin, isActive, createdBy) {
  // ...
}
```

**Example (After):**
```javascript
function createUser(personalInfo, address, options) {
  // personalInfo: { firstName, lastName, email, phone }
  // address: { street, city, state, zip }
  // options: { isAdmin, isActive, createdBy }
}
```

---

### Data Clumps

**Signs:**
- 相同的 3 个以上字段总是一起出现
- 一组参数总是一起传递
- 类中有些字段子集明显属于同一个概念

**Why it's bad:**
- 处理逻辑容易重复
- 说明缺少抽象
- 后续扩展更困难
- 通常暗示有隐藏类

**Refactorings:**
- Extract Class
- Introduce Parameter Object
- Preserve Whole Object

**Example:**
```javascript
// Data clump: (x, y, z) coordinates
function movePoint(x, y, z, dx, dy, dz) { }
function scalePoint(x, y, z, factor) { }
function distanceBetween(x1, y1, z1, x2, y2, z2) { }

// Extract Point3D class
class Point3D {
  constructor(x, y, z) { }
  move(delta) { }
  scale(factor) { }
  distanceTo(other) { }
}
```

---

## Object-Orientation Abusers

这类 smell 往往意味着 OOP 原则使用不完整或方式不正确。

### Switch Statements

**Signs:**
- 很长的 switch/case 或 if/else 链
- 同样的 switch 在多个地方重复出现
- 基于 type code 做分支
- 新增一种情况时，需要到处改

**Why it's bad:**
- 违反开闭原则
- 所有 switch 都要跟着改
- 很难扩展
- 往往暗示本该使用多态

**Refactorings:**
- Replace Conditional with Polymorphism
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**Example (Before):**
```javascript
function calculatePay(employee) {
  switch (employee.type) {
    case 'hourly':
      return employee.hours * employee.rate;
    case 'salaried':
      return employee.salary / 12;
    case 'commissioned':
      return employee.sales * employee.commission;
  }
}
```

**Example (After):**
```javascript
class HourlyEmployee {
  calculatePay() {
    return this.hours * this.rate;
  }
}

class SalariedEmployee {
  calculatePay() {
    return this.salary / 12;
  }
```
