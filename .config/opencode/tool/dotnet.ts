import { tool } from '@opencode-ai/plugin/tool';
import { spawn } from 'child_process';

interface CommandResult {
  command: string;
  exitCode: number | null;
  status: 'success' | 'failed' | 'error';
  durationMs: number;
  stdout: string;
  stderr: string;
  truncated: boolean;
  errorMessage?: string;
}

const MAX_BUFFER = 8000; // cap each stream so we don't explode return size

function runDotnet(subcommand: 'build' | 'test'): Promise<string> {
  const started = Date.now();
  return new Promise((resolve) => {
    let stdoutBuf = '';
    let stderrBuf = '';
    let truncated = false;

    const child = spawn('dotnet', [subcommand]);

    const finish = (exitCode: number | null, errorMessage?: string) => {
      const result: CommandResult = {
        command: `dotnet ${subcommand}`,
        exitCode,
        status: exitCode === 0 ? 'success' : errorMessage ? 'error' : 'failed',
        durationMs: Date.now() - started,
        stdout: stdoutBuf.trim(),
        stderr: stderrBuf.trim(),
        truncated,
        errorMessage,
      };
      resolve(JSON.stringify(result));
    };

    child.stdout?.setEncoding('utf8');
    child.stderr?.setEncoding('utf8');

    child.stdout?.on('data', (chunk: string) => {
      if (stdoutBuf.length < MAX_BUFFER) {
        stdoutBuf += chunk;
        if (stdoutBuf.length > MAX_BUFFER) {
          stdoutBuf = stdoutBuf.slice(0, MAX_BUFFER) + '\n...[truncated]';
          truncated = true;
        }
      }
    });

    child.stderr?.on('data', (chunk: string) => {
      if (stderrBuf.length < MAX_BUFFER) {
        stderrBuf += chunk;
        if (stderrBuf.length > MAX_BUFFER) {
          stderrBuf = stderrBuf.slice(0, MAX_BUFFER) + '\n...[truncated]';
          truncated = true;
        }
      }
    });

    child.on('error', (err) => {
      finish(null, err.message);
    });

    child.on('close', (code) => {
      finish(code ?? null);
    });
  });
}

export const build = tool({
  description: 'Run `dotnet build` in the current working directory (returns JSON with exitCode, stdout, stderr)',
  args: {},
  async execute() {
    return await runDotnet('build');
  },
});

export const test = tool({
  description: 'Run `dotnet test` in the current working directory (returns JSON with exitCode, stdout, stderr)',
  args: {},
  async execute() {
    return await runDotnet('test');
  },
});
