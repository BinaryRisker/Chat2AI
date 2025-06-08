const { trace } = require('@opentelemetry/api');
const config = require('../config');
const { getOrGenerateTraceId } = require('../utils/trace');

function tracingMiddleware(req, res, next) {
  if (!config.tracing.enabled) return next();

  // 获取或生成Trace ID并设置到请求头
  const traceId = getOrGenerateTraceId(req.headers);
  req.headers['x-trace-id'] = traceId;

  const tracer = trace.getTracer(config.tracing.serviceName);
  const span = tracer.startSpan(`HTTP ${req.method} ${req.path}`);
  
  // 设置Trace ID到Span
  span.setAttribute('trace.id', traceId);
  
  // 设置Span属性
  span.setAttributes({
    'http.method': req.method,
    'http.path': req.path,
    'http.host': req.headers.host,
  });

  // 将Span附加到请求对象
  req.span = span;

  // 响应完成时结束Span
  res.on('finish', () => {
    span.setAttribute('http.status_code', res.statusCode);
    span.setStatus({
      code: res.statusCode >= 400 ? 
        trace.SpanStatusCode.ERROR : 
        trace.SpanStatusCode.OK,
    });
    span.end();
  });

  next();
}

module.exports = tracingMiddleware;