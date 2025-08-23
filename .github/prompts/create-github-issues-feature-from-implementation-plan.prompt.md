---
mode: 'agent'
description: 'Create GitHub Issues from implementation plan phases using feature_request.yml or chore_request.yml templates.'
tools: ['codebase', 'search', 'github', 'create_issue', 'search_issues', 'update_issue']
---
# Create GitHub Issue from Implementation Plan

Create GitHub Issues for the implementation plan at `${file}`.

## Process

1. Analyze plan file to identify phases
2. Check existing issues using `search_issues`
3. Create new issue detailing each phase using `create_issue` or update existing with `update_issue`

## Requirements

- Clear, structured titles and descriptions
- Include only changes required by the plan
- Verify against existing issues before creation

## Issue Content

- Title: Implementation plan
- Description: Phases details, requirements, and context
- Labels: Appropriate for issue type (feature/chore)
