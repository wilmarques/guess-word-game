// Health check endpoint for monitoring
export async function GET(): Promise<Response> {
  const health = {
    status: 'healthy',
    timestamp: new Date().toISOString(),
    service: 'guess-word-game-api',
    version: '1.0.0',
    environment: process.env.VERCEL_ENV || 'development',
    uptime: process.uptime?.() || 0
  };

  return Response.json(health);
}

// Also support POST for health checks
export async function POST(): Promise<Response> {
  return GET();
}