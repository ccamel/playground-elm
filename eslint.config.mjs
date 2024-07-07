import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { FlatCompat } from '@eslint/eslintrc';
import { fixupConfigRules, includeIgnoreFile } from '@eslint/compat';
import js from '@eslint/js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const gitignorePath = path.resolve(__dirname, '.gitignore');

const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended
});

export default [
  includeIgnoreFile(gitignorePath),
  ...fixupConfigRules(compat.extends('eslint:recommended', 'prettier')),
  ...compat.config({
    env: {
      browser: true,
      node: true,
      es6: true
    },
    parserOptions: {
      ecmaVersion: 2020,
      sourceType: 'module'
    },
    plugins: ['prettier'],
    extends: ['prettier'],
    rules: {
      'no-unused-vars': ['error', { caughtErrors: 'none' }],
      'prettier/prettier': 2,
      strict: [2, 'global'],
      'global-strict': [0, 'always']
    }
  })
];
