const crypto = require('crypto');
const config = require('../config');

/**
 * 生成符合规范的Trace ID
 * 格式: [服务前缀]-[时间戳]-[随机字符串]
 * @returns {string} 生成的Trace ID
 */
function generateTraceId() {
  const timestamp = Date.now();
  const randomStr = crypto.randomBytes(8).toString('hex');
  return `${config.tracing.serviceName}-${timestamp}-${randomStr}`;
}

/**
 * 从请求头中提取Trace ID，如果没有则生成新的
 * @param {Object} headers HTTP请求头
 * @returns {string} Trace ID
 */
function getOrGenerateTraceId(headers) {
  return headers['x-trace-id'] || generateTraceId();
}

module.exports = {
  generateTraceId,
  getOrGenerateTraceId
};