// Example Vercel Function for AI word generation
// Based on research from .copilot-tracking/research/20250927-ai-generation-word-definitions-research.md
import { openai } from '@ai-sdk/openai';
import { generateObject } from 'ai';
import { z } from 'zod';

// Define the expected word structure
const WordSchema = z.object({
  word: z.string().min(4).max(8),
  definitions: z.array(z.string()).min(2).max(3)
});

// Type definition for the response
interface WordResponse {
  data: {
    word: string;
    definitions: string[];
  };
  timestamp: string;
  version: string;
}

interface ErrorResponse {
  error: string;
  code: string;
  fallback?: boolean;
}

export async function POST(req: Request): Promise<Response> {
  try {
    // Generate structured word object using AI SDK
    const { object } = await generateObject({
      model: openai('gpt-4o-mini'),
      prompt: 'Generate a word guessing game entry: single noun (4-8 letters) with 2-3 clear definitions appropriate for family game',
      schema: WordSchema,
    });

    const response: WordResponse = {
      data: object,
      timestamp: new Date().toISOString(),
      version: '1.0'
    };

    return Response.json(response);
  } catch (error) {
    console.error('AI word generation failed:', error);
    
    const errorResponse: ErrorResponse = {
      error: 'Generation failed',
      code: 'AI_ERROR',
      fallback: true
    };

    return Response.json(errorResponse, { status: 500 });
  }
}

// Health check endpoint
export async function GET(): Promise<Response> {
  return Response.json({
    status: 'healthy',
    service: 'word-generation',
    timestamp: new Date().toISOString()
  });
}

// CORS preflight handler
export async function OPTIONS(): Promise<Response> {
  return new Response(null, {
    status: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      'Access-Control-Max-Age': '86400',
    },
  });
}