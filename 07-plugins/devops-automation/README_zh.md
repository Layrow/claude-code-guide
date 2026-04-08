# DevOps Automation Plugin

这个 plugin 将一组面向 DevOps 自动化的 commands 与 agents 打包在一起，适用于部署、回滚、事故响应和系统状态检查。

## Included Commands

- `Deploy` - 执行部署流程
- `Rollback` - 回滚到上一版本
- `System Status` - 检查整体系统健康状态
- `Incident Response` - 按结构化流程处理生产事故

## Included Agents

- `deployment-specialist` - 负责部署相关操作
- `incident-commander` - 负责事故响应协调
- `alert-analyzer` - 负责监控告警与系统指标分析

## Typical Use Cases

- 自动化生产发布
- 出现故障时快速回滚
- 结构化处理 incident
- 对系统健康状况做定期检查
