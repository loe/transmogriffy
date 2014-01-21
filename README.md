# Create a users.json
```json
{
  "W. Andrew Loe III": "loe"
}
```

```
# Export the Environment
```bash
export LIGHTHOUSE_PATH=/Users/you/Downloads/project
export GITHUB_PATH=/Users/you/Downloads/project-munged
export GITHUB_USER_MAP_PATH=/Users/you/Desktop/users.json
```

# Rake
`bundle exec rake migrate`
