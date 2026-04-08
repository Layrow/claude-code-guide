# Code Review Finding Template

在记录代码评审中发现的每个问题时，使用这个模板。

---

## Issue: [TITLE]

### Severity
- [ ] Critical（阻塞部署）
- [ ] High（应在合并前修复）
- [ ] Medium（应尽快修复）
- [ ] Low（有空再优化）

### Category
- [ ] Security
- [ ] Performance
- [ ] Code Quality
- [ ] Maintainability
- [ ] Testing
- [ ] Design Pattern
- [ ] Documentation

### Location
**File:** `src/components/UserCard.tsx`

**Lines:** 45-52

**Function/Method:** `renderUserDetails()`

### Issue Description

**What:** 描述这个问题是什么。

**Why it matters:** 解释它的影响，以及为什么需要修复。

**Current behavior:** 展示当前有问题的代码或行为。

**Expected behavior:** 说明理想情况下应该怎样。

### Code Example

#### Current (Problematic)

```typescript
// Shows the N+1 query problem
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // Query per user!
  renderUserPosts(posts);
});
```

#### Suggested Fix

```typescript
// Optimized with JOIN query
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Impact Analysis

| Aspect | Impact | Severity |
|--------|--------|----------|
| Performance | 20 个用户就会触发 100+ 次查询 | High |
| User Experience | 页面加载变慢 | High |
| Scalability | 在规模扩大时会崩 | Critical |
| Maintainability | 难以排查和调试 | Medium |

### Related Issues

- `AdminUserList.tsx` 第 120 行有类似问题
- Related PR: #456
- Related issue: #789

### Additional Resources

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)

### Reviewer Notes

- 这是这个代码库里比较常见的一类模式
- 可以考虑把这类问题补进代码风格指南
- 也许值得抽一个 helper function

### Author Response (for feedback)

*由代码作者填写：*

- [ ] 已在以下 commit 中修复：`abc123`
- [ ] 修复状态：Complete / In Progress / Needs Discussion
- [ ] 问题或疑虑：（描述）
